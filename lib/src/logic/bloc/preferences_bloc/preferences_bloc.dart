import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../global/constants/enums.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../data/services/preferences_services.dart';
import 'bloc.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final PreferencesServices _preferencesServices = PreferencesServices();

  PreferencesBloc({required PreferencesState initialState})
      : super(initialState) {
    on<ChangeSongSortType>(_onChangeSongSortType);
    on<ChangeSongOrderType>(_onChangeSongOrderType);
    on<ChangeAlbumSortType>(_onChangeAlbumSortType);
    on<ChangeAlbumOrderType>(_onChangeAlbumOrderType);
    on<ChangeArtistSortType>(_onChangeArtistSortType);
    on<ChangeArtistOrderType>(_onChangeArtistOrderType);
    on<SetListView>(_onSetListView);
    on<SetGridView>(_onSetGridView);
    on<ChangeGridSize>(_onChangeGridSize);
  }

  Future<void> _onChangeSongSortType(
    ChangeSongSortType event,
    Emitter<PreferencesState> emitter,
  ) async {
    SongSortType _sortType = event.sortType;

    PreferencesState _preferencesState = PreferencesState(
      songsSortType: _sortType,
      songsOrderType: state.songsOrderType,
      albumsOrderType: state.albumsOrderType,
      albumsSortType: state.albumsSortType,
      artistsSortType: state.artistsSortType,
      artistsOrderType: state.artistsOrderType,
      view: state.view,
      gridSize: state.gridSize,
    );

    emitter.call(_preferencesState);

    await _preferencesServices.setSongSortType(_sortType);
  }

  Future<void> _onChangeSongOrderType(
    ChangeSongOrderType event,
    Emitter<PreferencesState> emitter,
  ) async {
    OrderType _orderType = event.orderType;

    PreferencesState _preferencesState = PreferencesState(
      songsSortType: state.songsSortType,
      songsOrderType: _orderType,
      albumsOrderType: state.albumsOrderType,
      albumsSortType: state.albumsSortType,
      artistsSortType: state.artistsSortType,
      artistsOrderType: state.artistsOrderType,
      view: state.view,
      gridSize: state.gridSize,
    );

    emitter.call(_preferencesState);

    await _preferencesServices.setSongOrderType(_orderType);
  }

  Future<void> _onSetListView(
    SetListView event,
    Emitter<PreferencesState> emitter,
  ) async {
    PreferencesState _preferencesState = PreferencesState(
      songsSortType: state.songsSortType,
      songsOrderType: state.songsOrderType,
      albumsOrderType: state.albumsOrderType,
      albumsSortType: state.albumsSortType,
      artistsSortType: state.artistsSortType,
      artistsOrderType: state.artistsOrderType,
      view: View.list,
      gridSize: state.gridSize,
    );

    emitter.call(_preferencesState);

    await _preferencesServices.setView(View.list);
  }

  Future<void> _onSetGridView(
    SetGridView event,
    Emitter<PreferencesState> emitter,
  ) async {
    PreferencesState _preferencesState = PreferencesState(
      songsSortType: state.songsSortType,
      songsOrderType: state.songsOrderType,
      albumsOrderType: state.albumsOrderType,
      albumsSortType: state.albumsSortType,
      artistsSortType: state.artistsSortType,
      artistsOrderType: state.artistsOrderType,
      view: View.grid,
      gridSize: state.gridSize,
    );

    emitter.call(_preferencesState);

    await _preferencesServices.setView(View.grid);
  }

  Future<void> _onChangeGridSize(
      ChangeGridSize event, Emitter<PreferencesState> emitter) async {
    int _size = event.size;

    PreferencesState _preferencesState = PreferencesState(
      songsSortType: state.songsSortType,
      songsOrderType: state.songsOrderType,
      albumsOrderType: state.albumsOrderType,
      albumsSortType: state.albumsSortType,
      artistsSortType: state.artistsSortType,
      artistsOrderType: state.artistsOrderType,
      view: View.grid,
      gridSize: _size,
    );

    emitter.call(_preferencesState);

    await _preferencesServices.setGridSize(_size);
  }

  _onChangeAlbumSortType(
    ChangeAlbumSortType event,
    Emitter<PreferencesState> emitter,
  ) async {
    AlbumSortType _sortType = event.sortType;

    PreferencesState _preferencesState = PreferencesState(
      songsSortType: state.songsSortType,
      songsOrderType: state.songsOrderType,
      albumsOrderType: state.albumsOrderType,
      albumsSortType: _sortType,
      artistsSortType: state.artistsSortType,
      artistsOrderType: state.artistsOrderType,
      view: state.view,
      gridSize: state.gridSize,
    );

    emitter.call(_preferencesState);
  }

  _onChangeAlbumOrderType(
    ChangeAlbumOrderType event,
    Emitter<PreferencesState> emitter,
  ) async {
    OrderType _orderType = event.orderType;

    PreferencesState _preferencesState = PreferencesState(
      songsSortType: state.songsSortType,
      songsOrderType: state.songsOrderType,
      albumsOrderType: _orderType,
      albumsSortType: state.albumsSortType,
      artistsSortType: state.artistsSortType,
      artistsOrderType: state.artistsOrderType,
      view: state.view,
      gridSize: state.gridSize,
    );

    emitter.call(_preferencesState);
  }

  _onChangeArtistSortType(
      ChangeArtistSortType event, Emitter<PreferencesState> emitter) async {
    ArtistSortType _sortType = event.sortType;

    PreferencesState _preferencesState = PreferencesState(
      songsSortType: state.songsSortType,
      songsOrderType: state.songsOrderType,
      albumsOrderType: state.albumsOrderType,
      albumsSortType: state.albumsSortType,
      artistsSortType: _sortType,
      artistsOrderType: state.artistsOrderType,
      view: state.view,
      gridSize: state.gridSize,
    );

    emitter.call(_preferencesState);
  }

  _onChangeArtistOrderType(
      ChangeArtistOrderType event, Emitter<PreferencesState> emitter) {
    OrderType _orderType = event.orderType;

    PreferencesState _preferencesState = PreferencesState(
      songsSortType: state.songsSortType,
      songsOrderType: state.songsOrderType,
      albumsOrderType: state.albumsOrderType,
      albumsSortType: state.albumsSortType,
      artistsSortType: state.artistsSortType,
      artistsOrderType: _orderType,
      view: state.view,
      gridSize: state.gridSize,
    );

    emitter.call(_preferencesState);
  }
}
