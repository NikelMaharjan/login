import 'package:flutter/material.dart';
import 'auth_bloc.dart';

class AuthBlocProvider extends InheritedWidget {
 final bloc = AuthBloc();  //authblocprovider will gives us bloc // we limit access of AuthBloc inside login screen only. it cant be use in main.dart like etc

 //singleton can be used everywhere in app. so we use scoped model, so we can only where needed

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
  return true;
  }

  AuthBlocProvider({Key? key, required Widget child}) : super(key: key, child: child);

 static AuthBloc of (BuildContext context){
   return context.dependOnInheritedWidgetOfExactType<AuthBlocProvider>()!.bloc; // whenever AuthBlocProvider.of(context) is called from any child widget, it will go on searching in parent
                                                                                                   //widget till AuthBlockProvider is found and it will go that called widget with bloc
 }

}