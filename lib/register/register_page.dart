import 'package:flutter/material.dart';
import '../firebase/user_repository.dart';

class RegisterPage extends StatelessWidget {
  final UserRepository _userRepository;
  RegisterPage({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Register Page'),
      ),
    );
  }
}
