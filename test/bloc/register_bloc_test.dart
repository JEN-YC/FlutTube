import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:fluttube/firebase/user_repository.dart';

import 'package:fluttube/register/bloc/bloc.dart';

class MockUserRepository extends Mock implements UserRepository {}


void main() {
  MockUserRepository userRepository;
  RegisterBloc registerBloc;

  setUp(() {
    userRepository = MockUserRepository();
    registerBloc = RegisterBloc(userRepository: userRepository);
  });

  test('initial state is correct', () {
    expect(RegisterState.empty().toString(), registerBloc.initialState.toString());
  });

  test('dispose does not emit new states', () {
    expectLater(
      registerBloc.state,
      emitsInOrder([]),
    );
    registerBloc.dispose();
  });

  group('LoginButtonPressed', () {
    test('emits token on success', () {
      final expectedResponse = [
        RegisterState.empty().toString(),
        RegisterState.loading().toString(),
        RegisterState.success().toString(),
      ];


      expectLater(
        registerBloc.state.map((state) => state.toString()),
        emitsInOrder(expectedResponse),
      );

      registerBloc.dispatch(Submitted(
        email: 'tester123@gmail.com',
        password: 'password123',
      ));
    });

    test('throw error on fail', (){
      final expectedResponse = [
        RegisterState.empty().toString(),
        RegisterState.loading().toString(),
        RegisterState.failure().toString(),
      ];

      when(userRepository.signUp(email: "wrong", password: "wrong")).thenThrow(Exception);

      expectLater(
        registerBloc.state.map((state) => state.toString()),
        emitsInOrder(expectedResponse),
      );

      registerBloc.dispatch(Submitted(
        email: 'wrong',
        password: 'wrong',
      ));
    });
  });

  group('test validation do the right judgement', (){
    test('test email validator', () async{
      final expectedResponse = [
        RegisterState.empty().toString(),
        RegisterState.empty().update(isEmailValid: false, isPasswordValid: true).toString(),
        RegisterState.empty().update(isEmailValid: true, isPasswordValid: true).toString(),
      ];

      expectLater(
        registerBloc.state.map((state) => state.toString()),
        emitsInOrder(expectedResponse),
      );

      registerBloc.dispatch(EmailChanged(email: 'WRONG'));
      await Future.delayed(Duration(milliseconds: 400));
      registerBloc.dispatch(EmailChanged(email: 'GOOD@gmail.com'));
    });

    test('test password validator', () async{
      final expectedResponse = [
        RegisterState.empty().toString(),
        RegisterState.empty().update(isEmailValid: true, isPasswordValid: false).toString(),
        RegisterState.empty().update(isEmailValid: true, isPasswordValid: true).toString(),
      ];

      expectLater(
        registerBloc.state.map((state) => state.toString()),
        emitsInOrder(expectedResponse),
      );

      registerBloc.dispatch(PasswordChanged(password: 'Bad'));
      await Future.delayed(Duration(milliseconds: 400));
      registerBloc.dispatch(PasswordChanged(password: 'goodPassword123'));
    });
  });
}