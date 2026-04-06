/// splash_screen.dart
///
/// 역할: 앱 시작 시 2초간 로고를 표시한 뒤 지정된 화면으로 전환하는 스플래시 화면.
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// SplashScreen
///
/// 역할: The Navigators 로고를 2초간 표시 후 destination 화면으로 이동.
/// 사용법: SplashScreen(destination: () => const MainPage())
class SplashScreen extends StatefulWidget {
  /// 스플래시 후 이동할 화면을 반환하는 함수
  final Widget Function() destination;

  const SplashScreen({super.key, required this.destination});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMain();
  }

  void _navigateToMain() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => widget.destination()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SvgPicture.asset(
          'assets/images/The_Navigators.svg',
          width: screenWidth * 0.6,
          colorFilter: ColorFilter.mode(
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
