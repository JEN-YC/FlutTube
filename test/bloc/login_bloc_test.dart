import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:fluttube/firebase/user_repository.dart';

import 'package:fluttube/login/bloc/bloc.dart';

class MockUserRepository extends Mock implements UserRepository {}


void main() {
  MockUserRepository userRepository;
  LoginBloc loginBloc;

  setUp(() {
    userRepository = MockUserRepository();
    loginBloc = LoginBloc(userRepository: userRepository);
  });

  test('initial state is correct', () {
    expect(LoginState.empty().toString(), loginBloc.initialState.toString());
  });

  test('dispose does not emit new states', () {
    expectLater(
      loginBloc.state,
      emitsInOrder([]),
    );
    loginBloc.dispose();
  });

  group('LoginButtonPressed', () {
    test('emits token on success', () {
      final expectedResponse = [
        LoginState.empty().toString(),
        LoginState.loading().toString(),
        LoginState.success().toString(),
      ];

      expectLater(
        loginBloc.state.map((state) => state.toString()),
        emitsInOrder(expectedResponse),
      );

      loginBloc.dispatch(LoginWithCredentialsPressed(
        email: 'tester123@gmail.com',
        password: 'password123',
      ));
    });

    test('throw error on fail', (){
      final expectedResponse = [
        LoginState.empty().toString(),
        LoginState.loading().toString(),
        LoginState.failure().toString(),
      ];

      when(userRepository.signInWithCredentials("wrong", "wrong")).thenThrow(Exception);

      expectLater(
        loginBloc.state.map((state) => state.toString()),
        emitsInOrder(expectedResponse),
      );

      loginBloc.dispatch(LoginWithCredentialsPressed(
        email: 'wrong',
        password: 'wrong',
      ));
    });
  });

  group('test validation do the right judgement', (){
    test('test email validator', () async{
      final expectedResponse = [
        LoginState.empty().toString(),
        LoginState.empty().update(isEmailValid: false, isPasswordValid: true).toString(),
        LoginState.empty().update(isEmailValid: true, isPasswordValid: true).toString(),
      ];

      expectLater(
        loginBloc.state.map((state) => state.toString()),
        emitsInOrder(expectedResponse),
      );

      loginBloc.dispatch(EmailChanged(email: 'WRONG'));
      await Future.delayed(Duration(milliseconds: 400));
      loginBloc.dispatch(EmailChanged(email: 'GOOD@gmail.com'));
    });

    test('test password validator', () async{
      final expectedResponse = [
        LoginState.empty().toString(),
        LoginState.empty().update(isEmailValid: true, isPasswordValid: false).toString(),
        LoginState.empty().update(isEmailValid: true, isPasswordValid: true).toString(),
      ];

      expectLater(
        loginBloc.state.map((state) => state.toString()),
        emitsInOrder(expectedResponse),
      );

      loginBloc.dispatch(PasswordChanged(password: 'Bad'));
      await Future.delayed(Duration(milliseconds: 400));
      loginBloc.dispatch(PasswordChanged(password: 'goodPassword123'));
    });
  });
}