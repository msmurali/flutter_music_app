import 'package:on_audio_query/on_audio_query.dart';

class FavouritesEvents {
  const FavouritesEvents();
}

class MarkAsFavourite extends FavouritesEvents {
  final SongModel song;
  const MarkAsFavourite({required this.song});
}

class MarkAsNotFavourite extends FavouritesEvents {
  final SongModel song;
  const MarkAsNotFavourite({required this.song});
}
