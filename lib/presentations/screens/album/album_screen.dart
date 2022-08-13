import 'package:cypress_album/business_logic/albums/albums_bloc.dart';
import 'package:cypress_album/business_logic/photos/photos_bloc.dart';
import 'package:cypress_album/presentations/widgets/album_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/photos_model.dart';
import '../../../data/repositories/photos_repo.dart';
import '../../widgets/albums_with_album_card.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AlbumScreenState();
  }
}

class AlbumScreenState extends State<AlbumScreen> {

  final PhotosRepository photosRepository = PhotosRepository();

  @override
  void didChangeDependencies() {
    BlocProvider.of<AlbumsBloc>(context).add(LoadAlbumsEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final photoBloc = BlocProvider.of<PhotosBloc>(context);
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text("Cypress Albums", style: TextStyle(color: Colors.black, fontSize: 20.0),),
          ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<AlbumsBloc,AlbumsState>(
            builder: (context,state){
              if( state is AlbumsLoadingState){
                return  const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(state is AlbumsLoadedState){
                  return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:   [
                    for(int i = 0; i < state.albums.length; i++)
                    BlocBuilder <PhotosBloc,PhotosState>(
                      bloc: photoBloc..add(LoadPhotosEvent(albumId: i)),
                      builder: (context,state){
                        if( state is PhotosLoadingState){
                          return  const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if(state is PhotosLoadedState){
                          final photos = state.photos;
                          return AlbumsWithAlbumCard(
                            albumIndex: i,
                            photos: photos,
                          );
                        }
                        return Container();
                      }
                    )
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}


