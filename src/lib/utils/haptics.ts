// ============================================================================
// Tactile Web Haptics Utility
// Provides subtle vibration feedback for mobile PWA interactions (e.g. checkoffs)
// ============================================================================

export type HapticType = 'light' | 'medium' | 'success' | 'warning' | 'selection';

export function triggerHaptic(type: HapticType = 'light') {
  if (typeof window === 'undefined' || !('navigator' in window) || !('vibrate' in navigator)) {
    return;
  }

  try {
    switch (type) {
      case 'light':
        navigator.vibrate(10);
        break;
      case 'selection':
        navigator.vibrate(15);
        break;
      case 'medium':
        navigator.vibrate(25);
        break;
      case 'success':
        // Double tap pulse
        navigator.vibrate([15, 40, 20]);
        break;
      case 'warning':
        navigator.vibrate([30, 50, 30]);
        break;
      default:
        navigator.vibrate(10);
    }
  } catch {
    // Silently ignore if permission denied or unsupported
  }
}
