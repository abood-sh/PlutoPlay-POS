# Stripe Terminal SDK
-keep class com.stripe.** { *; }
-dontwarn com.stripe.**

# Jackson
-keep class com.fasterxml.jackson.** { *; }
-dontwarn com.fasterxml.jackson.**

# Missing classes - ignore warnings
-dontwarn java.beans.ConstructorProperties
-dontwarn java.beans.Transient
-dontwarn org.slf4j.impl.StaticLoggerBinder
-dontwarn org.slf4j.impl.StaticMDCBinder
-dontwarn org.slf4j.**

# OkHttp
-dontwarn okhttp3.**
-dontwarn okio.**

# Keep Flutter
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**