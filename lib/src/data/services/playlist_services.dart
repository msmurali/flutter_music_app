// import 'package:music/src/data/providers/playlists_provider.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class PlaylistServices {
//   final OnAudioQuery _audioQuery = OnAudioQuery();
//   final PlaylistsProvider _playlistsProvider = PlaylistsProvider();

//   static Future<int> getPlaylistId(String playlistName) async {
//     late int _id;
//     final PlaylistsProvider _provider = PlaylistsProvider();
//     List<PlaylistModel> _playlists = await _provider.getPlaylists();

//     _playlists.map((playlist) {
//       if (playlist.playlist == playlistName) {
//         _id = playlist.id;
//       }
//     });

//     return _id;
//   }

//   Future<bool> createPlaylist(String playlistName) async {
//     return await _audioQuery.createPlaylist(playlistName);
//   }

//   Future<bool> rmPlaylist(int playlistId) async {
//     return await _audioQuery.removePlaylist(playlistId);
//   }

//   Future<bool> playlistAlreadyExists(playlistName) async {
//     bool _alreadyExists = false;

//     List<PlaylistModel> _playlists = await _playlistsProvider.getPlaylists();

//     _playlists.map((playlist) {
//       if (playlist.playlist == playlistName) {
//         _alreadyExists = true;
//       }
//     });

//     return _alreadyExists;
//   }

//   Future<bool> addToPlaylist(int playlistId, int songId) async {
//     return await _audioQuery.addToPlaylist(playlistId, songId);
//   }

//   Future<bool> addAllToPlaylist(int playlistId, List<SongModel> songs) async {
//     bool _result = true;

//     PlaylistServices _playlistServices = PlaylistServices();

//     songs.map((song) async {
//       _result = await _playlistServices.addToPlaylist(playlistId, song.id);
//     });

//     return _result;
//   }

//   Future<bool> songAlreadyInPlaylist(
//     int songId,
//     String playlistName,
//   ) async {
//     bool _alreadyExists = false;

//     int _playlistId = await getPlaylistId(playlistName);

//     await _playlistsProvider.getPlaylistSongs(_playlistId).then((songsList) {
//       songsList.map((song) {
//         if (song.id == songId) {
//           _alreadyExists = true;
//         }
//       });
//     });

//     return _alreadyExists;
//   }

//   Future<bool> rmFromPlaylist(int playlistId, int songId) async {
//     return await _audioQuery.removeFromPlaylist(playlistId, songId);
//   }
// }
