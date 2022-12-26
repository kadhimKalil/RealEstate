import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/cubit/states.dart';
import 'package:flutter_app/models/item_model.dart';
import 'package:flutter_app/models/users_model.dart';
import 'package:flutter_app/moduls/chat/chat_screen.dart';
import 'package:flutter_app/moduls/home/home_screen.dart';
import 'package:flutter_app/moduls/new_Item/new_Item.dart';
import 'package:flutter_app/moduls/saved/saved_screen.dart';
import 'package:flutter_app/moduls/settings/settings_screeen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/components/constant.dart';

class RealEstateCubit extends Cubit<RealEstateStates> {
  RealEstateCubit() : super(RealEstateInitialState());

  static RealEstateCubit get(context) => BlocProvider.of(context);

  var enterdMessage = '';

  void sendMessage(context, controller) async {
    // FocusScope.of(context).unfocus();

    FirebaseFirestore.instance.collection('chat').add(
        {'text': enterdMessage, 'createdAt': Timestamp.now(), 'userId': uid});
    controller.clear();
    // enterdMessage = 'clear';
    emit(SuccessEnteredMessageState());
  }

  int currentIndex = 0;

  List<Widget> screen = [
    const HomeScreen(),
    const SavedScreen(),
    NewItem(),
    ChatScreen(),
    const SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    if (index == 3) {
      getUsers();
    }
    if (index == 2) {
      emit(NewItemState());
    } else {
      currentIndex = index;
      emit(RealEstateChangeBottomNavState());
    }
  }

  void changeEnterdMessage(String index) {
    enterdMessage = index;
    emit(RealEstateChangeEnterdMessageState());
  }

  List<ItemModel> item = [];

  Future<void> fetchItems() async {
    await FirebaseFirestore.instance
        .collection('items')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((decument) {
        item.add(ItemModel.fromJson(json: decument.data()));
      });
      emit(SuccessFetchItemState());
    }).catchError((error) {
      print('ree' + error.toString());
    });
  }

  UsersModel? usersModel;
  Future<void> getUserData() async {
    print('success');
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      usersModel = UsersModel.fromJson(value.data()!);
      emit(SuccessGetUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetUserDataState());
    });
  }

  Future<void> updateUserProfile({
    required String name,
    required String phone,
    required String location,
    required String email,
    String? image,
  }) async {
    emit(LoadingUploadProfileImageState());

    UsersModel usersModel = UsersModel(
      name: name,
      phone: phone,
      location: location,
      email: email,
      image: image,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc('7f1Ih6LybaPUC5PhPxhUwDJwI8t1')
        .update(usersModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error);
      // emit(ErrorCreateUserState());
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
      print('image selected');
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
  }) async {
    emit(LoadingUploadProfileImageState());
    FirebaseStorage.instance
        .ref()
        .child('users/${profileImage!.path.split('/').last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        print(profileImageUrl);
        updateUserProfile(
          name: name,
          phone: phone,
          location: location,
          email: email,
          image: value,
        );
      }).catchError((error) {});
    }).catchError((error) {
      print(error.toString());
      // emit(ErrorUploadProfileImageState());
    });
  }

  List<UsersModel> users = [];

  void getUsers() {
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          print(uid);
          print(element.id);
          print(usersModel!.uid);
          if (element.id != usersModel!.uid) {
            users.add(UsersModel.fromJson(element.data()));
          }
        });

        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUsersErrorState());
      });
    }
  }

  File? itemImage;
  String? itemImageUrl;

  Future<void> getItemImage() async {
    // get image from gallery
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      itemImage = File(pickedFile.path);
      print('image selected.');
      emit(SuccessImageSelectedState());
    } else {
      print('No image selected.');
      emit(ErrorImageSelectedState());
    }
  }

  Future<void> uploadItemImage({
    required String title,
    required String location,
    required String price,
    required String area,
    required String badRoom,
    required String bathRoom,
    required String propertiesDetails,
  }) async {
    emit(LoadingUploadItemImageState());
    FirebaseStorage.instance
        .ref()
        .child('users/${itemImage!.path.split('/').last}')
        .putFile(itemImage!)
        .then((value) {
      value.ref.getDownloadURL().then((url) {
        itemImageUrl = url;
        print(itemImageUrl);
        addItem(
            title: title,
            location: location,
            price: price,
            area: area,
            badRoom: badRoom,
            bathRoom: bathRoom,
            propertiesDetails: propertiesDetails,
            itemImage: itemImageUrl!);
      }).catchError((error) {});
    }).catchError((error) {
      print(error.toString());
      // emit(ErrorUploadProfileImageState());
    });
  }

  void addItem({
    required String title,
    required String location,
    required String price,
    required String area,
    required String badRoom,
    required String bathRoom,
    required String propertiesDetails,
    required String itemImage,
  }) {
    ItemModel itemModel = ItemModel(
      title: title,
      location: location,
      price: price,
      area: area,
      badRoom: badRoom,
      bathRoom: bathRoom,
      propertiesDetails: propertiesDetails,
      itemImage: itemImage,
      userIamge: usersModel!.image,
      userName: usersModel!.uid,
    );
    FirebaseFirestore.instance
        .collection('items')
        .add(itemModel.toMap())
        .then((value) {
          item = [];
          fetchItems();
      emit(SuccessCreateNewItemState());
    }).catchError((error) {
      print(error.toString());
      // emit(ErrorCreateUserState());
    });
  }
}
