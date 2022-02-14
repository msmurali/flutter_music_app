import 'package:bloc/bloc.dart';
import '../../../data/providers/recents_provider.dart';
import '../../../data/services/recents_services.dart';
import 'bloc.dart';

class RecentsBloc extends Bloc<RecentsEvents, RecentsState> {
  final RecentsServices _recentsServices = RecentsServices();
  final RecentsProvider _recentsProvider = RecentsProvider();

  RecentsBloc({required RecentsState initialState}) : super(initialState) {
    on<AddSongEventToRecents>(_onAddSongEvent);
  }

  _onAddSongEvent(
    AddSongEventToRecents event,
    Emitter<RecentsState> emitter,
  ) async {
    print('recents song: ${event.song.id}');
    await _recentsServices.addToRecents(event.song);
    RecentsState newState = RecentsState(songs: _recentsProvider.getRecents());
    emitter.call(newState);
  }
}
