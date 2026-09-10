import { NextRequest, NextResponse } from 'next/server';
import crypto from 'crypto';
import { isMongoConfigured, getMongoDb } from '@/lib/db/mongodb';
import { isSmtpConfigured, sendPasswordResetEmail } from '@/lib/email/mailer';
import { getInMemoryUser, saveInMemoryResetToken } from '@/lib/auth/in-memory-users';

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { email } = body;

    if (!email || typeof email !== 'string' || !email.trim()) {
      return NextResponse.json({ error: 'Please provide a valid email address' }, { status: 400 });
    }

    const normalizedEmail = email.trim().toLowerCase();
    let userDisplayName: string | undefined;
    let userExists = false;

    // 1. Check MongoDB for user existence
    if (isMongoConfigured()) {
      try {
        const db = await getMongoDb();
        const userDoc = await db.collection('users').findOne({ email: normalizedEmail });
        if (userDoc) {
          userExists = true;
          userDisplayName = userDoc.display_name;
        }
      } catch (mongoErr: any) {
        console.warn('MongoDB lookup error in forgot-password:', mongoErr.message);
      }
    }

    // 2. Check fallback store / default admin
    if (!userExists) {
      const inMemUser = getInMemoryUser(normalizedEmail);
      if (inMemUser) {
        userExists = true;
        userDisplayName = inMemUser.display_name;
      } else if (
        normalizedEmail === 'admin@tn10.udhees.com' ||
        normalizedEmail === 'admin.curriculum@tn10.udhees.com'
      ) {
        userExists = true;
        userDisplayName = 'Administrator';
      }
    }

    if (!userExists) {
      return NextResponse.json(
        { error: 'No account registered with this email address. Please create an account.' },
        { status: 404 }
      );
    }

    // 3. Generate cryptographic reset token (1 hour validity)
    const token = crypto.randomBytes(32).toString('hex');
    const expiresAt = new Date(Date.now() + 60 * 60 * 1000); // 1 hour

    // 4. Persist reset token
    if (isMongoConfigured()) {
      try {
        const db = await getMongoDb();
        await db.collection('password_resets').updateOne(
          { email: normalizedEmail },
          {
            $set: {
              token,
              expires_at: expiresAt,
              updated_at: new Date(),
            },
          },
          { upsert: true }
        );
      } catch (mongoErr: any) {
        console.warn('MongoDB password_resets write error:', mongoErr.message);
      }
    }
    saveInMemoryResetToken(normalizedEmail, token);

    // 5. Construct Reset URL
    const baseUrl = process.env.NEXT_PUBLIC_APP_URL || 'http://localhost:3000';
    const resetLink = `${baseUrl}/auth?mode=reset-confirm&token=${token}&email=${encodeURIComponent(normalizedEmail)}`;

    // 6. Deliver email via SMTP
    if (isSmtpConfigured()) {
      const mailResult = await sendPasswordResetEmail(normalizedEmail, resetLink, userDisplayName);
      if (mailResult.success) {
        return NextResponse.json({
          success: true,
          message: 'Password reset link sent to your email. Please check your inbox and spam folder.',
        });
      } else {
        return NextResponse.json(
          {
            error: mailResult.error || 'Failed to dispatch password reset email',
            smtpConfigured: true,
            resetLink,
          },
          { status: 500 }
        );
      }
    }

    // 7. If SMTP is not yet configured in Coolify/environment
    return NextResponse.json({
      success: true,
      smtpConfigured: false,
      message:
        'Password reset link generated. Note: SMTP email service is not yet configured on this server (please configure SMTP_HOST, SMTP_USER, and SMTP_PASS in Coolify).',
      resetLink,
    });
  } catch (err: any) {
    console.error('Forgot password error:', err);
    return NextResponse.json({ error: err.message || 'Failed to process request' }, { status: 500 });
  }
}
