import 'package:flutter/material.dart';
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
};
