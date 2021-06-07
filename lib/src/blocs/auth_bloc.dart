import 'dart:async';
import 'package:login_bloc/src/api/auth_api.dart';
import 'package:login_bloc/src/validators/auth_validaor.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc with AuthValidator{
 final api = AuthApi();

 //broadcast for debug purpose only
 //StreamController do not capture data so we use RXdart BehaviourSubject similar to StreamController but also save data
 //final _emailController  = StreamController<String>.broadcast();  //incoming value string, outgoing(error) value also string. so we can use String
 final _emailController  = BehaviorSubject<String>();
 final _passwordController  = BehaviorSubject<String>();
 final _genderController  = BehaviorSubject<String>();
 //to hold the status of the button's child
 final _loadingController = BehaviorSubject<bool>();


 //getters for Functions...//user inputed values added to sink
 Function(String email) get changeEmail => _emailController.sink.add;
 //whenever email is changed, sink/value is added to emailcontroller
 // returns function //after adding to sink, the value will pass to stream
// void changeEmail(val) { _emailController.sink.add(val);} // getter equivalent
 Function(String pass) get changePassword => _passwordController.sink.add;
 Function(String gender) get changeGender => _genderController.sink.add;
 Function(bool value) get changeLoadingStatus => _loadingController.sink.add;


 //stream getters  //in dart game, stream comes in default. like .add..
 Stream<String> get emailStream => _emailController.stream//return type stream //latest stream and sink will pass to transformer
     .transform(emaiValidator);
 Stream<String> get passwordStream => _passwordController.stream
     .transform(passwordValidator);
 Stream<String> get genderStream => _genderController.stream
     .transform(genderValidator);
 Stream<bool> get loadingStatusStream => _loadingController.stream;

 //todo combine 3 streams using rxDart
 Stream<bool> get buttonStream => Rx.combineLatest3(emailStream, passwordStream, genderStream,
         (a, b, c) => true);   //combine will call only if all stream have valid data

void getData(){
 final email = _emailController.value;  //without adding value to sink first, there wont be any value in emailcontroller
 final password = _passwordController.value;
 final gender = _genderController.value;
 print("Email $email Password $password and Gender $gender");
}

Future submitData() async {
 final email = _emailController.value;
 final password = _passwordController.value;
 final gender = _genderController.value;
 final response = await api.singUp(email, password, gender);
 return response;
}

String get currentEmail => _emailController.value;

 void dispose(){  //we never call this since controller, need to listen all time. SO, just to remove error underline.
  _emailController.close();
  _passwordController.close();
  _genderController.close();
  _loadingController.close();
 }
}
//final authBloc = _AuthBloc();  //singleton design pattern..//single global instance..//can be used everywhere