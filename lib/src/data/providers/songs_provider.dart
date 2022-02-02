import 'package:on_audio_query/on_audio_query.dart';

class SongsProvider {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future<List<SongModel>> getSongs([
    SongSortType sortType = SongSortType.DATE_ADDED,
    OrderType ordType = OrderType.DESC_OR_GREATER,
  ]) async {
    return await _audioQuery.querySongs(
      sortType: sortType,
      ignoreCase: true,
      orderType: ordType,
    );
  }

  Future<List<AlbumModel>> getAlbums([
    AlbumSortType sortType = AlbumSortType.ALBUM,
    OrderType ordType = OrderType.ASC_OR_SMALLER,
  ]) async {
    return await _audioQuery.queryAlbums(
      sortType: sortType,
      ignoreCase: true,
      orderType: ordType,
    );
  }

  /* get album specific songs */
  Future<List<SongModel>> getAlbumSongs(String album) async {
    List<dynamic> result = await _audioQuery.queryWithFilters(
      album,
      WithFiltersType.AUDIOS,
      args: AudiosArgs.ALBUM,
    );
    print(result.length);
    return result.toSongModel();
  }

  Future<List<ArtistModel>> getArtists([
    ArtistSortType sortType = ArtistSortType.ARTIST,
    OrderType ordType = OrderType.ASC_OR_SMALLER,
  ]) async {
    return await _audioQuery.queryArtists(
      sortType: sortType,
      ignoreCase: true,
      orderType: ordType,
    );
  }

  /* get artist specific songs */
  Future<List<SongModel>> getArtistSongs(String artist) async {
    List<dynamic> result = await _audioQuery.queryWithFilters(
      artist,
      WithFiltersType.AUDIOS,
      args: AudiosArgs.ARTIST,
    );
    return result.toSongModel();
  }
}
