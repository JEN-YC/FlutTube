import 'package:flutter/material.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {
    return SplashScreen.navigate(
      name: 'assets/splash.flr', // flr動畫檔路徑
      next: LoginPage(), // 動畫結束後轉換頁面
      until: () => Future.delayed(Duration(seconds: 3)), //等待3秒
      startAnimation: 'rotate_scale_color', // 動畫名稱
    );
  }
}