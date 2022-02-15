import 'dart:typed_data';

import 'package:audiotagger/audiotagger.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'playlists_provider.dart';
import 'songs_provider.dart';

class ArtworkProvider {
  final Audiotagger _audiotagger = Audiotagger();
  final SongsProvider _songsProvider = SongsProvider();

  Future<Uint8List?> getSongArtwork(SongModel song) async {
    Uint8List? result;
    try {
      result = await _audiotagger.readArtwork(path: song.data);
    } catch (exception) {
      result = null;
    }
    return result;
  }

  Future<Uint8List?> getAlbumArtwork(AlbumModel album) async {
    final ArtworkProvider _artworkProvider = ArtworkProvider();

    List<SongModel> _albumSongs =
        await _songsProvider.getAlbumSongs(album.album);

    if (_albumSongs.isEmpty) {
      return null;
    }

    return await _artworkProvider.getSongArtwork(_albumSongs[0]);
  }

  Future<Uint8List?> getArtistArtwork(ArtistModel artist) async {
    final ArtworkProvider _artworkProvider = ArtworkProvider();

    List<SongModel> _artistSongs =
        await _songsProvider.getArtistSongs(artist.artist);

    if (_artistSongs.isEmpty) {
      return null;
    }

    return await _artworkProvider.getSongArtwork(_artistSongs[0]);
  }

  Future<Uint8List?> getPlaylistArtwork(String playlistName) async {
    final ArtworkProvider _artworkProvider = ArtworkProvider();
    final PlaylistsProvider _playlistsProvider = PlaylistsProvider();

    List<SongModel> _playlistSongs =
        await _playlistsProvider.getPlaylistSongs(playlistName);

    if (_playlistSongs.isEmpty) {
      return null;
    }

    return await _artworkProvider.getSongArtwork(_playlistSongs[0]);
  }
}
