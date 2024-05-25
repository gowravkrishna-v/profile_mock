import 'package:profile_mock/bloc/albums_bloc/albums_bloc.dart';
import 'package:profile_mock/bloc/comments_bloc/comments_bloc.dart';
import 'package:profile_mock/bloc/network_connectivity_bloc/network_connectivity_bloc.dart';
import 'package:profile_mock/bloc/photos_bloc/photos_bloc.dart';
import 'package:profile_mock/bloc/posts_bloc/posts_bloc.dart';
import 'package:profile_mock/bloc/profile_bloc/profile_bloc.dart';
import 'package:profile_mock/repository/cloud_repository.dart';
import 'package:profile_mock/repository/local_repository.dart';
import 'package:profile_mock/utilities/theme.dart';
import 'package:profile_mock/view/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LocalRepository>(
          create: (context) => LocalRepository(),
        ),
        RepositoryProvider<CloudRepository>(
          create: (context) => CloudRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NetworkConnectivityBloc>(
            create: (context) => NetworkConnectivityBloc()
              ..add(
                NetworkObserve(),
              ),
          ),
          BlocProvider<PostsBloc>(
            create: (context) => PostsBloc(
              cloudRepository: context.read<CloudRepository>(),
              localRepository: context.read<LocalRepository>(),
            ),
          ),
          BlocProvider<AlbumsBloc>(
            create: (context) => AlbumsBloc(
              cloudRepository: context.read<CloudRepository>(),
              localRepository: context.read<LocalRepository>(),
            ),
          ),
          BlocProvider<PhotosBloc>(
            create: (context) => PhotosBloc(
              cloudRepository: context.read<CloudRepository>(),
              localRepository: context.read<LocalRepository>(),
            ),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              cloudRepository: context.read<CloudRepository>(),
              localRepository: context.read<LocalRepository>(),
            ),
          ),
          BlocProvider<CommentsBloc>(
            create: (context) => CommentsBloc(
              cloudRepository: context.read<CloudRepository>(),
              localRepository: context.read<LocalRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: "Profile Mock",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              titleTextStyle: style9,
              scrolledUnderElevation: 0.5,
              elevation: 0,
              titleSpacing: 0,
            ),
            tabBarTheme: TabBarTheme(
              labelStyle: style5,
              indicatorColor: redAccent,
              labelColor: black,
              unselectedLabelColor: black54,
              unselectedLabelStyle: style4,
            ),
          ),
          home: const ProfileScreen(),
        ),
      ),
    );
  }
}
