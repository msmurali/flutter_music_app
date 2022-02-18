import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../global/constants/enums.dart';
import '../../logic/bloc/playback_mode_bloc/bloc.dart';
import '../../logic/bloc/player_bloc/bloc.dart';
import '../../logic/player.dart';
import '../utils/custom_icons.dart';
import 'circular_icon_button.dart';
import 'circular_progress_bar.dart';

final Player _player = Player.instance;
final AudioPlayer _audioPlayer = _player.audioPlayer;

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88.0,
      child: Container(
        margin: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
        ),
        child: Stack(
          children: const [
            Background(),
            Foreground(),
          ],
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4.0,
          sigmaY: 4.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.1,
              color: Colors.white.withOpacity(0.4),
            ),
            borderRadius: BorderRadius.circular(8.0),
            gradient: const LinearGradient(
              colors: [
                Color(0x3F3A3A3A),
                Color(0x18333333),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }
}

class Foreground extends StatelessWidget {
  const Foreground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
      ),
      child: Row(
        children: const [
          MiniPlayerArtwork(),
          MiniPlayerInfoColumn(),
          MiniPlayerControls(),
        ],
      ),
    );
  }
}

class MiniPlayerArtwork extends StatelessWidget {
  const MiniPlayerArtwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28.0),
      child: SizedBox(
        width: 56.0,
        height: 56.0,
        child: BlocBuilder<PlayerBloc, PlayerBlocState>(
          builder: (BuildContext context, PlayerBlocState state) {
            if (state.artworkData != null) {
              return SizedBox.expand(
                child: Image.memory(
                  state.artworkData!,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                ),
              );
            } else {
              return SizedBox.expand(
                child: Image.asset(
                  'asset/images/placeholder.jpg',
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class MiniPlayerInfoColumn extends StatelessWidget {
  const MiniPlayerInfoColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
        child: BlocBuilder<PlayerBloc, PlayerBlocState>(
          builder: (context, state) {
            SongModel _song = state.queue[state.nowPlaying];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _song.title,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.white,
                      ),
                ),
                Text(
                  _song.artist ?? 'Unknown',
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class MiniPlayerControls extends StatelessWidget {
  const MiniPlayerControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        MiniPlayerPreviousButton(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.0),
          child: MiniPlayerPlayButton(),
        ),
        MiniPlayerNextButton(),
      ],
    );
  }
}

class MiniPlayerPreviousButton extends StatelessWidget {
  const MiniPlayerPreviousButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularIconButton(
      child: const Icon(CustomIcons.previous),
      onPressed: () {
        PlayerBloc _playerBloc = BlocProvider.of<PlayerBloc>(context);
        PlaybackModeBloc _playbackModeBloc =
            BlocProvider.of<PlaybackModeBloc>(context);
        if (_playbackModeBloc.state.playbackMode == PlaybackMode.shuffle) {
          _playerBloc.add(PlayRandomSong(context: context));
        } else {
          _playerBloc.add(PlayPreviousSong(context: context));
        }
      },
      iconSize: 10.0,
      radius: 16.0,
      color: Colors.white,
    );
  }
}

class MiniPlayerPlayButton extends StatelessWidget {
  const MiniPlayerPlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerBlocState>(
      builder: (context, state) {
        return StreamBuilder<PlayerState>(
            stream: _audioPlayer.onPlayerStateChanged,
            builder: (context, playerStateSnapshot) {
              return GestureDetector(
                onTap: () async {
                  if (playerStateSnapshot.data == PlayerState.PLAYING) {
                    _audioPlayer.pause();
                  } else {
                    SongModel _song = state.queue[state.nowPlaying];
                    await _player.playLocalFile(_song, context);
                  }
                },
                child: StreamBuilder<Duration>(
                  stream: _audioPlayer.onDurationChanged,
                  builder: (context, totalDurationSnapshot) {
                    return StreamBuilder<Duration>(
                      stream: _audioPlayer.onAudioPositionChanged,
                      builder: (context, currentDurationSnapshot) {
                        return CircularProgressBar(
                          activeColor: Colors.white,
                          inActiveColor: Colors.grey,
                          radius: 20.0,
                          trackWidth: 2.5,
                          progress: currentDurationSnapshot.data == null
                              ? 0.0
                              : currentDurationSnapshot.data!.inMicroseconds /
                                  totalDurationSnapshot.data!.inMicroseconds,
                          child: playerStateSnapshot.data == PlayerState.PLAYING
                              ? const Icon(
                                  CustomIcons.pause,
                                  color: Colors.white,
                                  size: 15.0,
                                )
                              : const Align(
                                  alignment: Alignment(0.15, 0.0),
                                  child: Icon(
                                    CustomIcons.play,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                ),
                        );
                      },
                    );
                  },
                ),
              );
            });
      },
    );
  }
}

class MiniPlayerNextButton extends StatelessWidget {
  const MiniPlayerNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularIconButton(
      color: Colors.white,
      child: const Icon(CustomIcons.next),
      onPressed: () {
        PlayerBloc _playerBloc = BlocProvider.of<PlayerBloc>(context);
        PlaybackModeBloc _playbackModeBloc =
            BlocProvider.of<PlaybackModeBloc>(context);
        if (_playbackModeBloc.state.playbackMode == PlaybackMode.shuffle) {
          _playerBloc.add(PlayRandomSong(context: context));
        } else {
          _playerBloc.add(PlayNextSong(context: context));
        }
      },
      iconSize: 10.0,
      radius: 16.0,
    );
  }
}
