part of 'photos_bloc.dart';

abstract class PhotosState extends Equatable {
  const PhotosState();
}

class PhotosEmpty extends PhotosState {
  @override
  List<Object?> get props => [];
}

class PhotosLoadingState extends PhotosState {
  @override
  List<Object> get props => [];
}

class PhotosLoadedState extends PhotosState {
  final List<Photos> photos;

  const PhotosLoadedState({required this.photos});

  @override
  List<Object?> get props => [photos];
}

class PhotosErrorState extends PhotosState {
  final String error;

  const PhotosErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
