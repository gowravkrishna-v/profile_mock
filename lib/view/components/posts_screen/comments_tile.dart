import 'package:profile_mock/model/comment_model.dart';
import 'package:profile_mock/utilities/theme.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CommentsTile extends StatelessWidget {
  final int index;
  final int lastIndex;
  final CommentModel comment;
  const CommentsTile(
      {super.key,
      required this.index,
      required this.lastIndex,
      required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0),
                shape: const CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    comment.email![0],
                    style: style6.copyWith(
                      color: white,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.email ?? "",
                    style: style1.copyWith(
                      color: black54,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    comment.name ?? "",
                    style: style8,
                  ),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 12,
          ),
          child: Text(
            comment.body ?? "",
            style: style4,
          ),
        ),
        if (index != lastIndex)
          Divider(
            thickness: 1,
            color: grey,
          ),
      ],
    );
  }
}
