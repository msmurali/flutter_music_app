import 'package:bloc/bloc.dart';
import '../../../data/providers/favourites_provider.dart';
import '../../../data/services/favourites_services.dart';
import 'bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouritesBloc extends Bloc<FavouritesEvents, FavouritesState> {
  final FavouritesServices _favouritesServices = FavouritesServices();
  final FavouritesProvider _favouritesProvider = FavouritesProvider();

  FavouritesBloc({required FavouritesState initialState})
      : super(initialState) {
    on<AddSongToFavouritesEvent>(_onAddSongFromFavourites);
    on<RemoveSongToFavouritesEvent>(_onRemoveSongFromFavourites);
  }

  _onAddSongFromFavourites(
    AddSongToFavouritesEvent event,
    Emitter<FavouritesState> emitter,
  ) async {
    SongModel _song = event.song;

    await _favouritesServices.addToFavourites(_song.id);

    List<SongModel> _favourites =
        await _favouritesProvider.getFavouritesSongs();

    FavouritesState _favState = FavouritesState(
      songs: _favourites,
    );

    emitter.call(_favState);
  }

  _onRemoveSongFromFavourites(
    RemoveSongToFavouritesEvent event,
    Emitter<FavouritesState> emitter,
  ) async {
    SongModel _song = event.song;

    await _favouritesServices.rmFromFavourites(_song.id);

    List<SongModel> _favourites =
        await _favouritesProvider.getFavouritesSongs();

    FavouritesState _favState = FavouritesState(
      songs: _favourites,
    );

    emitter.call(_favState);
  }
}
