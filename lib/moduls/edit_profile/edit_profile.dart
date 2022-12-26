import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/cubit/cubit.dart';
import 'package:flutter_app/layout/cubit/states.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_app/shared/style/colors.dart';
import 'package:flutter_app/shared/style/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var locationController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RealEstateCubit, RealEstateStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = RealEstateCubit.get(context);
        var usersModel = cubit.usersModel;
        if (usersModel != null) {
          nameController.text = usersModel.name!;
          phoneController.text = usersModel.phone!;
          locationController.text = usersModel.location!;
          emailController.text = usersModel.email!;
        }
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                key: key,
                IconBroken.Arrow___Left_2,
              ),
            ),
            title: Padding(
              key: key,
              padding: const EdgeInsetsDirectional.only(start: 40.0),
              child: const Text(
                'Edit Profile',
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 252.0,
                  child: Stack(
                    children: [
                      
                      Container(
                        height: 202.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadiusDirectional.only(
                            bottomStart: Radius.circular(24.0),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              HexColor('944bbb'),
                              HexColor('531cb3'),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.white,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              cubit.profileImage == null
                                  ? CircleAvatar(
                                      key: key,
                                      radius: 60.0,
                                      backgroundImage:
                                          NetworkImage('${usersModel!.image}'))
                                  : CircleAvatar(
                                      key: key,
                                      radius: 60.0,
                                      backgroundImage:
                                          FileImage(cubit.profileImage!)),
                              CircleAvatar(
                                radius: 22.0,
                                backgroundColor: defualtColor,
                                child: IconButton(
                                    icon: const Icon(
                                      IconBroken.Camera,
                                    ),
                                    onPressed: () {
                                      cubit.getProfileImage();
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        defualtFormField(
                            controller: nameController,
                            prefixIcon: IconBroken.Profile,
                            hintText: 'Name',
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter your Name';
                              }
                              return null;
                            }),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: defualtFormField(
                              controller: phoneController,
                              prefixIcon: IconBroken.Call,
                              hintText: 'phone',
                              keyboardType: TextInputType.phone,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your phone';
                                }
                                return null;
                              }),
                        ),
                        defualtFormField(
                            controller: locationController,
                            prefixIcon: IconBroken.Location,
                            hintText: 'Location',
                            keyboardType: TextInputType.name,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter your Location';
                              }
                              return null;
                            }),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: defualtFormField(
                              controller: emailController,
                              prefixIcon: IconBroken.Message,
                              hintText: 'email',
                              keyboardType: TextInputType.emailAddress,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your Email';
                                }
                                return null;
                              }),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        ConditionalBuilder(
                            condition: state is! LoadingUploadProfileImageState,
                            builder: (context) => defualtBottton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (cubit.profileImage != null) {
                                      cubit.uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        location: locationController.text,
                                        email: emailController.text,
                                      );
                                    } else {
                                      cubit.updateUserProfile(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        location: locationController.text,
                                        email: emailController.text,
                                      );
                                    }
                                  }
                                },
                                text: 'UPDATE'),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator())),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
