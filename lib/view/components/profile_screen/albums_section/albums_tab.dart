import 'package:profile_mock/model/album_model.dart';
import 'package:profile_mock/view/components/profile_screen/albums_section/album.dart';
import 'package:flutter/material.dart';

class AlbumsTab extends StatelessWidget {
  final List<AlbumModel> albums;
  const AlbumsTab({super.key, required this.albums});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        childAspectRatio: MediaQuery.sizeOf(context).width /
            (MediaQuery.of(context).size.height / 1.5),
        crossAxisSpacing: 5,
      ),
      itemCount: albums.length,
      itemBuilder: (context, index) => Album(
        album: albums[index],
      ),
    );
  }
}
