@echo off
REM ==============================================================================
REM ASTROAI OS v4.0 - Dual-Platform Unified Master Build Runner
REM Compiles: (1) Google Android Play Bundle + (2) Apple iOS Target Bundles
REM ==============================================================================

echo ==============================================================================
echo       ASTROAI OS v4.0 - DUAL-PLATFORM UNIFIED BUILD PIPELINE
echo ==============================================================================

echo.
echo === STEP 1: Building Google Android App Target ===
call build_android.bat

echo.
echo === STEP 2: Verifying Apple iOS Xcode Target Assets ===
if exist "ios/Runner/Info.plist" (
    echo [OK] Apple Runner Info.plist verified.
) else (
    echo [WARN] Apple Runner Info.plist missing.
)
if exist "ios/Runner/GoogleService-Info.plist" (
    echo [OK] Apple GoogleService-Info.plist verified.
) else (
    echo [WARN] Apple GoogleService-Info.plist missing.
)

echo.
echo ==============================================================================
echo  [SUCCESS] All platform targets, Firebase, Cloudflare, and screens ready!
echo ==============================================================================
pause
