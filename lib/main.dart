import 'package:cypress_album/business_logic/albums/albums_bloc.dart';
import 'package:cypress_album/business_logic/photos/photos_bloc.dart';
import 'package:cypress_album/data/repositories/album_repo.dart';
import 'package:cypress_album/data/repositories/photos_repo.dart';
import 'package:cypress_album/presentations/screens/album/album_screen.dart';
import 'package:cypress_album/utils/bloc_supervisor.dart';
import 'package:cypress_album/utils/storageutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageUtil.getInstance();
  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AlbumsRepository albumsRepository = AlbumsRepository();
  final PhotosRepository photosRepository = PhotosRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlbumsBloc>(
          create: (context) => AlbumsBloc(albumsRepository),
        ),
        BlocProvider<PhotosBloc>(
          create: (context) => PhotosBloc(photosRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Cypress Albums',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AlbumScreen(),
      ),
    );
  }
}
