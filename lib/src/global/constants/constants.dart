import 'package:on_audio_query/on_audio_query.dart';
import 'enums.dart';

const routes = <Routes, String>{
  Routes.homeRoute: '/',
  Routes.preferencesRoute: '/preferences',
  Routes.songsRoute: '/songs',
  Routes.infoRoute: '/info',
  Routes.favouritesRoute: '/favourites',
  Routes.playlistsRoute: '/playlists',
  Routes.searchRoute: '/search',
};

const recentsListSize = 20;

const gridSizes = [2, 3, 4, 5];

const keys = <StorageKey, String>{
  StorageKey.favourites: 'com.mk.music-favourites',
  StorageKey.recents: 'com.mk.music-recents',
  StorageKey.queue: 'com.mk.music-queue',
  StorageKey.queueIndex: 'com.mk.music-queue-index',
  StorageKey.playbackMode: 'com.mk.music-playback-mode',
  StorageKey.theme: 'com.mk.music-theme-mode',
  StorageKey.songsSortType: 'com.mk.music-song-sort-type',
  StorageKey.songsOrderType: 'com.mk.music-song-order-type',
  StorageKey.albumsSortType: 'com.mk.music-album-sort-type',
  StorageKey.albumsOrderType: 'com.mk.music-album-order-type',
  StorageKey.artistsSortType: 'com.mk.music-artist-sort-type',
  StorageKey.artistsOrderType: 'com.mk.music-srtist-order-type',
  StorageKey.view: 'com.mk.music-view',
  StorageKey.gridSize: 'com.mk.music-grid-size',
  StorageKey.preferences: 'com.mk.music-preferences',
};

const optionsText = <Option, String>{
  Option.playNext: 'Play next',
  Option.addToPlaylist: 'Add to Playlist',
  Option.removeFromPlaylist: 'Remove from Playlist',
  Option.addAllToPlaylist: 'Add all to Playlist',
  Option.removePlaylist: 'Remove Playlist',
  Option.addToFavourites: 'Add to Favourites',
  Option.removeFromFavourites: 'Remove from Favourites',
  Option.addAllToFavourites: 'Add all to Favourites',
  Option.info: 'Song info',
};

const List<Option> songOptions = [
  Option.playNext,
  Option.addToFavourites,
  Option.addToPlaylist,
  Option.info,
];

const List<Option> albumOptions = [
  Option.addAllToPlaylist,
  Option.addAllToFavourites,
];

const List<Option> artistOptions = [
  Option.addAllToPlaylist,
  Option.addAllToFavourites,
];

const List<Option> playlistOptions = [
  Option.addAllToFavourites,
  Option.removePlaylist,
];

const playlistSongOptions = [
  Option.playNext,
  Option.addToFavourites,
  Option.removeFromPlaylist,
  Option.info,
];

const List<Option> favSongOptions = [
  Option.playNext,
  Option.addToPlaylist,
  Option.info,
  Option.removeFromFavourites,
];

const sortSongsByText = <SongSortType, String>{
  SongSortType.ALBUM: 'Album',
  SongSortType.ARTIST: 'Artist',
  SongSortType.DATE_ADDED: 'Date added',
  SongSortType.DISPLAY_NAME: 'Display name',
  SongSortType.DURATION: 'Duration',
  SongSortType.SIZE: 'Size',
  SongSortType.TITLE: 'Title',
};

const sortAlbumsByText = <AlbumSortType, String>{
  AlbumSortType.ALBUM: 'Album',
  AlbumSortType.ARTIST: 'Artist',
  AlbumSortType.NUM_OF_SONGS: 'Number of songs',
};

const sortArtistsByText = <ArtistSortType, String>{
  ArtistSortType.ARTIST: 'Artist',
  ArtistSortType.NUM_OF_TRACKS: 'Number of songs',
  ArtistSortType.NUM_OF_ALBUMS: 'Number of albums',
};

const orderByText = <OrderType, String>{
  OrderType.ASC_OR_SMALLER: 'Ascending',
  OrderType.DESC_OR_GREATER: 'Descending',
};
