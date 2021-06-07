import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/auth_bloc_provider.dart';

import 'src/screens/login_screem.dart';

void main(){
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AuthBlocProvider(
      child: MaterialApp(
        title: "Login Bloc",
        theme: ThemeData.dark(),
        home: Scaffold(
          body: LoginScreen(),
        )
      ),
    );
  }
}
