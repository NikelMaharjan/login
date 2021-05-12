import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildEmailField(),
            SizedBox(height: 16),
            buildPasswordField(),
            SizedBox(height: 16),
            buildGenderField(),
            SizedBox(height: 16),
            buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget buildEmailField() {
    return StreamBuilder(
      //running app first time wont show any error since onChanged is not called
      stream: authBloc.emailStream, //listen like in dart game. rebuild evertime when value comes
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged:authBloc.changeEmail, //we can do this coz onchaged and email have same return type??..this is efficent coz ocChanged wont call another function
          decoration: InputDecoration(
              labelText: "Your Email",
              hintText: "abc@email.com",
              errorText: snapshot.hasError ? snapshot.error.toString() : null,
              border: OutlineInputBorder()),
        );
      },
    );
  }

  Widget buildPasswordField() {
    return StreamBuilder(
        stream: authBloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: authBloc.changePassword,
            obscureText: true,
            decoration: InputDecoration(
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
                labelText: "Your password",
                border: OutlineInputBorder()),
          );
        });
  }

  Widget buildGenderField() {
    return StreamBuilder(
        stream: authBloc.genderStream,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return DropdownButtonFormField<String>(
            items: [
              DropdownMenuItem(child: Text("Male"), value: "Male"),
              DropdownMenuItem(child: Text("Female"), value: "Female"),
              DropdownMenuItem(child: Text("Others"), value: "Others"),
              DropdownMenuItem(
                  child: Text("Rather Not Say"), value: "Rather Not Say"),
            ],
            onChanged: (String? val) {
              authBloc.changeGender(val!);
            },
            value: snapshot.data,
            decoration: InputDecoration(
                hintText: "Select your gender",
                border: OutlineInputBorder(),
                errorText:
                    !snapshot.hasError ? null : snapshot.error.toString()),
          );
        });
  }

  Widget buildSubmitButton() {
    return StreamBuilder(
        stream: null,
        builder: (context, snapshot) {
          return Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                primary: Colors.teal,
              ),
              child: Text("Submit"),
            ),
          );
        });
  }

}
