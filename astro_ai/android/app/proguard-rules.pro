# Flutter Wrapper & Engine
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Google Play Billing Library
-keep class com.android.billingclient.** { *; }
-dontwarn com.android.billingclient.api.QueryPurchaseHistoryParams
-dontwarn com.android.billingclient.api.SkuDetailsParams
-dontwarn com.android.billingclient.api.SkuDetailsResponseListener

# Google Play Core & Deferred Components (Suppress unused warnings in Flutter embedding)
-dontwarn com.google.android.play.core.splitcompat.**
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**

# Biometrics
-keep class androidx.biometric.** { *; }

# Firebase & Google Play Services
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes SourceFile,LineNumberTable
-keep public class com.google.android.gms.** { public *; }
-keep class com.google.firebase.** { *; }

# Okio & javax annotations
-dontwarn okio.**
-dontwarn javax.annotation.**
-dontwarn java.lang.invoke.**
