abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginChangeObscure extends LoginStates {}

class LoadingLoginState extends LoginStates {}

class SuccessLoginState extends LoginStates {
  final String uid;
  SuccessLoginState(this.uid);
}

class ErrorLoginState extends LoginStates {
  final String error;

  ErrorLoginState(this.error);
}
