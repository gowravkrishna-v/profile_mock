import 'package:profile_mock/bloc/comments_bloc/comments_bloc.dart';
import 'package:profile_mock/bloc/network_connectivity_bloc/network_connectivity_bloc.dart';
import 'package:profile_mock/model/post_model.dart';
import 'package:profile_mock/utilities/theme.dart';
import 'package:profile_mock/view/components/posts_screen/comments_tile.dart';
import 'package:profile_mock/view/components/shared/custom_progress_indicator.dart';
import 'package:profile_mock/view/components/shared/custom_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  final PostModel currentPost;
  const PostScreen({
    super.key,
    required this.currentPost,
  });

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    context.read<CommentsBloc>().add(FetchComments(
          postId: widget.currentPost.id.toString(),
          isConnected: (context.read<NetworkConnectivityBloc>().state
                  is NetworkConnectivitySuccess)
              ? true
              : false,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomWrapper(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_rounded,
          ),
        ),
        title: const Text(
          "Post",
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CommentsBloc>().add(FetchComments(
                postId: widget.currentPost.id.toString(),
                isConnected: (context.read<NetworkConnectivityBloc>().state
                        is NetworkConnectivitySuccess)
                    ? true
                    : false,
              ));
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                widget.currentPost.title ?? "",
                style: style9,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.currentPost.body ?? "",
                style: style6,
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 2,
                color: grey,
              ),
              Text(
                "Comments",
                style: style8,
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<CommentsBloc, CommentsState>(
                builder: (context, commentsState) {
                  if (commentsState is CommentsFetchLoading) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.sizeOf(context).height * 0.2,
                      ),
                      child: const Center(child: CustomProgressIndicator()),
                    );
                  } else if (commentsState is CommentsFetchSuccess) {
                    if (commentsState.comments.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.sizeOf(context).height * 0.2,
                        ),
                        child: Center(
                          child: Text(
                            "No comments",
                            style: style7,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: commentsState.comments.length,
                      itemBuilder: (context, index) => CommentsTile(
                        index: index,
                        lastIndex: commentsState.comments.length - 1,
                        comment: commentsState.comments[index],
                      ),
                    );
                  } else if (commentsState is CommentsFetchFailure) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.sizeOf(context).height * 0.2,
                      ),
                      child: Center(
                        child: Text(
                          commentsState.error,
                          style: style7,
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
