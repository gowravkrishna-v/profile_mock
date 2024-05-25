import 'package:profile_mock/model/post_model.dart';
import 'package:profile_mock/utilities/theme.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final PostModel post;
  const Post({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 8,
      ),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title!,
              style: style8,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              post.body!,
              style: style4,
            )
          ],
        ),
      ),
    );
  }
}
