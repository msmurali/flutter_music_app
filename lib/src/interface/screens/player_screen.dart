import 'dart:typed_data';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/custom_icons.dart';
import '../widgets/circular_artwork.dart';
import '../widgets/circular_icon_button.dart';
import '../../logic/bloc/player_bloc/bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../global/constants/enums.dart';
import '../../logic/bloc/playback_mode_bloc/bloc.dart';
import '../../logic/bloc/queue_bloc/bloc.dart';
import '../../logic/bloc/queue_index_bloc/bloc.dart';
import '../../logic/player.dart';

final Player _player = Player.instance;
final AudioPlayer _audioPlayer = _player.audioPlayer;

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: const [
          Background(),
          Foreground(),
        ],
      ),
      height: MediaQuery.of(context).size.height,
    );
  }
}

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<PlayerBloc, PlayerBlocState>(
          builder: (BuildContext context, PlayerBlocState state) {
            if (state.artworkData == null) {
              return SizedBox.expand(
                child: Image.asset(
                  'asset/images/placeholder.jpg',
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                ),
              );
            } else {
              return SizedBox.expand(
                child: Image.memory(
                  state.artworkData!,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                ),
              );
            }
          },
        ),
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 8.0,
              sigmaY: 8.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.01),
                    Colors.white.withOpacity(0.02),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ),
        SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [
                  0.1,
                  1.0,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Foreground extends StatelessWidget {
  const Foreground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 32.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<PlayerBloc, PlayerBlocState>(
            builder: (context, state) {
              Uint8List? _artworkData = state.artworkData;
              SongModel _song = state.nowPlaying;

              return Column(
                children: [
                  Info(song: _song),
                  const SizedBox(height: 20.0),
                  CircularArtwork(
                    radius: 150,
                    imageData: _artworkData,
                  ),
                ],
              );
            },
          ),
          const PlayerControlPanel(),
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  final SongModel song;
  const Info({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10.0),
        Text(
          song.title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6.0),
        Text(
          song.artist ?? 'Unknown Artist',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}

class PlayerControlPanel extends StatelessWidget {
  const PlayerControlPanel({Key? key}) : super(key: key);

  _buildBottomPanel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(CustomIcons.add_to_playlist),
          onPressed: () {},
          iconSize: 20.0,
        ),
        IconButton(
          icon: const Icon(CustomIcons.play),
          onPressed: () {},
          iconSize: 20.0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProgressBar(),
        Controls(),
        _buildBottomPanel(),
      ],
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  String formatDuration(Duration? duration) {
    if (duration == null) {
      return '0:00';
    }

    String min = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String sec = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$min:$sec';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: 0.5,
          onChanged: (val) {},
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<Duration>(
                stream: _audioPlayer.onAudioPositionChanged,
                builder: (context, snapshot) {
                  return Text(
                    formatDuration(snapshot.data),
                  );
                },
              ),
              StreamBuilder<Duration>(
                stream: _audioPlayer.onDurationChanged,
                builder: (context, snapshot) {
                  return Text(
                    formatDuration(snapshot.data),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Controls extends StatelessWidget {
  const Controls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 36.0, top: 36.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          PlaybackModeButton(),
          PlayPreviousButton(),
          PlayPauseButton(),
          PlayNextButton(),
          FavouritesButton(),
        ],
      ),
    );
  }
}

class FavouritesButton extends StatelessWidget {
  const FavouritesButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(CustomIcons.heart_outline),
      iconSize: 16,
    );
  }
}

class PlaybackModeButton extends StatelessWidget {
  const PlaybackModeButton({Key? key}) : super(key: key);

  Widget _getPlaybackModeIcon(PlaybackMode playbackMode) {
    if (playbackMode == PlaybackMode.order) {
      return const Icon(CustomIcons.order);
    } else if (playbackMode == PlaybackMode.shuffle) {
      return const Icon(CustomIcons.shuffle);
    } else {
      return const Icon(CustomIcons.loop);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaybackModeBloc, PlaybackModeState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {},
          icon: _getPlaybackModeIcon(state.playbackMode),
          iconSize: 16,
        );
      },
    );
  }
}

class PlayNextButton extends StatelessWidget {
  const PlayNextButton({
    Key? key,
  }) : super(key: key);

  void _onPressed(BuildContext context, QueueIndexState state) {
    QueueIndexBloc _queueIndexBloc = BlocProvider.of<QueueIndexBloc>(context);

    PlayerBloc _playerBloc = BlocProvider.of<PlayerBloc>(context);

    QueueBloc _queueBloc = BlocProvider.of<QueueBloc>(context);

    List<SongModel> _queueSongs = _queueBloc.state.songs;

    _queueIndexBloc.add(
      QueueIndexIncrementEvent(
        currIndex: state.index,
        queueSize: _queueSongs.length,
      ),
    );

    _playerBloc.add(
      ChangeSong(
        song: _queueSongs[_queueIndexBloc.state.index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueueIndexBloc, QueueIndexState>(
      builder: (context, state) {
        return CircularIconButton(
          backgroundColor: Colors.black12,
          child: const Icon(CustomIcons.next),
          radius: 25.0,
          iconSize: 18.0,
          onPressed: () => _onPressed(context, state),
        );
      },
    );
  }
}

class PlayPreviousButton extends StatelessWidget {
  const PlayPreviousButton({
    Key? key,
  }) : super(key: key);

  void _onPressed(BuildContext context, QueueIndexState state) {
    QueueIndexBloc _queueIndexBloc = BlocProvider.of<QueueIndexBloc>(context);

    PlayerBloc _playerBloc = BlocProvider.of<PlayerBloc>(context);

    QueueBloc _queueBloc = BlocProvider.of<QueueBloc>(context);

    List<SongModel> _queueSongs = _queueBloc.state.songs;

    _queueIndexBloc.add(
      QueueIndexDecrementEvent(
          currIndex: state.index, queueSize: _queueSongs.length),
    );

    _playerBloc.add(
      ChangeSong(
        song: _queueSongs[_queueIndexBloc.state.index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueueIndexBloc, QueueIndexState>(
      builder: (context, state) {
        return CircularIconButton(
          backgroundColor: Colors.black12,
          child: const Icon(CustomIcons.previous),
          radius: 25.0,
          iconSize: 18.0,
          onPressed: () => _onPressed(context, state),
        );
      },
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerBlocState>(
      builder: (context, state) {
        return StreamBuilder<PlayerState>(
            stream: _audioPlayer.onPlayerStateChanged,
            builder: (context, snapshot) {
              if (snapshot.data == PlayerState.PLAYING) {
                return CircularIconButton(
                  backgroundColor: Colors.black12,
                  child: const Icon(CustomIcons.pause),
                  radius: 30.0,
                  onPressed: () {
                    _player.pause();
                  },
                );
              } else {
                return CircularIconButton(
                  backgroundColor: Colors.black12,
                  child: const Align(
                    child: Icon(CustomIcons.play),
                    alignment: Alignment(0.7, 0.0),
                  ),
                  radius: 30.0,
                  onPressed: () {
                    String filePath = state.nowPlaying.data;
                    _player.playLocalFile(filePath);
                  },
                );
              }
            });
      },
    );
  }
}
