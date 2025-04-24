class ApiEndpoints {
  static const String baseUrl = "https://backend.tour-guide-eg.site/";

  //Auth
  static const String login = "login/";
  static const String register = "user/register/";
  static const String refreshAccess = "login-refresh/";

  // User
  static const String userData = "user/";
  static const String userUpdate = "user/";
  static const String userDelete = "user/";

  //Chat
  static const String getAllChats = "chat/";
  static const String askAQuestion = "chat/messages/response";
  // give the message ID to it!
  static  String getAllMessages ({required int chatID}){
    return "chat/messages/getAll/$chatID";
  }
}
