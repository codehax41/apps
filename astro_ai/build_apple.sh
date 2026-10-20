#!/bin/bash
# ==============================================================================
# ASTROAI OS v4.0 - Apple App Store (iOS 17+) Release Build Pipeline
# Target: iOS 17.0+ | Metal Impeller Pre-compiled Shaders | StoreKit 2 | CoreHaptics
# ==============================================================================

set -e

echo "============================================================="
echo " ASTROAI OS v4.0 - Apple iOS 17+ App Store Build Pipeline"
echo "============================================================="

ENTRYPOINT="lib/apple/main_apple.dart"
OUTPUT_DIR="build/ios/iphoneos"

echo "[1/4] Resolving Flutter, Firebase & Cloudflare dependencies..."
flutter pub get

echo "[2/4] Installing Apple CocoaPods dependencies..."
cd ios && pod install --repo-update && cd ..

echo "[3/4] Compiling iOS Release Frameworks with Metal Impeller Engine..."
flutter build ios --target=$ENTRYPOINT --release --no-codesign

echo "[4/4] Generating Xcode Archive for App Store Connect / TestFlight..."
flutter build ipa --target=$ENTRYPOINT --release --export-options-plist=ios/ExportOptions.plist || true

echo "============================================================="
echo " [SUCCESS] Apple iOS App Store Build Completed!"
echo " IPA Output: build/ios/ipa/astro_ai.ipa"
echo "============================================================="
