import 'package:flutter/material.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'authentication_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen.callback(
      name: 'assets/splash.flr', // flr動畫檔路徑
      onSuccess: (_){_authenticationBloc.dispatch(AppStarted());}, // 動畫結束後觸發AppStarted事件
      until: () => Future.delayed(Duration(seconds: 3)), //等待3秒
      startAnimation: 'rotate_scale_color', // 動畫名稱
    );
  }
}