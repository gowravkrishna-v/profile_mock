import 'package:profile_mock/model/post_model.dart';
import 'package:profile_mock/utilities/theme.dart';
import 'package:profile_mock/view/components/profile_screen/posts_section/post.dart';
import 'package:profile_mock/view/screens/post_screen.dart';
import 'package:flutter/material.dart';

class PostsTab extends StatelessWidget {
  final List<PostModel> posts;
  const PostsTab({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostScreen(
              currentPost: posts[index],
            ),
          ),
        ),
        child: Column(
          children: [
            Post(
              post: posts[index],
            ),
            if (index != (posts.length - 1))
              Divider(
                color: black26,
                thickness: 1,
              ),
          ],
        ),
      ),
    );
  }
}
