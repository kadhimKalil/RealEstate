import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/home_layout.dart';
import 'package:flutter_app/moduls/regester/cubit/cubit.dart';
import 'package:flutter_app/moduls/regester/cubit/state.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_app/shared/components/constant.dart';
import 'package:flutter_app/shared/style/colors.dart';
import 'package:flutter_app/shared/style/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../shared/network/local/cach_helper.dart';

class RegesterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var locationController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegesterCubit(),
      child: BlocConsumer<RegesterCubit, RegesterStates>(
        listener: (BuildContext context, state) {
          if (state is SuccessCreateUserState) {
            // CacheHelper.setData(key: 'uid', value: state.uid);
            // uid = state.uid;
            navigatorPushAndRemoveUntil(context: context, widget: HomeLayout());
          }
          if (state is ErrorRegesterAccountState) {
            showToast(
                text:
                    'email must be contant @ and Password must be more 6 caracter',
                state: ToastState.ERROR);
          }
        },
        builder: (BuildContext context, Object? state) {
          RegesterCubit cubit = RegesterCubit.get(context);

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
                padding: const EdgeInsetsDirectional.only(start: 24.0),
                child: Text(
                  key: key,
                  'Create Account',
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
                          height: 186.0,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(24.0),
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/house1.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
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
                                HexColor('944bbb').withOpacity(0.87),
                                HexColor('531cb3').withOpacity(0.87),
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
                                        backgroundImage: const NetworkImage(
                                            'https://img.freepik.com/free-vector/background-green-gold-color_343694-1404.jpg?w=740&t=st=1670593667~exp=1670594267~hmac=2c3f8f5976c105672badc21043e03cc9f877f9697fb6628e14ea87d94dfb0add'))
                                    : CircleAvatar(
                                        key: key,
                                        radius: 60.0,
                                        backgroundImage:
                                            FileImage(cubit.profileImage!)),
                                CircleAvatar(
                                  radius: 24.0,
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
                                    return 'Please Enter your Phone';
                                  }
                                  return null;
                                }),
                          ),
                          defualtFormField(
                              controller: locationController,
                              prefixIcon: IconBroken.Location,
                              hintText: 'Location',
                              keyboardType: TextInputType.text,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your location';
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
                                    return 'Please Enter your email';
                                  }
                                  return null;
                                }),
                          ),
                          defualtFormField(
                              controller: passwordController,
                              prefixIcon: IconBroken.Lock,
                              hintText: 'password',
                              obscureText: cubit.abscureText,
                              suffixIcon: cubit.suffixIcon,
                              isPressSuffix: () {
                                cubit.changeAbscure();
                              },
                              keyboardType: TextInputType.visiblePassword,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your password';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 16.0,
                          ),
                          ConditionalBuilder(
                              condition:
                                  state is! LoadingUploadProfileImageState,
                              builder: (context) => defualtBottton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      if (cubit.profileImage != null) {
                                        cubit.uploadProfileImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          location: locationController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      } else {
                                        cubit.regesterAccount(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          location: locationController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          image: cubit.profileImageUrl,
                                        );
                                      }
                                    }
                                  },
                                  text: 'regester'),
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
      ),
    );
  }
}
