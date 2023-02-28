// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:freelancer2capitalist/pages/chat_pages/search_page.dart';

// class ChatUserCard extends StatefulWidget {
//   const ChatUserCard({super.key});

//   @override
//   State<ChatUserCard> createState() => _ChatUserCardState();
// }

// class _ChatUserCardState extends State<ChatUserCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(child: Container()),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context){
//             return SearchPage(userModel: widget.userModel, firebaseUser: widget.firebaseUser)
//           }))
//         },
//         child: const Icon(Icons.search),
//       ),
//     );
//   }
// }
