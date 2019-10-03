import 'package:flutter/material.dart';
import '../firebase/user_repository.dart';
import '../register/register_page.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
          'Create a Account'
      ),
      onPressed: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context){
              return RegisterPage(userRepository: _userRepository);
            })
        );
      },
    );
  }
}
