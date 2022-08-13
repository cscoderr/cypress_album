import 'package:cypress_album/business_logic/photos/photos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'album_card.dart';

class AlbumsWithAlbumCard extends StatefulWidget {
  const AlbumsWithAlbumCard({
    Key? key,
    required this.albumIndex,
    required this.albumTitle,
  }) : super(key: key);

  final int albumIndex;
  final String albumTitle;

  @override
  State<StatefulWidget> createState() {
    return AlbumsWithAlbumCardState();
  }
}

class AlbumsWithAlbumCardState extends State<AlbumsWithAlbumCard> {
  void storeData() async {
    final prefs = await SharedPreferences.getInstance();
    final albumIDList = prefs.getStringList('albumIDList') ?? [];
    final imageList = prefs.getStringList('imageList') ?? [];
    final albumTitleList = prefs.getStringList('albumTitleList') ?? [];
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<PhotosBloc>()
          .add(LoadPhotosEvent(albumId: widget.albumIndex));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              widget.albumTitle,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          ),
          // SizedBox(
          //   height: 200,
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     scrollDirection: Axis.horizontal,
          //     //itemCount: widget.photos.length ,
          //     itemBuilder: (context, index) {
          //       final i = index % widget.photos.length;//<----to the right
          //       return AlbumCard(
          //           image: widget.photos[i].thumbnailUrl,
          //           albumTitle: widget.photos[i].title,
          //           size: 130
          //       );
          //     },
          //   ),
          // ),
          BlocBuilder<PhotosBloc, PhotosState>(
            builder: (context, state) {
              if (state is PhotosLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PhotosLoadedState) {
                return SizedBox(
                  height: 200,
                  child: InfiniteListView.builder(
                    scrollDirection: Axis.horizontal,
                    //itemCount: widget.photos.length ,
                    itemBuilder: (context, index) {
                      final i = index % state.photos.length;
                      return AlbumCard(
                        image: state.photos[i].url,
                        albumTitle: state.photos[i].title,
                        size: 130,
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
