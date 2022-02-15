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
  playlists,
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

enum Status {
  succeed,
  failed,
  none,
}

enum Action {
  add,
  remove,
  rename,
  none,
}
