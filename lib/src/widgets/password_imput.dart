import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/auth_bloc_provider.dart';


class PasswordInput extends StatefulWidget {
  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    final authBloc = AuthBlocProvider.of(context);
    return StreamBuilder(
        stream: authBloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: authBloc.changePassword,
            obscureText: obscureText,
            decoration: InputDecoration(
               suffixIcon: IconButton(
                 icon: Icon(Icons.visibility),
                 onPressed: (){
                   setState(() {
                     obscureText = !obscureText;
                   });
                 },
               ),
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
                labelText: "Your password",
                border: OutlineInputBorder()),
          );
        });
  }
}
