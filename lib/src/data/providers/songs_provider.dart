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

  /* search songs, albums, artist*/
  Future<List<dynamic>> search(String query) async {
    List<dynamic> _songs = await searchSongs(query);
    List<dynamic> _artists = await searchArtists(query);
    List<dynamic> _albums = await searchAlbums(query);
    print(_songs.length);
    print(_artists.length);
    print(_albums.length);

    return _songs.followedBy(_artists).followedBy(_albums).toList();
  }

  Future<List<SongModel>> searchSongs(String query) async {
    List<dynamic> result = await _audioQuery.queryWithFilters(
      query,
      WithFiltersType.AUDIOS,
      args: AudiosArgs.TITLE,
    );
    return result.toSongModel();
  }

  Future<List<ArtistModel>> searchArtists(String query) async {
    List<dynamic> result = await _audioQuery.queryWithFilters(
      query,
      WithFiltersType.ARTISTS,
      args: AudiosArgs.ARTIST,
    );
    return result.toArtistModel();
  }

  Future<List<AlbumModel>> searchAlbums(String query) async {
    List<dynamic> result = await _audioQuery.queryWithFilters(
      query,
      WithFiltersType.ALBUMS,
      args: AudiosArgs.ALBUM,
    );
    return result.toAlbumModel();
  }
}
