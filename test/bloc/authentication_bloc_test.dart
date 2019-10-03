import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:fluttube/firebase/user_repository.dart';

import 'package:fluttube/authentication_bloc/bloc.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  AuthenticationBloc authenticationBloc;
  MockUserRepository userRepository;

  setUp(() {
    userRepository = MockUserRepository();
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
  });

  test('initial state is correct', () {
    expect(authenticationBloc.initialState, Uninitialized());
  });

  test('dispose does not emit new states', () {
    expectLater(
      authenticationBloc.state,
      emitsInOrder([]),
    );
    authenticationBloc.dispose();
  });

  group('AppStarted', () {
    test('emits [uninitialized, unauthenticated] for invalid token', () {
      final expectedResponse = [
        Uninitialized(),
        Unauthenticated()
      ];

      when(userRepository.isSignedIn()).thenAnswer((_) => Future.value(false));

      expectLater(
        authenticationBloc.state,
        emitsInOrder(expectedResponse),
      );

      authenticationBloc.dispatch(AppStarted());
    });

    test('emits [uninitialized, authenticated] for valid token', () {
      final expectedResponse = [
        Uninitialized(),
        Authenticated("tester")
      ];

      when(userRepository.isSignedIn()).thenAnswer((_) => Future.value(true));
      when(userRepository.getUser()).thenAnswer((_) => Future.value('tester'));

      expectLater(
        authenticationBloc.state,
        emitsInOrder(expectedResponse),
      );

      authenticationBloc.dispatch(AppStarted());
    });
  });

  group('LoggedIn', () {
    test(
        'emits [uninitialized, authenticated] when token is persisted',
            () {
          final expectedResponse = [
            Uninitialized(),
            Authenticated("tester"),
          ];
          when(userRepository.getUser()).thenAnswer((_) => Future.value("tester"));

          expectLater(
            authenticationBloc.state,
            emitsInOrder(expectedResponse),
          );

          authenticationBloc.dispatch(LoggedIn());
        });
  });

  group('LoggedOut', () {
    test(
        'emits [uninitialized, unauthenticated] when token is deleted',
            () {
          final expectedResponse = [
            Uninitialized(),
            Unauthenticated(),
          ];

          expectLater(
            authenticationBloc.state,
            emitsInOrder(expectedResponse),
          );

          authenticationBloc.dispatch(LoggedOut());
        });
  });
}