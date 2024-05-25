import 'package:profile_mock/model/photo_model.dart';
import 'package:profile_mock/utilities/theme.dart';
import 'package:profile_mock/view/components/shared/custom_progress_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ThumbnailListTile extends StatelessWidget {
  final PhotoModel photo;
  final VoidCallback onTap;
  const ThumbnailListTile({
    super.key,
    required this.photo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                memCacheHeight: 200,
                memCacheWidth: 200,
                fit: BoxFit.cover,
                imageUrl: photo.thumbnailUrl ?? "",
                progressIndicatorBuilder: (context, url, progress) =>
                    const CustomProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                ),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                photo.title ?? "",
                style: style5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
