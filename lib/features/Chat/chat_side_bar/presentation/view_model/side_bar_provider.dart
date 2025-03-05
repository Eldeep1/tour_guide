import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Create a provider family that takes a key to ensure persistence across navigation
final sideBarProvider = AsyncNotifierProviderFamily<SideBarNotifier, List<Map<String, dynamic>>, String>(
      () => SideBarNotifier(),
);

class SideBarNotifier extends FamilyAsyncNotifier<List<Map<String, dynamic>>, String> {
  Timer? _timer;
  KeepAliveLink? _keepAlive;

  static final Map<String, List<Map<String, dynamic>>> _cache = {};

  @override
  Future<List<Map<String, dynamic>>> build(String arg) async {
    // Check if we have cached data for this specific instance
    if (_cache.containsKey(arg)) {
      print("Using cached data for $arg");
      return _cache[arg]!;
    }

    // Keep the provider alive
    _keepAlive = ref.keepAlive();

    ref.onCancel(() {
      _timer?.cancel();
      _timer = Timer(const Duration(seconds: 10), () {
        print("No one is watching for 10 seconds, disposing...");
        _keepAlive?.close();
      });
    });

    ref.onResume(() {
      _timer?.cancel();
      print("Ref resumed, timer stopped.");
    });

    try {
      print("Fetching data for $arg...");
      final data = await fetchDataFromAPI();

      // Store in cache
      _cache[arg] = data;

      return data;
    } catch (e) {
      print("Error fetching data: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchDataFromAPI() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    return [
      {"chatID": 19, "chatHeader": "random chat name"},
      {"chatID": 20, "chatHeader": "random chat name again"},
      {"chatID": 3, "chatHeader": "random tall chat name for testing"},
      {"chatID": 4, "chatHeader": "simple small name"},
    ];
  }

  // Method to force refresh the data if needed
  Future<void> refresh() async {
    state = const AsyncLoading();
    final data = await fetchDataFromAPI();
    _cache[arg] = data;
    state = AsyncData(data);
  }

  // Clear cache if needed
  static void clearCache() {
    _cache.clear();
  }
}