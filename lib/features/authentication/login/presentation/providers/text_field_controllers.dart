

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final globalFormKeyProvider = Provider.autoDispose<GlobalKey<FormState>>((ref) {
  final controller = GlobalKey<FormState>();
  return controller;
});

final passwordControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
final obscurePassword = StateProvider<bool>((ref) {
  return true;
});