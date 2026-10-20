# ==============================================================================
# ASTROAI OS v4.0 - Google Play Store Release Build Pipeline (PowerShell)
# Target: Android 13+ (API 33+) | Vulkan Impeller Engine | Firebase | Play Billing v7
# ==============================================================================

Write-Host "=============================================================" -ForegroundColor Cyan
Write-Host " ASTROAI OS v4.0 - Android Play Store Compilation Pipeline" -ForegroundColor Yellow
Write-Host "=============================================================" -ForegroundColor Cyan

$Entrypoint = "lib/android/main_android.dart"
$OutputDir = "build/app/outputs"

Write-Host "[1/3] Resolving Flutter, Firebase & Cloudflare dependencies..." -ForegroundColor Green
flutter pub get

Write-Host "[2/3] Building Android App Bundle (.aab) with Impeller Vulkan engine..." -ForegroundColor Green
flutter build appbundle --target=$Entrypoint --release --dart-define=ENABLE_IMPELLER=true --no-tree-shake-icons

if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Android App Bundle compilation failed." -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host "[3/3] Building Universal Release APK..." -ForegroundColor Green
flutter build apk --target=$Entrypoint --release --dart-define=ENABLE_IMPELLER=true --split-per-abi

Write-Host "=============================================================" -ForegroundColor Cyan
Write-Host " [SUCCESS] Android Google Play Store Compilation Completed!" -ForegroundColor Green
Write-Host " AAB Bundle: $OutputDir/bundle/release/app-release.aab" -ForegroundColor White
Write-Host " APK Files:  $OutputDir/flutter-apk/" -ForegroundColor White
Write-Host "=============================================================" -ForegroundColor Cyan
