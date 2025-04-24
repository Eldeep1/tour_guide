import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatIDProvider = StateProvider<int?>(
  (ref) {
    return null;
  },
);

final formController = Provider<TextEditingController>(
      (ref) {
    return TextEditingController();
  },
);