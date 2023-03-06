import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String imageUrl;

  const CustomCircleAvatar({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey[300],
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}
