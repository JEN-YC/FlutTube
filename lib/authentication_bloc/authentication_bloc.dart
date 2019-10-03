import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import '../firebase/user_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  AuthenticationBloc({UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final bool isSigned = await _userRepository.isSignedIn();
      if (isSigned) {
        final String name = await _userRepository.getUser();
        yield Authenticated(name);
      }
      else{
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(await _userRepository.getUser());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}
