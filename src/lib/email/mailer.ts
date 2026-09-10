// ============================================================================
// Email Delivery Service (SMTP via Nodemailer)
// Supports Coolify environment variables: SMTP_HOST, SMTP_PORT, SMTP_USER, SMTP_PASS, SMTP_FROM
// Fallback support for standard mail envs: MAIL_HOST, MAIL_PORT, etc.
// ============================================================================

import nodemailer from 'nodemailer';

export function isSmtpConfigured(): boolean {
  const host = process.env.SMTP_HOST || process.env.MAIL_HOST;
  const user = process.env.SMTP_USER || process.env.MAIL_USERNAME;
  const pass = process.env.SMTP_PASS || process.env.MAIL_PASSWORD;
  return Boolean(host && user && pass);
}

export function getMailTransporter() {
  const host = process.env.SMTP_HOST || process.env.MAIL_HOST;
  const port = Number(process.env.SMTP_PORT || process.env.MAIL_PORT || 587);
  const user = process.env.SMTP_USER || process.env.MAIL_USERNAME;
  const pass = process.env.SMTP_PASS || process.env.MAIL_PASSWORD;
  const secure = process.env.SMTP_SECURE === 'true' || port === 465;

  if (!host || !user || !pass) {
    return null;
  }

  return nodemailer.createTransport({
    host,
    port,
    secure,
    auth: {
      user,
      pass,
    },
  });
}

export function getSenderEmail(): string {
  return (
    process.env.SMTP_FROM ||
    process.env.MAIL_FROM_ADDRESS ||
    process.env.SMTP_USER ||
    '"TN Class 10 Study PWA" <noreply@tn10.udhees.com>'
  );
}

export interface SendResetEmailResult {
  success: boolean;
  messageId?: string;
  previewUrl?: string | false;
  error?: string;
}

export async function sendPasswordResetEmail(
  toEmail: string,
  resetLink: string,
  displayName?: string
): Promise<SendResetEmailResult> {
  const transporter = getMailTransporter();

  if (!transporter) {
    return {
      success: false,
      error:
        'SMTP email service is not configured on the server. Please set SMTP_HOST, SMTP_PORT, SMTP_USER, and SMTP_PASS in your environment.',
    };
  }

  const studentName = displayName || toEmail.split('@')[0];
  const from = getSenderEmail();

  const htmlContent = `
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Reset Your TN Class 10 Study Password</title>
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
      background-color: #070a12;
      color: #e2e8f0;
      margin: 0;
      padding: 24px;
    }
    .card {
      max-width: 520px;
      margin: 0 auto;
      background-color: #0f172a;
      border: 1px solid #1e293b;
      border-radius: 20px;
      padding: 32px;
      box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.5);
    }
    .badge {
      display: inline-block;
      padding: 4px 12px;
      border-radius: 9999px;
      background-color: rgba(59, 130, 246, 0.15);
      border: 1px solid rgba(59, 130, 246, 0.3);
      color: #60a5fa;
      font-size: 11px;
      font-weight: 700;
      letter-spacing: 0.5px;
      text-transform: uppercase;
      margin-bottom: 16px;
    }
    h1 {
      color: #ffffff;
      font-size: 22px;
      margin-top: 0;
      margin-bottom: 12px;
      font-weight: 800;
    }
    p {
      color: #94a3b8;
      font-size: 14px;
      line-height: 1.6;
      margin: 12px 0;
    }
    .button {
      display: inline-block;
      background: linear-gradient(135deg, #2563eb, #4f46e5);
      color: #ffffff !important;
      text-decoration: none;
      padding: 14px 28px;
      border-radius: 12px;
      font-weight: 700;
      font-size: 14px;
      margin: 20px 0;
      text-align: center;
    }
    .link-fallback {
      background-color: #070a12;
      border: 1px solid #1e293b;
      border-radius: 8px;
      padding: 12px;
      font-family: monospace;
      font-size: 11px;
      color: #38bdf8;
      word-break: break-all;
      margin-top: 8px;
    }
    .footer {
      border-top: 1px solid #1e293b;
      margin-top: 24px;
      padding-top: 16px;
      font-size: 11px;
      color: #64748b;
      text-align: center;
    }
  </style>
</head>
<body>
  <div class="card">
    <div class="badge">TN State Board • Class 10 Study PWA</div>
    <h1>Password Reset Request</h1>
    <p>Hello <strong>${studentName}</strong>,</p>
    <p>We received a request to reset the password for your account associated with <strong>${toEmail}</strong>.</p>
    <p>Click the button below to choose a new password. This link is valid for <strong>1 hour</strong>.</p>
    <div style="text-align: center;">
      <a href="${resetLink}" class="button" target="_blank">Reset My Password</a>
    </div>
    <p style="font-size: 12px;">If the button above does not work, copy and paste this link into your browser:</p>
    <div class="link-fallback">${resetLink}</div>
    <p style="font-size: 12px; color: #64748b; margin-top: 20px;">
      If you did not request a password reset, you can safely ignore this email. Your password will remain unchanged.
    </p>
    <div class="footer">
      Tamil Nadu Class 10 Samacheer Kalvi Study Tracker & Revision Sprints<br>
      Automated system email • Please do not reply directly to this message
    </div>
  </div>
</body>
</html>
  `;

  const textContent = `
Hello ${studentName},

We received a request to reset the password for your TN Class 10 Study account (${toEmail}).

To reset your password, visit the following link:
${resetLink}

This link will expire in 1 hour.

If you did not request this, you can safely ignore this email.

Tamil Nadu Class 10 Samacheer Kalvi Study Tracker
  `.trim();

  try {
    const info = await transporter.sendMail({
      from,
      to: toEmail,
      subject: 'Reset your TN Class 10 Study password',
      text: textContent,
      html: htmlContent,
    });

    return {
      success: true,
      messageId: info.messageId,
    };
  } catch (err: any) {
    console.error('Nodemailer sendMail error:', err);
    return {
      success: false,
      error: `Failed to deliver email: ${err.message}`,
    };
  }
}
