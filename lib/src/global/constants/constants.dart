import 'enums.dart';

const routes = <Routes, String>{
  Routes.homeRoute: '/',
  Routes.preferencesRoute: '/preferences',
  Routes.songsRoute: '/songs',
};

const recentsListSize = 20;

const gridSizes = [2, 3, 4, 5];

const keys = <StorageKey, String>{
  StorageKey.favourites: 'com.mk.music-favourites',
  StorageKey.recents: 'com.mk.music-recents',
  StorageKey.queue: 'com.mk.music-queue',
  StorageKey.queueIndex: 'com.mk.music-queue-index',
  StorageKey.playback: 'com.mk.music-playback-mode',
  StorageKey.theme: 'com.mk.music-theme',
  StorageKey.sortType: 'com.mk.music-sort-type',
  StorageKey.orderType: 'com.mk.music-order-type',
  StorageKey.view: 'com.mk.music-view',
  StorageKey.gridSize: 'com.mk.music-grid-size'
};

const optionsText = <Option, String>{
  Option.select: 'Select',
  Option.playNext: 'Play next',
  Option.addToPlaylist: 'Add to playlist',
  Option.addToFavourites: 'Add to favourites',
  Option.removeFromFavourites: 'Remove from favourites',
  Option.addAllToFavourites: 'Add all to favourites',
  Option.info: 'Song info',
  Option.addAllToPlaylists: 'Add all to playlists',
};
