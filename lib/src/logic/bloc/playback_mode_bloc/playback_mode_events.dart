import '../../../global/constants/enums.dart';

class PlaybackModeEvent {
  final PlaybackMode playbackMode;
  const PlaybackModeEvent({required this.playbackMode});
}

class SetOrderPlaybackMode {
  const SetOrderPlaybackMode();
}

class SetShufflePlaybackMode {
  const SetShufflePlaybackMode();
}

class SetLoopPlaybackMode {
  const SetLoopPlaybackMode();
}
