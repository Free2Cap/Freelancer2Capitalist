import 'dart:developer';
import 'package:intl/intl.dart' as intl;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelancer2capitalist/main.dart';
import 'package:freelancer2capitalist/models/UIHelper.dart';
import 'package:freelancer2capitalist/models/chat_room_model.dart';
import 'package:freelancer2capitalist/pages/chat_pages/widgets/chat_helper.dart';
import '../../models/message_model.dart';
import '../../models/user_model.dart';

class ChatRoom extends StatefulWidget {
  final UserModel targetUser;
  final ChatRoomModel chatRoom;
  final UserModel userModel;
  final User firebaseUser;
  const ChatRoom(
      {super.key,
      required this.targetUser,
      required this.chatRoom,
      required this.userModel,
      required this.firebaseUser});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController messageController = TextEditingController();

  void sendMessage() async {
    String msg = messageController.text.trim();
    messageController.clear();

    if (msg != '') {
      //send message
      MessageModel newMessage = MessageModel(
        messageId: uuid.v1(),
        sender: widget.userModel.uid,
        createdon: DateTime.now(),
        text: msg,
        seen: false,
      );
      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatRoom.chatroomid)
          .collection("messages")
          .doc(newMessage.messageId)
          .set(newMessage.toMap())
          .then((value) => log("message sent"));
      widget.chatRoom.lastMessage = msg;
      widget.chatRoom.sequnece = DateTime.now();
      FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(widget.chatRoom.chatroomid)
          .set(widget.chatRoom.toMap())
          .then((value) => log("last message saved"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              backgroundImage:
                  NetworkImage(widget.targetUser.profilepic.toString()),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(widget.targetUser.fullname.toString()),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () =>
                  // CallUtils.dial(
                  //   from: widget.userModel,
                  //   to: widget.targetUser,
                  //   context: context,
                  // ),
                  {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (_) => const VideoCallScreen())), //{
                UIHelper.showAlertDialog(
                    context, 'Video Call', 'This will be new workspace'),
              },
              child: const Icon(Icons.video_call),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            //This is where chats will go
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("chatrooms")
                      .doc(widget.chatRoom.chatroomid)
                      .collection('messages')
                      .orderBy("createdon", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        QuerySnapshot dataSnapshot =
                            snapshot.data as QuerySnapshot;
                        MessageModel? _previousMessage;
                        return ListView.builder(
                          reverse: true,
                          itemCount: dataSnapshot.docs.length,
                          itemBuilder: (context, index) {
                            final currentMessage = MessageModel.fromMap(
                              dataSnapshot.docs[index].data()
                                  as Map<String, dynamic>,
                            );
                            final isCurrentUser =
                                currentMessage.sender == widget.userModel.uid;
                            final showAvatar = _previousMessage == null ||
                                _previousMessage!.sender !=
                                    currentMessage.sender;

                            _previousMessage = currentMessage;

                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: isCurrentUser
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                if (!isCurrentUser && showAvatar)
                                  CustomCircleAvatar(
                                    imageUrl:
                                        widget.targetUser.profilepic.toString(),
                                  ),
                                const SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: isCurrentUser
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: isCurrentUser
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: SizedBox(
                                        width: (() {
                                          final textSpan = TextSpan(
                                              text: currentMessage.text
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white));
                                          final textPainter = TextPainter(
                                              text: textSpan,
                                              maxLines: 1,
                                              textDirection: TextDirection.ltr);
                                          textPainter.layout(
                                              minWidth: 0,
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7);
                                          return textPainter.width <=
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.7
                                              ? textPainter.width
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7;
                                        })(),
                                        child: Text(
                                          currentMessage.text.toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      intl.DateFormat('HH:mm')
                                          .format(currentMessage.createdon!),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 5),
                                if (isCurrentUser && showAvatar)
                                  CustomCircleAvatar(
                                    imageUrl:
                                        widget.userModel.profilepic.toString(),
                                  ),
                              ],
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text("An error occured ${snapshot.error}");
                      } else {
                        return Center(
                          child:
                              Text("Say hi to ${widget.targetUser.fullname}"),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: messageController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Message",
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        sendMessage();
                      },
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context).colorScheme.secondary,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
