#!/bin/bash
# Build script for local builds before Vercel deployment
echo "Building Flutter Web App..."
flutter build web --release --web-renderer auto
echo "✓ Build complete! Files in build/web/"
echo "Now deploy the build/web folder to Vercel"
