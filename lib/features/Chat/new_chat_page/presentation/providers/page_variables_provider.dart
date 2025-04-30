import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatIDProvider = StateProvider<int?>(
  (ref) {
    return null;
  },
);
final appBarHeaderProvider = StateProvider<String>(
  (ref) {
    return "AI TOUR GUIDE";
  },
);

final sendMessageFormController = Provider.autoDispose<TextEditingController>(
      (ref) {
    return TextEditingController();
  },
);

final sendingMessage=StateProvider<bool>((ref) {
  return false;
},);
