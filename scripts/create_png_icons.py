#!/usr/bin/env python3
"""
Pure Python PNG generator for PWA icons using only standard library (zlib, struct).
Generates:
- public/icons/icon-512.png
- public/icons/icon-192.png
- public/icons/maskable-icon-512.png
"""

import zlib
import struct
import math
import os

def make_png(width, height, get_pixel_func):
    """
    Creates PNG binary bytes given width, height, and a function (x, y) -> (r, g, b, a)
    """
    raw_rows = bytearray()
    for y in range(height):
        raw_rows.append(0)  # Filter type 0 (None)
        for x in range(width):
            r, g, b, a = get_pixel_func(x, y, width, height)
            raw_rows.extend([r, g, b, a])

    compressed = zlib.compress(bytes(raw_rows), 9)

    def chunk(chunk_type, data):
        c = chunk_type + data
        crc = zlib.crc32(c) & 0xffffffff
        return struct.pack(">I", len(data)) + c + struct.pack(">I", crc)

    png = b"\x89PNG\r\n\x1a\n"
    # IHDR
    png += chunk(b"IHDR", struct.pack(">IIBBBBB", width, height, 8, 6, 0, 0, 0))
    # IDAT
    png += chunk(b"IDAT", compressed)
    # IEND
    png += chunk(b"IEND", b"")
    return png

def render_icon(x, y, w, h, is_maskable=False):
    # Normalized coordinates [-1, 1]
    nx = (x / w) * 2 - 1
    ny = (y / h) * 2 - 1
    dist = math.sqrt(nx * nx + ny * ny)

    # Base background gradient (Navy #0f172a to slate-800 #1e293b)
    grad = (y / h)
    r = int(15 + grad * (30 - 15))
    g = int(23 + grad * (41 - 23))
    b = int(42 + grad * (59 - 42))
    a = 255

    # If rounded icon and not maskable, round corners
    if not is_maskable:
        # squircle corner radius
        corner_r = 0.4
        dx = max(0, abs(nx) - (1 - corner_r))
        dy = max(0, abs(ny) - (1 - corner_r))
        corner_dist = math.sqrt(dx * dx + dy * dy)
        if corner_dist > corner_r:
            return 0, 0, 0, 0

    # Draw Central Book shape
    # Book covers x in [-0.65, 0.65], y in [-0.25, 0.45]
    if -0.65 <= nx <= 0.65 and -0.22 <= ny <= 0.45:
        # Left page or right page
        if abs(nx) > 0.03:
            # White pages
            r, g, b = (248, 250, 252) if nx > 0 else (255, 255, 255)
            # Lines on page
            line_ys = [-0.10, 0.02, 0.14, 0.26]
            for ly in line_ys:
                if abs(ny - ly) < 0.02 and 0.12 <= abs(nx) <= 0.52:
                    r, g, b = (203, 213, 225)
        else:
            # Spine (Blue #2563eb)
            r, g, b = (37, 99, 235)

    # Bookmark ribbon (Gold #eab308)
    if -0.04 <= nx <= 0.04 and -0.25 <= ny <= 0.15:
        r, g, b = (234, 179, 8)

    # Graduation Cap on top: diamond centered at (0, -0.45)
    # |nx| / 0.55 + |ny - (-0.45)| / 0.22 <= 1
    cap_x = abs(nx) / 0.60
    cap_y = abs(ny - (-0.48)) / 0.18
    if cap_x + cap_y <= 1.0:
        r, g, b = (59, 130, 246)  # Blue #3b82f6

    # Emerald Green Checkmark Circle on bottom-right: center (0.42, 0.32), radius 0.24
    cx, cy, cr = 0.40, 0.30, 0.24
    cdist = math.sqrt((nx - cx)**2 + (ny - cy)**2)
    if cdist <= cr:
        # Checkmark disc
        r, g, b = (16, 185, 129)  # Emerald #10b981
        # Checkmark white lines
        # Check mark segment 1: (-0.10, -0.02) to (0, 0.08) relative to center
        # Check mark segment 2: (0, 0.08) to (0.12, -0.08) relative to center
        rx, ry = nx - cx, ny - cy
        # check if close to segment
        # seg 1
        d1 = abs((ry - rx) - 0.08) if -0.10 <= rx <= 0 and -0.02 <= ry <= 0.08 else 99
        # seg 2
        d2 = abs((ry + rx * 1.3) - 0.08) if 0 <= rx <= 0.12 and -0.08 <= ry <= 0.08 else 99
        if min(d1, d2) < 0.032:
            r, g, b = (255, 255, 255)

    return r, g, b, a

def main():
    icons_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'public', 'icons')
    os.makedirs(icons_dir, exist_ok=True)

    print("Generating icon-512.png...")
    png512 = make_png(512, 512, lambda x, y, w, h: render_icon(x, y, w, h, False))
    with open(os.path.join(icons_dir, 'icon-512.png'), 'wb') as f:
        f.write(png512)

    print("Generating icon-192.png...")
    png192 = make_png(192, 192, lambda x, y, w, h: render_icon(x, y, w, h, False))
    with open(os.path.join(icons_dir, 'icon-192.png'), 'wb') as f:
        f.write(png192)

    print("Generating maskable-icon-512.png...")
    png_maskable = make_png(512, 512, lambda x, y, w, h: render_icon(x, y, w, h, True))
    with open(os.path.join(icons_dir, 'maskable-icon-512.png'), 'wb') as f:
        f.write(png_maskable)

    print("Successfully generated all PWA PNG icons!")

if __name__ == "__main__":
    main()
