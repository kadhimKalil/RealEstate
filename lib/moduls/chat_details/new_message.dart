import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/shared/components/constant.dart';
import 'package:flutter_app/shared/style/colors.dart';

class NewMessage extends StatefulWidget {
  String userid;

  NewMessage({super.key, required this.userid});

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    // FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
    .collection('users/${uid}/chats/${widget.userid}/messages')
    .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user!.uid,
    });
 // add to recivedId
    FirebaseFirestore.instance
    .collection('users/${widget.userid}/chats/${uid}/messages')
    .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
    });
    _controller.clear();

    setState(() {
      _enteredMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
 
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: defualtColor,
            icon: Icon(
              Icons.send,
            ),
            onPressed: _enteredMessage.trim().isEmpty || _enteredMessage == ''
                ? null
                : _sendMessage,
          )
        ],
      ),
    );
  }
}
