import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/moduls/login/cubit/cubit.dart';
import 'package:flutter_app/moduls/login/cubit/state.dart';
import 'package:flutter_app/moduls/regester/regester.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_app/shared/components/constant.dart';

import 'package:flutter_app/shared/style/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (BuildContext context, state) {
        if (state is SuccessLoginState) {
          // CacheHelper.setData(key: 'uid' ,value: state.uid);
          uid =state.uid;
          print(uid);
          navigatorPushAndRemoveUntil(context: context, widget: const MyApp());
        }
        if (state is ErrorLoginState) {
          showToast(text:'Email or Password incorrect' , state: ToastState.ERROR);
        }
      }, builder: (BuildContext context, state) {
        LoginCubit cubit = LoginCubit.get(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 312.0,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(32.0), 
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
                      height: 312.0,
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
                    Image.asset(
                      'assets/images/home.png',
                      height: 88.0,
                    ),
                    SizedBox(
                      key: key,
                      height: 18.0,
                    ),
                    Positioned(
                      key: key,
                      bottom: 64,
                      right: 124,
                      child: Text(
                        key: key,
                        'Welcome',
                        style: const TextStyle(
                          fontFamily: 'jannah',
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  key: key,
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        defualtFormField(
                            controller: emailController,
                            prefixIcon: IconBroken.Message,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter your email';
                              }
                              return null;
                            }),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: defualtFormField(
                              maxLines: 1,
                              controller: passController,
                              prefixIcon: IconBroken.Lock,
                              suffixIcon: cubit.suffixIcon,
                              isPressSuffix: () {
                                cubit.changeAbscure();
                              },
                              hintText: 'Password',
                              obscureText: cubit.abscureText,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your Password';
                                }
                                return null;
                              }),
                        ),
                        ConditionalBuilder(
                            condition: state is! LoadingLoginState,
                            builder: (context) => defualtBottton(
                                onPressed: () async {
                                  if (formkey.currentState!.validate()) {
                                    cubit.signInWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passController.text);
                                  }
                                },
                                text: 'login'),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator())),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          children: [
                            const Text('don\'t have account?'),
                            TextButton(
                                onPressed: () {
                                  navigatorTo(
                                      context: context,
                                      screen: RegesterScreen());
                                },
                                child: const Text('Sign up')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
