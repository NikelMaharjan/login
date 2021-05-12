import 'package:flutter/material.dart';
import 'auth_bloc.dart';

class AuthBlocProvider extends InheritedWidget {  //inherited widget can pass data to other easily???
 final bloc = AuthBloc();  // we limit access of AuthBloc inside login screen only. it cant be use in main.dart like etc

 //singleton can be uesed everwhere in app. so we use scoped model, so we can only where needed

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
  return true;
  }

  AuthBlocProvider({Key? key, required Widget child}) : super(key: key, child: child);

  //real implementation detail

 static AuthBloc of (BuildContext context){
   return context.dependOnInheritedWidgetOfExactType<AuthBlocProvider>()!.bloc;
 }



}