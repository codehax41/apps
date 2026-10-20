@echo off
REM ==============================================================================
REM ASTROAI OS v4.0 - Google Play Store Release Build Pipeline
REM Compiles: Android App Bundle (.aab) & Universal Release APK (.apk)
REM Target: Android 13+ (API 33+) | Vulkan Impeller Rendering | Firebase | Play Billing v7
REM ==============================================================================

echo -------------------------------------------------------------
echo  ASTROAI OS v4.0 - Android Play Store Compilation Initiated
echo -------------------------------------------------------------

set ENTRYPOINT=lib/android/main_android.dart
set OUTPUT_DIR=build/app/outputs

echo [1/3] Resolving Flutter & Firebase dependencies...
call flutter pub get

echo [2/3] Compiling Google Play App Bundle (AAB) with Impeller Vulkan...
call flutter build appbundle --target=%ENTRYPOINT% --release --dart-define=ENABLE_IMPELLER=true --no-tree-shake-icons

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Play App Bundle compilation failed.
    exit /b %ERRORLEVEL%
)

echo [3/3] Compiling Universal Release APK...
call flutter build apk --target=%ENTRYPOINT% --release --dart-define=ENABLE_IMPELLER=true --split-per-abi

echo -------------------------------------------------------------
echo  [SUCCESS] Android Builds Completed Successfully!
echo  Play Store Bundle: %OUTPUT_DIR%/bundle/release/app-release.aab
echo  Release APKs:      %OUTPUT_DIR%/flutter-apk/
echo -------------------------------------------------------------
pause
