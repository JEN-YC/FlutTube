import 'package:flutter/material.dart';
import '../firebase/user_repository.dart';
import 'register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  final UserRepository _userRepository;
  RegisterPage({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          builder: (BuildContext content) =>
              RegisterBloc(userRepository: _userRepository),
          child: RegisterForm(),
        ));
  }
}
