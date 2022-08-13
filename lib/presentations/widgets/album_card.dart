import 'package:cypress_album/data/model/photos_model.dart';
import 'package:flutter/material.dart';

class AlbumCard extends StatelessWidget {
  final String? image;
  final String? albumTitle;
  final double size;
  const AlbumCard({
    Key? key,
    required this.image,
    required this.albumTitle,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            image ?? "http://www.google.de/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png",
            width: size,
            height: size,
            fit: BoxFit.scaleDown,
          ),
          const SizedBox(height: 10),
          Text(albumTitle ?? " ", style: const TextStyle(overflow: TextOverflow.ellipsis),),
        ],
      ),
    );
  }
}