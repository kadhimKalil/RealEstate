abstract class RegesterStates{}

class RegesterInitialState extends RegesterStates{}
class RegesterChangeObscure extends RegesterStates{}

class LoadingCreateUserState extends RegesterStates{}
class SuccessCreateUserState extends RegesterStates{
  final String uid ;

  SuccessCreateUserState(this.uid);
}
class ErrorCreateUserState extends RegesterStates{}

class LoadingRegesterAccountState extends RegesterStates{}
class ErrorRegesterAccountState extends RegesterStates{}

class SuccessImageSelectedState extends RegesterStates{}
class ErrorImageSelectedState extends RegesterStates{}

class LoadingUploadProfileImageState extends RegesterStates{}
class ErrorUploadProfileImageState extends RegesterStates{}


