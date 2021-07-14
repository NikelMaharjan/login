import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/auth_bloc_provider.dart';

class SecondScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final bloc = AuthBlocProvider.of(context);
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Email ${bloc.currentEmail}"),
        ),
      ),
    );
  }
}
