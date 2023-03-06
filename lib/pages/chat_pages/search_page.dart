import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelancer2capitalist/main.dart';
import 'package:freelancer2capitalist/models/chat_room_model.dart';
import 'package:freelancer2capitalist/pages/chat_pages/chat_room.dart';

import '../../models/user_model.dart';

class SearchPage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const SearchPage(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  Future<ChatRoomModel?> getChatRoomModel(UserModel targetUser) async {
    ChatRoomModel? chatRoom;

    QuerySnapshot snapshotDocs = await FirebaseFirestore.instance
        .collection("chatrooms")
        .where("participants.${widget.userModel.uid}", isEqualTo: true)
        .where("participants.${targetUser.uid}", isEqualTo: true)
        .get();
    if (snapshotDocs.docs.isNotEmpty) {
      //Fetch the existing one
      log("there is chat room");
      var docData = snapshotDocs.docs[0].data();
      ChatRoomModel existingChatRoom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);

      chatRoom = existingChatRoom;
    } else {
      //create a new one
      ChatRoomModel newChatRoom = ChatRoomModel(
          chatroomid: uuid.v1(),
          lastMessage: "",
          participants: {
            widget.userModel.uid.toString(): true,
            targetUser.uid.toString(): true
          },
          sequnece: DateTime.now(),
          users: [widget.userModel.uid.toString(), targetUser.uid.toString()]);
      try {
        await FirebaseFirestore.instance
            .collection("chatrooms")
            .doc(newChatRoom.chatroomid)
            .set(newChatRoom.toMap());
      } on FirebaseException catch (ex) {
        log(ex.toString());
      }
      chatRoom = newChatRoom;
      log("new chatroom created");
    }

    return chatRoom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: "Email Address",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                setState(() {});
              },
              child: const Text("Search"),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where("email", isEqualTo: searchController.text)
                  .where("email", isNotEqualTo: widget.userModel.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

                    if (dataSnapshot.docs.isNotEmpty) {
                      Map<String, dynamic> userMap =
                          dataSnapshot.docs[0].data() as Map<String, dynamic>;

                      UserModel searchedUser = UserModel.fromMap(userMap);

                      return ListTile(
                        onTap: () async {
                          ChatRoomModel? chatroomModel =
                              await getChatRoomModel(searchedUser);

                          if (chatroomModel != null) {
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ChatRoom(
                                targetUser: searchedUser,
                                userModel: widget.userModel,
                                firebaseUser: widget.firebaseUser,
                                chatRoom: chatroomModel,
                              );
                            }));
                          }
                        },
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(searchedUser.profilepic!),
                        ),
                        title: Text(searchedUser.fullname!),
                        subtitle: Text(searchedUser.email!),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                      );
                    } else {
                      return const Text("No results Found");
                    }
                  } else if (snapshot.hasError) {
                    return Text("An error occured ${snapshot.error}");
                  } else {
                    return const Text("No results Found");
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
