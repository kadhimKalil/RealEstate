import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/cubit/cubit.dart';
import 'package:flutter_app/layout/cubit/states.dart';
import 'package:flutter_app/models/users_model.dart';
import 'package:flutter_app/moduls/chat_details/new_message.dart';
import 'package:flutter_app/shared/components/constant.dart';
import 'package:flutter_app/shared/style/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {

  UsersModel usersModel;
  ChatDetailsScreen(this.usersModel);

  var controller = TextEditingController();
  @override
  Widget build(BuildContext context ) {
    return BlocConsumer<RealEstateCubit, RealEstateStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {

        var cubit = RealEstateCubit.get(context);
        return Scaffold(
          appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        usersModel.image!,
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      usersModel.name!,
                    ),
                  ],
                ),
              ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: Future.value(FirebaseAuth.instance.currentUser),
                    builder: (ctx, AsyncSnapshot futureSnapchot) {
                      if (futureSnapchot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users/${uid}/chats/${usersModel.uid!}/messages')
                              .orderBy('createdAt', descending: true)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot streamSnapShot) {
                            if (streamSnapShot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return ListView.builder(
                              reverse: true,
                              itemCount: streamSnapShot.data.docs.length,
                              itemBuilder: (context, index) => bubbleMessage(
                                streamSnapShot.data.docs[index]['text'],
                                streamSnapShot.data.docs[index]['userId'] ==
                                    futureSnapchot.data.uid,
                                key: ValueKey(
                                    streamSnapShot.data.docs[index].id),
                              ),
                            );
                          });
                    },
                  ),
                ),
                NewMessage( userid:usersModel.uid!)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget bubbleMessage(String message, bool isMy, {Key? key}) {
    return Row(
      mainAxisAlignment: isMy ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 140.0,
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 10.0,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 8.0,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12.0),
                topRight: const Radius.circular(12.0),
                bottomLeft: !isMy
                    ? const Radius.circular(0)
                    : const Radius.circular(12.0),
                bottomRight: isMy
                    ? const Radius.circular(0)
                    : const Radius.circular(12.0),
              ),
              color: isMy ? defualtColor : Colors.grey[300]),
          child: Text(
            message,
            style: TextStyle(color: isMy ? Colors.white : Colors.black),
          ),
        ),
      ],
    );
  }
}
