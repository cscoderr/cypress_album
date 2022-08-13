part of 'albums_bloc.dart';

abstract class AlbumsEvent extends Equatable {
  const AlbumsEvent();
}

class LoadAlbumsEvent extends AlbumsEvent {
  @override
  List<Object> get props => [];
}

class RefreshAlbumsEvent extends AlbumsEvent {
  @override
  List<Object> get props => [];
}
