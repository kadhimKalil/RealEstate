import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/moduls/login/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool abscureText = true;
  IconData? suffixIcon = Icons.visibility;

  void changeAbscure() {
    abscureText = !abscureText;
    suffixIcon = abscureText ? Icons.visibility : Icons.visibility_off;

    emit(LoginChangeObscure());
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoadingLoginState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          emit(SuccessLoginState(value.user!.uid));
        })
        .catchError((error) {
      print(error.toString());
          emit(ErrorLoginState(error.toString()));
    });
  }
}
