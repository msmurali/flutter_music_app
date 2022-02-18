import 'package:bloc/bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../data/providers/favourites_provider.dart';
import '../../../data/services/favourites_services.dart';
import '../../../global/constants/enums.dart';
import 'bloc.dart';

class FavouritesBloc extends Bloc<FavouritesEvents, FavouritesState> {
  final FavouritesServices _favouritesServices = FavouritesServices();
  final FavouritesProvider _favouritesProvider = FavouritesProvider();

  FavouritesBloc({required FavouritesState initialState})
      : super(initialState) {
    on<MarkAsFavourite>(_onMarkAsFavourites);
    on<MarkAsNotFavourite>(_onMarkAsNotFavourites);
  }

  _onMarkAsFavourites(
    MarkAsFavourite event,
    Emitter<FavouritesState> emitter,
  ) async {
    SongModel _song = event.song;

    bool _result = await _favouritesServices.addToFavourites(_song);

    List<SongModel> _favourites = _favouritesProvider.getFavouritesSongs();

    FavouritesState _favState = FavouritesState(
      songs: _favourites,
      status: _result ? Status.succeed : Status.failed,
      action: Action.add,
    );

    emitter.call(_favState);
  }

  _onMarkAsNotFavourites(
    MarkAsNotFavourite event,
    Emitter<FavouritesState> emitter,
  ) async {
    SongModel _song = event.song;

    bool _result = await _favouritesServices.rmFromFavourites(_song);

    List<SongModel> _favourites = _favouritesProvider.getFavouritesSongs();

    FavouritesState _favState = FavouritesState(
      songs: _favourites,
      status: _result ? Status.succeed : Status.failed,
      action: Action.remove,
    );

    emitter.call(_favState);
  }
}
