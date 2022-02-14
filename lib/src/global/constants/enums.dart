enum Routes {
  homeRoute,
  preferencesRoute,
  songsRoute,
  infoRoute,
  favouritesRoute,
  playlistsRoute,
  searchRoute,
}

enum StorageKey {
  favourites,
  recents,
  queue,
  queueIndex,
  playbackMode,
  theme,
  view,
  gridSize,
  songsSortType,
  songsOrderType,
  artistsSortType,
  artistsOrderType,
  albumsSortType,
  albumsOrderType,
  preferences,
}

enum AppTheme {
  light,
  dark,
  system,
}

enum PlaybackMode {
  order,
  shuffle,
  repeat,
}

enum View {
  list,
  grid,
}

enum Option {
  select,
  playNext,
  addToPlaylist,
  removeFromPlaylist,
  addToFavourites,
  removeFromFavourites,
  info,
  addAllToFavourites,
  addAllToPlaylist,
  removePlaylist,
}
