import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super(props);
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() {
    return 'Uninitialized';
  }
}

class Authenticated extends AuthenticationState {
  final String userName;
  Authenticated(this.userName) : super([userName]);
  @override
  String toString() {
    return 'Authenticated {UserName: $userName}';
  }
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() {
    return 'Unauthenticated';
  }
}
