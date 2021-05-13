import 'dart:async';
import 'package:login_bloc/src/validators/auth_validaor.dart';
import 'package:rxdart/rxdart.dart';


class AuthBloc with AuthValidator{
 //broadcast for debug purpose only
 final _emailController  = StreamController<String>.broadcast(); //incoming value string, outgoing(error) value also string. so we can use String
 final _passwordController  = StreamController<String>.broadcast();
 final _genderController  = StreamController<String>.broadcast();

 //getters for Functions...//user inputed values
 Function(String email) get changeEmail => _emailController.sink.add; // returns function //after adding to sink, the value will pass to stream
// void changeEmail(val) { _emailController.sink.add(val);} // getter equivalent
 Function(String pass) get changePassword => _passwordController.sink.add;
 Function(String gender) get changeGender => _genderController.sink.add;

 //stream getters  //in dart game, stream comes in default. like .add..
 Stream<String> get emailStream => _emailController.stream//return type stream //latest stream and sink will pass to transformer
     .transform(emaiValidator);
 Stream<String> get passwordStream => _passwordController.stream
     .transform(passwordValidator);
 Stream<String> get genderStream => _genderController.stream
     .transform(genderValidator);

 //todo combine 3 streams using rxDart   //StreamController do not capture data so we use RXdart subject similar to streamcontrooler but also save data
 Stream<bool> get buttonStream => Rx.combineLatest3(emailStream, passwordStream, genderStream,
         (a, b, c) => true);   //combine will call only if all stream have data



 void dispose(){  //we never call this since controller, need to listen all time. SO, just to remove error underline.
  _emailController.close();
  _passwordController.close();
  _genderController.close();
 }
}
//final authBloc = _AuthBloc();  //singleton design pattern..//single global instance..//can be used everywhere