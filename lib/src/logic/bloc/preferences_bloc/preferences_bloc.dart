import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:music/src/global/constants/enums.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../data/services/preferences_services.dart';
import 'bloc.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final PreferencesServices _preferencesServices = PreferencesServices();

  PreferencesBloc({required PreferencesState initialState})
      : super(initialState) {
    on<ChangeSongSortType>(_onChangeSongSortType);
    on<ChangeSortingOrderType>(_onChangeSortingOrderType);
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
      sortType: _sortType,
      orderType: state.orderType,
      view: state.view,
      gridSize: state.gridSize,
    );

    emitter.call(_preferencesState);

    await _preferencesServices.setSongSortType(_sortType);
  }

  Future<void> _onChangeSortingOrderType(
    ChangeSortingOrderType event,
    Emitter<PreferencesState> emitter,
  ) async {
    OrderType _orderType = event.orderType;

    PreferencesState _preferencesState = PreferencesState(
      sortType: state.sortType,
      orderType: _orderType,
      view: state.view,
      gridSize: state.gridSize,
    );

    emitter.call(_preferencesState);

    await _preferencesServices.setOrderType(_orderType);
  }

  Future<void> _onSetListView(
    SetListView event,
    Emitter<PreferencesState> emitter,
  ) async {
    PreferencesState _preferencesState = PreferencesState(
      sortType: state.sortType,
      orderType: state.orderType,
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
      sortType: state.sortType,
      orderType: state.orderType,
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
      sortType: state.sortType,
      orderType: state.orderType,
      view: View.grid,
      gridSize: _size,
    );

    emitter.call(_preferencesState);

    await _preferencesServices.setGridSize(_size);
  }
}
