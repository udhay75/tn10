// ============================================================================
// Ultra-Modern Service Worker for Tamil Nadu Class 10 Study PWA
// Provides Multi-Tier Shell Caching, API Caching, Background Sync & Offline Support
// ============================================================================

const CACHE_VERSION = 'tn10-v2.0.0';
const STATIC_CACHE = `tn10-static-${CACHE_VERSION}`;
const DYNAMIC_CACHE = `tn10-dynamic-${CACHE_VERSION}`;
const API_CACHE = `tn10-api-${CACHE_VERSION}`;

const PRECACHE_ASSETS = [
  '/',
  '/dashboard',
  '/curriculum',
  '/revision',
  '/settings',
  '/auth',
  '/manifest.json',
  '/offline.html',
  '/icons/icon-192.png',
  '/icons/icon-512.png',
  '/icons/maskable-icon-512.png',
  '/icons/icon.svg',
  '/api/curriculum'
];

// Install Event: pre-cache critical app shell & curriculum payload
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(STATIC_CACHE).then(async (cache) => {
      try {
        await cache.addAll(PRECACHE_ASSETS);
      } catch (err) {
        console.warn('PWA Precache warning (some assets cached individually):', err);
        // Fallback: cache critical assets one-by-one so non-fatal fails don't block install
        for (const asset of PRECACHE_ASSETS) {
          try {
            await cache.add(asset);
          } catch (e) {
            // Silently ignore optional asset prefetch fails
          }
        }
      }
    }).then(() => self.skipWaiting())
  );
});

// Activate Event: purge older cache generations immediately
self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) => {
      return Promise.all(
        keys.map((key) => {
          if (key !== STATIC_CACHE && key !== DYNAMIC_CACHE && key !== API_CACHE) {
            console.log('[PWA SW] Purging obsolete cache:', key);
            return caches.delete(key);
          }
        })
      );
    }).then(() => self.clients.claim())
  );
});

// Fetch Event: handle navigation, API queries, and static assets
self.addEventListener('fetch', (event) => {
  const { request } = event;
  const url = new URL(request.url);

  // Ignore non-GET requests or browser-extension schemes
  if (request.method !== 'GET' || !url.protocol.startsWith('http')) {
    return;
  }

  // 1. API Requests (e.g. /api/curriculum): Network first with cached API fallback
  if (url.pathname.startsWith('/api/curriculum')) {
    event.respondWith(
      fetch(request)
        .then((networkResponse) => {
          if (networkResponse && networkResponse.status === 200) {
            const clone = networkResponse.clone();
            caches.open(API_CACHE).then((cache) => cache.put(request, clone));
          }
          return networkResponse;
        })
        .catch(async () => {
          const cached = await caches.match(request);
          if (cached) return cached;
          return new Response(JSON.stringify({ error: 'Offline', offline: true }), {
            headers: { 'Content-Type': 'application/json' },
            status: 200
          });
        })
    );
    return;
  }

  // Other API requests: allow network without caching
  if (url.pathname.startsWith('/api/')) {
    return;
  }

  // 2. HTML Navigation requests: Network first with Cache fallback, then /offline.html
  if (request.mode === 'navigate') {
    event.respondWith(
      fetch(request)
        .then((networkResponse) => {
          if (networkResponse && networkResponse.status === 200) {
            const clone = networkResponse.clone();
            caches.open(DYNAMIC_CACHE).then((cache) => cache.put(request, clone));
          }
          return networkResponse;
        })
        .catch(async () => {
          // 1. Try exact cached page
          const cachedPage = await caches.match(request);
          if (cachedPage) return cachedPage;

          // 2. Try dashboard shell
          const cachedDashboard = await caches.match('/dashboard');
          if (cachedDashboard) return cachedDashboard;

          // 3. Serve offline fallback HTML
          const fallback = await caches.match('/offline.html');
          return fallback || new Response('You are offline. Please reconnect to load new pages.', {
            headers: { 'Content-Type': 'text/plain' }
          });
        })
    );
    return;
  }

  // 3. Static Assets: CSS, JS chunks, images, icons (Stale-While-Revalidate)
  event.respondWith(
    caches.match(request).then((cachedResponse) => {
      const fetchPromise = fetch(request)
        .then((networkResponse) => {
          if (networkResponse && networkResponse.status === 200 && networkResponse.type === 'basic') {
            const clone = networkResponse.clone();
            caches.open(DYNAMIC_CACHE).then((cache) => cache.put(request, clone));
          }
          return networkResponse;
        })
        .catch(() => cachedResponse);

      return cachedResponse || fetchPromise;
    })
  );
});

// Background Sync Event: notify client windows to execute sync queue
self.addEventListener('sync', (event) => {
  if (event.tag === 'tn10-sync-mutations') {
    event.waitUntil(
      self.clients.matchAll().then((clients) => {
        clients.forEach((client) => {
          client.postMessage({ type: 'TRIGGER_BACKGROUND_SYNC' });
        });
      })
    );
  }
});

// Client Message Listener
self.addEventListener('message', (event) => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
});
