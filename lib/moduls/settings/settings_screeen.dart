import 'package:flutter/material.dart';
import 'package:flutter_app/layout/cubit/cubit.dart';
import 'package:flutter_app/layout/cubit/states.dart';
import 'package:flutter_app/moduls/chat/chat_screen.dart';
import 'package:flutter_app/moduls/chat_details/chat_details.dart';
import 'package:flutter_app/moduls/edit_profile/edit_profile.dart';
import 'package:flutter_app/moduls/test.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_app/shared/style/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RealEstateCubit, RealEstateStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Account')),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 68,
                    backgroundColor: defualtColor,
                    child: const CircleAvatar(
                      radius: 64.0,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=740&t=st=1663938112~exp=1663938712~hmac=6f871e062ef2492d8a0d67bfe6852c26122336025894da25dff70a5172d5dca5'),
                    ),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  InkWell(
                    onTap: () {
                      navigatorTo(context: context, screen: EditProfile());
                    },
                    child: defaultAccountButton(
                        context: context,
                        icon: Icons.person_outline,
                        lable: 'Edit Profile'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    onTap: () {
                      // navigatorTo(context: context, screen: ChatDetailsScreen());
                    },
                    child: defaultAccountButton(
                        context: context,
                        icon: Icons.notifications_outlined,
                        lable: 'Notifications'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    onTap: () {},
                    child: defaultAccountButton(
                        context: context,
                        icon: Icons.settings_outlined,
                        lable: 'Settings'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    onTap: () {
                      RealEstateCubit.get(context).currentIndex = 0;
                      RealEstateCubit.get(context).users = [];
                      signOut(context);
                    },
                    child: defaultAccountButton(
                        context: context,
                        icon: Icons.logout_outlined,
                        lable: 'Logout'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
