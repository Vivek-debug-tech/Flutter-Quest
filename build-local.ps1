# Build script for local builds before Vercel deployment
Write-Host "Building Flutter Web App..." -ForegroundColor Cyan
flutter build web --release --web-renderer auto
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Build complete! Files in build/web/" -ForegroundColor Green
    Write-Host "Now deploy the build/web folder to Vercel" -ForegroundColor Yellow
} else {
    Write-Host "✗ Build failed!" -ForegroundColor Red
}
