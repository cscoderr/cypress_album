import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/photos_model.dart';
import '../../data/repositories/photos_repo.dart';

part 'photos_event.dart';

part 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final PhotosRepository photosRepository;

  PhotosBloc(this.photosRepository) : super(PhotosLoadingState()) {
    on<PhotosEvent>((event, emit) async {
      if (event is LoadPhotosEvent) {
        emit(PhotosLoadingState());
        try {
          final photos = await photosRepository.fetchPhotosData(event.albumId);
          log("get photos");
          emit(PhotosLoadedState(photos: photos));
        } catch (e) {
          emit(PhotosErrorState(error: e.toString()));
        }
      }
    });
  }
}
