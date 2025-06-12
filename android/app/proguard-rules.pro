# android/app/proguard-rules.pro

# TensorFlow & Ultraytics (already there)
-keep class org.tensorflow.** { *; }
-keep class com.ultralytics.** { *; }
-dontwarn org.tensorflow.**

# Suppress warnings about missing java.beans classes
-dontwarn java.beans.**

# Suppress warnings about SnakeYAML and keep its classes intact
-dontwarn org.yaml.snakeyaml.**
-keep class org.yaml.snakeyaml.** { *; }