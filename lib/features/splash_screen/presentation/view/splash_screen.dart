import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/Authentication/login/presentation/view/login_page_view.dart';
import 'package:tour_guide/features/chat/new_chat_page/presentation/view/new_chat_page_view.dart';
import '../../../../core/utils/services/auth_service.dart';
import 'widgets/splash_screen_body_builder.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _shouldNavigate = false;
  Widget? _nextWidget;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        _shouldNavigate = true;
      });
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_shouldNavigate && _nextWidget != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => _nextWidget!,
            ));
      });
    }
    ref.listen<AsyncValue<AuthStatus>>(authServiceProvider, (prev, next) {
      if (next.hasError ||
          (next.hasValue && next.value == AuthStatus.notAuthenticated)) {
        _nextWidget = LoginPageView();
      } else if (next.hasValue && next.value == AuthStatus.authenticated) {
        _nextWidget = NewChatPageView();
      } else {
        _nextWidget = LoginPageView();
      }
      setState(() {});
    });

    return const SplashScreenBodyBuilder();
  }
}
