import 'package:on_audio_query/on_audio_query.dart';

class FavouritesEvents {
  const FavouritesEvents();
}

class AddSongToFavouritesEvent extends FavouritesEvents {
  final SongModel song;
  const AddSongToFavouritesEvent({required this.song});
}

class RemoveSongToFavouritesEvent extends FavouritesEvents {
  final SongModel song;
  const RemoveSongToFavouritesEvent({required this.song});
}
