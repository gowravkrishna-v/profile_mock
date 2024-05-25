import 'package:profile_mock/bloc/albums_bloc/albums_bloc.dart';
import 'package:profile_mock/bloc/network_connectivity_bloc/network_connectivity_bloc.dart';
import 'package:profile_mock/bloc/posts_bloc/posts_bloc.dart';
import 'package:profile_mock/bloc/profile_bloc/profile_bloc.dart';
import 'package:profile_mock/utilities/theme.dart';
import 'package:profile_mock/view/components/profile_screen/albums_section/albums_tab.dart';
import 'package:profile_mock/view/components/profile_screen/posts_section/posts_tab.dart';
import 'package:profile_mock/view/components/profile_screen/user_info_widget.dart';
import 'package:profile_mock/view/components/shared/custom_progress_indicator.dart';
import 'package:profile_mock/view/components/shared/custom_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    tabController.addListener(() {});
    context.read<ProfileBloc>().add(
          FetchUserProfile(
            isConnected: (context.read<NetworkConnectivityBloc>().state
                    is NetworkConnectivitySuccess)
                ? true
                : false,
          ),
        );
    context.read<AlbumsBloc>().add(
          FetchAlbums(
            isConnected: (context.read<NetworkConnectivityBloc>().state
                    is NetworkConnectivitySuccess)
                ? true
                : false,
          ),
        );
    context.read<PostsBloc>().add(
          FetchPosts(
            isConnected: (context.read<NetworkConnectivityBloc>().state
                    is NetworkConnectivitySuccess)
                ? true
                : false,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return CustomWrapper(
      body: RefreshIndicator(
        color: redAccent,
        onRefresh: () async {
          context.read<ProfileBloc>().add(
                FetchUserProfile(
                  isConnected: (context.read<NetworkConnectivityBloc>().state
                          is NetworkConnectivitySuccess)
                      ? true
                      : false,
                ),
              );
          if (tabController.index == 0) {
            context.read<AlbumsBloc>().add(
                  FetchAlbums(
                    isConnected: (context.read<NetworkConnectivityBloc>().state
                            is NetworkConnectivitySuccess)
                        ? true
                        : false,
                  ),
                );
          } else {
            context.read<PostsBloc>().add(FetchPosts(
                  isConnected: (context.read<NetworkConnectivityBloc>().state
                          is NetworkConnectivitySuccess)
                      ? true
                      : false,
                ));
          }
        },
        child: Stack(
          children: [
            ListView(),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, profileState) {
                if (profileState is ProfileFetchLoading) {
                  return const Center(child: CustomProgressIndicator());
                } else if (profileState is ProfileFetchSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      UserInfoWidget(
                        profile: profileState.profile,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TabBar(
                        controller: tabController,
                        indicatorPadding: const EdgeInsets.all(4),
                        tabs: const [
                          Tab(
                            text: "Albums",
                          ),
                          Tab(
                            text: "Posts",
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              BlocBuilder<AlbumsBloc, AlbumsState>(
                                builder: (context, albumsState) {
                                  if (albumsState is AlbumsFetchLoading) {
                                    return const CustomProgressIndicator();
                                  } else if (albumsState
                                      is AlbumsFetchSuccess) {
                                    if (albumsState.albums.isEmpty) {
                                      return Center(
                                        child: Text(
                                          "No albums found",
                                          style: style7,
                                        ),
                                      );
                                    }
                                    return AlbumsTab(
                                      albums: albumsState.albums,
                                    );
                                  } else if (albumsState
                                      is AlbumsFetchFailure) {
                                    return Center(
                                      child: Text(
                                        albumsState.error,
                                        style: style7,
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                              BlocBuilder<PostsBloc, PostsState>(
                                builder: (context, postsState) {
                                  if (postsState is PostFetchLoading) {
                                    return const CustomProgressIndicator();
                                  } else if (postsState is PostsFetchSuccess) {
                                    if (postsState.posts.isEmpty) {
                                      return Center(
                                        child: Text(
                                          "No posts found",
                                          style: style7,
                                        ),
                                      );
                                    }
                                    return PostsTab(
                                      posts: postsState.posts,
                                    );
                                  } else if (postsState is PostsFetchFailure) {
                                    return Center(
                                      child: Text(
                                        postsState.error,
                                        style: style7,
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (profileState is ProfileFetchFailure) {
                  return Center(
                    child: Text(
                      profileState.error,
                      style: style7,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
