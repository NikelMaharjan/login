import 'dart:async';

class AuthValidator {
  //transformer send error message if email is invalid or save data if valid
  final emaiValidator = StreamTransformer<String, String>.fromHandlers( //both incoming and outgoing values string
    handleData: (email, sink){
      if(email.contains("@") && email.contains(".")) {
        sink.add(email);
      }else{
        sink.addError("Invalid Email address");
      }
    }
  );

  final passwordValidator = StreamTransformer<String, String>.fromHandlers( //both incoming and outgoing values string
      handleData: (password, sink){
        if(password.length > 5) {
          sink.add(password);
        }else{
          sink.addError("Password must be at least 5 character");
        }
      }
  );

  final genderValidator = StreamTransformer<String, String>.fromHandlers( //both incoming and outgoing values string
      handleData: (gender, sink){
        if(gender == "Rather Not Say") {
          sink.addError("Please select one");
        }else{
         sink.add(gender);
        }
      }
  );



}

