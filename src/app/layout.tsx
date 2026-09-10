import type { Metadata, Viewport } from "next";
import "./globals.css";
import { AuthProvider } from "@/lib/auth/auth-context";
import { I18nProvider } from "@/lib/i18n/i18n-context";
import { StudyProvider } from "@/lib/store/study-context";
import { Header } from "@/components/layout/Header";
import { Navigation } from "@/components/layout/Navigation";
import { PwaInstallPrompt } from "@/components/pwa/PwaInstallPrompt";
import { PwaNetworkBanner } from "@/components/pwa/PwaNetworkBanner";

export const metadata: Metadata = {
  title: "TN Class 10 Study PWA | Tamil Nadu State Board Exam Checklist & Notes",
  description: "Personal study checklist, understanding tracker, revision queue, and notes app for Tamil Nadu State Board Class 10 students (2025/2024 Editions, 5 Canonical Subjects).",
  manifest: "/manifest.json",
  appleWebApp: {
    capable: true,
    statusBarStyle: "black-translucent",
    title: "TN10 Study",
  },
  icons: {
    icon: "/icons/icon-192.png",
    apple: "/icons/icon-192.png",
  },
};

export const viewport: Viewport = {
  themeColor: "#070a12",
  width: "device-width",
  initialScale: 1,
  maximumScale: 1,
  userScalable: false,
  viewportFit: "cover",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="dark">
      <head>
        <link rel="apple-touch-icon" href="/icons/icon-192.png" />
        <meta name="mobile-web-app-capable" content="yes" />
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
      </head>
      <body className="font-sans antialiased text-slate-100 bg-[#070a12] selection:bg-blue-600 selection:text-white pb-28 md:pb-12">
        <AuthProvider>
          <I18nProvider>
            <StudyProvider>
              <div className="min-h-screen flex flex-col">
                <PwaNetworkBanner />
                <Header />
                <Navigation />
                <main className="flex-1 max-w-7xl w-full mx-auto px-3 sm:px-6 lg:px-8 py-4 sm:py-6">
                  {children}
                </main>
                <PwaInstallPrompt />
              </div>
            </StudyProvider>
          </I18nProvider>
        </AuthProvider>
      </body>
    </html>
  );
}
