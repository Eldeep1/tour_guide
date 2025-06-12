import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/chat/new_chat_page/data/model/chat_request.dart';

final messageRequestProvider=StateProvider<ChatRequest>((ref) {
  return ChatRequest();
},);

final appBarHeaderProvider = StateProvider<String>(
  (ref) {
    return "AI TOUR GUIDE";
  },
);



final sendingMessage=StateProvider<bool>((ref) {
  return false;
},);
