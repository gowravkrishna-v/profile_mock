import 'package:profile_mock/bloc/network_connectivity_bloc/network_connectivity_bloc.dart';
import 'package:profile_mock/bloc/photos_bloc/photos_bloc.dart';
import 'package:profile_mock/utilities/theme.dart';
import 'package:profile_mock/view/components/photos_screen/thumbnail_list_tile.dart';
import 'package:profile_mock/view/components/shared/custom_progress_indicator.dart';
import 'package:profile_mock/view/components/shared/custom_wrapper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotosScreen extends StatefulWidget {
  final int albumId;
  final String albumTitle;

  const PhotosScreen({
    super.key,
    required this.albumId,
    required this.albumTitle,
  });

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  @override
  void initState() {
    context.read<PhotosBloc>().add(
          FetchPhotos(
            albumId: widget.albumId,
            isConnected: (context.read<NetworkConnectivityBloc>().state
                    is NetworkConnectivitySuccess)
                ? true
                : false,
          ),
        );
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
        title: Text(
          widget.albumTitle,
        ),
      ),
      body: RefreshIndicator(
        color: redAccent,
        onRefresh: () async {
          context.read<PhotosBloc>().add(
                FetchPhotos(
                  albumId: widget.albumId,
                  isConnected: (context.read<NetworkConnectivityBloc>().state
                          is NetworkConnectivitySuccess)
                      ? true
                      : false,
                ),
              );
        },
        child: Stack(
          children: [
            ListView(),
            BlocBuilder<PhotosBloc, PhotosState>(
              builder: (context, photosState) {
                if (photosState is PhotosFetchLoading) {
                  return const Center(child: CustomProgressIndicator());
                } else if (photosState is PhotosFetchSuccess) {
                  if (photosState.photos.isEmpty) {
                    return Center(
                      child: Text(
                        "No photos to display",
                        style: style7,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: photosState.photos.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          ThumbnailListTile(
                            photo: photosState.photos[index],
                            onTap: () => showDialog(
                              context: context,
                              builder: (context) => Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: Card(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          memCacheHeight: 200,
                                          memCacheWidth: 200,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              photosState.photos[index].url!,
                                          progressIndicatorBuilder: (context,
                                                  url, progress) =>
                                              const CustomProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.error,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 10,
                                    ),
                                    child: Text(
                                      photosState.photos[index].title ?? "",
                                      textAlign: TextAlign.center,
                                      style: style9.copyWith(
                                        color: white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (photosState is PhotosFetchFailure) {
                  return Center(
                    child: Text(
                      photosState.error,
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
