import 'package:music/src/global/constants/enums.dart';

const routes = <Routes, String>{
  Routes.homeRoute: '/',
  Routes.preferencesRoute: '/preferences',
  Routes.songsRoute: '/songs',
};

const recentsListSize = 20;

const gridSizes = [2, 3, 4, 5];

const keys = <PreferencesKey, String>{
  PreferencesKey.favourites: 'com.mk.music-favourites',
  PreferencesKey.recents: 'com.mk.music-recents',
  PreferencesKey.queue: 'com.mk.music-queue',
  PreferencesKey.queueIndex: 'com.mk.music-queue-index',
  PreferencesKey.playback: 'com.mk.music-playback-mode',
  PreferencesKey.theme: 'com.mk.music-theme',
  PreferencesKey.sortType: 'com.mk.music-sort-type',
  PreferencesKey.view: 'com.mk.music-view',
};
