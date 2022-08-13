import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/albums_model.dart';
import '../../data/repositories/album_repo.dart';
import '../../utils/storageutil.dart';

part 'albums_event.dart';

part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  final AlbumsRepository albumsRepository;

  AlbumsBloc(this.albumsRepository) : super(AlbumsLoadingState()) {
    on<AlbumsEvent>((event, emit) async {
      if (event is LoadAlbumsEvent || event is RefreshAlbumsEvent) {
        emit(AlbumsLoadingState());
        try {
          final albums = await albumsRepository.fetchAlbumsData();
          final storage = StorageUtil.getString('albumsData');
          if(storage.isEmpty){
            StorageUtil.putString('albumsData', albumsToJson(albums));
            emit(AlbumsLoadedState(albums: albums));
          }else{
            final List<Albums> albumsFromStorage = albumsFromJson(storage);
            emit(AlbumsLoadedState(albums: albumsFromStorage));
          }
        } catch (e) {
          emit(AlbumsErrorState(error: e.toString()));
        }
      }
    });
  }
}
