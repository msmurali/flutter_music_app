import 'package:bloc/bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../data/services/preferences_services.dart';
import 'bloc.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final PreferencesServices _preferencesServices = PreferencesServices();

  PreferencesBloc(PreferencesState initialState) : super(initialState) {
    on<ChangeSongSortType>(_onChangeSongSortType);
    on<ChangeSortingOrderType>(_onChangeSortingOrderType);
  }

  _onChangeSongSortType(
    ChangeSongSortType event,
    Emitter<PreferencesState> emitter,
  ) async {
    SongSortType _sortType = event.sortType;

    PreferencesState _preferencesState = PreferencesState(
      sortType: _sortType,
      orderType: state.orderType,
    );

    emitter.call(_preferencesState);

    await _preferencesServices.setSongSortType(_sortType);
  }

  _onChangeSortingOrderType(
    ChangeSortingOrderType event,
    Emitter<PreferencesState> emitter,
  ) async {
    OrderType _orderType = event.orderType;

    PreferencesState _preferencesState = PreferencesState(
      sortType: state.sortType,
      orderType: _orderType,
    );

    emitter.call(_preferencesState);

    // await _preferencesServices.setSongSortType();
  }
}
