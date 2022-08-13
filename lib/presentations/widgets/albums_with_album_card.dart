import 'package:cypress_album/data/model/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'album_card.dart';

class AlbumsWithAlbumCard extends StatefulWidget {
  const AlbumsWithAlbumCard({
    Key? key,
    required this.albumIndex,
    required this.photos,
  }) : super(key: key);

  final int albumIndex;
  final List<Photos> photos;

  @override
  State<StatefulWidget> createState() {
   return AlbumsWithAlbumCardState();
  }


}
class AlbumsWithAlbumCardState extends State<AlbumsWithAlbumCard> {

  void storeData()async{
    final prefs = await SharedPreferences.getInstance();
    final albumIDList = prefs.getStringList('albumIDList') ?? [];
    final imageList = prefs.getStringList('imageList') ?? [];
    final albumTitleList = prefs.getStringList('albumTitleList') ?? [];

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
            padding: const EdgeInsets.only(left:16.0),
            child: Text("Album Title ${widget.albumIndex}",style: const TextStyle(color: Colors.black, fontSize: 18.0,),
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
          SizedBox(
            height: 200,
            child: InfiniteListView.builder(
              scrollDirection: Axis.horizontal,
              //itemCount: widget.photos.length ,
              itemBuilder: (context, index) {
                final i = index % widget.photos.length;
                return AlbumCard(
                    image: widget.photos[i].thumbnailUrl,
                    albumTitle: widget.photos[i].title,
                    size: 130
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}