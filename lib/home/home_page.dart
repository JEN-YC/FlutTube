import 'package:flutter/material.dart';
import '../authentication_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedOut()),
        label: Text("Logout"),
        icon: Icon(Icons.arrow_back),
      ),
    );
  }
}
