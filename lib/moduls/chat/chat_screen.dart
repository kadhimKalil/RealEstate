import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/cubit/cubit.dart';
import 'package:flutter_app/layout/cubit/states.dart';
import 'package:flutter_app/models/users_model.dart';
import 'package:flutter_app/moduls/chat_details/chat_details.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_app/shared/style/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RealEstateCubit, RealEstateStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = RealEstateCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Chat')),
          ),
          body: ConditionalBuilder(
            condition: cubit.users.isNotEmpty,
            builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildChatItem(cubit.users[index], context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: cubit.users.length ,
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildChatItem(UsersModel model , context) => InkWell(
        onTap: () {
          navigatorTo(context: context, screen: ChatDetailsScreen(model));
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Text(
                '${model.name}',
                style: const TextStyle(
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      );
}
