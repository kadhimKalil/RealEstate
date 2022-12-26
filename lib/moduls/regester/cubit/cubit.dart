import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/home_layout.dart';
import 'package:flutter_app/models/users_model.dart';
import 'package:flutter_app/moduls/regester/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RegesterCubit extends Cubit<RegesterStates> {
  RegesterCubit() : super(RegesterInitialState());

  static RegesterCubit get(context) => BlocProvider.of(context);

  bool abscureText = true;
  IconData? suffixIcon = Icons.visibility;

  void changeAbscure() {
    abscureText = !abscureText;
    suffixIcon = abscureText ? Icons.visibility : Icons.visibility_off;
    emit(RegesterChangeObscure());
  }

  Future<void> regesterAccount({
    required String name,
    required String phone,
    required String location,
    required String email,
    required String password,
    @required String? image,
  }) async {
    emit(LoadingUploadProfileImageState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
          name: name,
          phone: phone,
          location: location,
          email: email,
          image: image,
          uid: value.user!.uid);
    }).catchError((error) {
      print(error);
      emit(ErrorRegesterAccountState());
    });
  }

  void createUser({
    required String name,
    required String phone,
    required String location,
    required String email,
    @required String? image,
    required String uid,
  }) {
    UsersModel usersModel = UsersModel(
      name: name,
      phone: phone,
      location: location,
      email: email,
      image: image ?? 'https://img.freepik.com/free-vector/background-green-gold-color_343694-1404.jpg?w=740&t=st=1670593667~exp=1670594267~hmac=2c3f8f5976c105672badc21043e03cc9f877f9697fb6628e14ea87d94dfb0add',
      uid: uid,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(usersModel.toMap())
        .then((value) {
      emit(SuccessCreateUserState(uid));
    }).catchError((error) {
      print(error);
      emit(ErrorCreateUserState());
    });
  }

  File? profileImage;
  final picker = ImagePicker();
  String? profileImageUrl;

  Future<void> getProfileImage() async {
    // get image from gallery
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print('image selected.');
      emit(SuccessImageSelectedState());
    } else {
      print('No image selected.');
      emit(ErrorImageSelectedState());
    }
  }

  // upload image to fireStore and get profileimageUrl
  Future<void> uploadProfileImage({
    required String name,
    required String phone,
    required String location,
    required String email,
    required String password,
  }) async {
    emit(LoadingUploadProfileImageState());
    FirebaseStorage.instance
        .ref()
        .child('users/${profileImage!.path.split('/').last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        regesterAccount(
          name: name,
          phone: phone,
          location: location,
          email: email,
          password: password,
          image: value,
        );
      }).catchError((error) {});
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUploadProfileImageState());
    });
  }
}
