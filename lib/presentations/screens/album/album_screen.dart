import 'package:cypress_album/business_logic/albums/albums_bloc.dart';
import 'package:cypress_album/business_logic/photos/photos_bloc.dart';
import 'package:cypress_album/presentations/widgets/albums_with_album_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AlbumScreenState();
  }
}

class AlbumScreenState extends State<AlbumScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AlbumsBloc>().add(LoadAlbumsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final photoBloc = BlocProvider.of<PhotosBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Cypress Albums",
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<AlbumsBloc, AlbumsState>(
            builder: (context, state) {
              if (state is AlbumsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is AlbumsLoadedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: state.albums
                      .map(
                        (album) => AlbumsWithAlbumCard(
                            albumTitle: album.title, albumIndex: album.id),
                      )
                      .toList(),
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
