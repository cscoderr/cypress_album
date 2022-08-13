part of 'albums_bloc.dart';

abstract class AlbumsState extends Equatable {
  const AlbumsState();
}

class AlbumsEmptyState extends AlbumsState {
  @override
  List<Object?> get props => [];
}

class AlbumsLoadingState extends AlbumsState {
  @override
  List<Object> get props => [];
}

class AlbumsLoadedState extends AlbumsState {
  final List<Albums> albums;

  const AlbumsLoadedState({required this.albums});

  @override
  List<Object?> get props => [albums];
}

class AlbumsErrorState extends AlbumsState {
  final String error;

  const AlbumsErrorState({required this.error});

  @override
  List<Object?> get props => [];
}
