import 'package:profile_mock/model/album_model.dart';
import 'package:profile_mock/utilities/theme.dart';
import 'package:profile_mock/view/screens/photos_screen.dart';
import 'package:flutter/material.dart';

class Album extends StatelessWidget {
  final AlbumModel album;
  const Album({
    super.key,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhotosScreen(
            albumId: album.id ?? 1,
            albumTitle: album.title ?? "Album",
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Card(
              elevation: 0,
              color: redAccent.withOpacity(0.3),
              child: Icon(
                Icons.folder_outlined,
                size: 36,
                color: red,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
              left: 5,
            ),
            child: Text(
              album.title ?? "",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: style2,
            ),
          ),
        ],
      ),
    );
  }
}
