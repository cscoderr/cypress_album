part of 'photos_bloc.dart';

abstract class PhotosEvent extends Equatable {
  const PhotosEvent();
}

class LoadPhotosEvent extends PhotosEvent {
  final int albumId;

  const LoadPhotosEvent({required this.albumId});

  @override
  List<Object> get props => [albumId];
}
