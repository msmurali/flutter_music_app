import 'dart:typed_data';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/favourites_bloc/bloc.dart';
import '../utils/custom_icons.dart';
import '../widgets/circular_artwork.dart';
import '../widgets/circular_icon_button.dart';
import '../../logic/bloc/player_bloc/bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../global/constants/enums.dart';
import '../../logic/bloc/playback_mode_bloc/bloc.dart';
import '../../logic/player.dart';
import '../widgets/toast.dart';

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
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Image.asset(
                      'asset/images/placeholder.jpg',
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                    );
                  },
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
              SongModel _song = state.queue[state.nowPlaying];

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
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
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
        const ProgressBar(),
        const Controls(),
        _buildBottomPanel(),
      ],
    );
  }
}

class ProgressBar extends StatefulWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  void initState() {
    super.initState();
    _setAudioUrl();
  }

  void _setAudioUrl() {
    PlayerBloc _playerBloc = BlocProvider.of<PlayerBloc>(context);
    List<SongModel> queue = _playerBloc.state.queue;
    int index = _playerBloc.state.nowPlaying;
    String _url = queue[index].data;
    _audioPlayer.setUrl(_url, isLocal: true);
  }

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
    return StreamBuilder<Duration>(
      stream: _audioPlayer.onDurationChanged,
      builder: (context, totalDurationSnapshot) {
        return StreamBuilder<Duration>(
          stream: _audioPlayer.onAudioPositionChanged,
          builder: (context, currentDurationSnapshot) {
            return Column(
              children: [
                Slider(
                  value: currentDurationSnapshot.data == null
                      ? 0.0
                      : (currentDurationSnapshot.data!.inMicroseconds /
                              totalDurationSnapshot.data!.inMicroseconds)
                          .clamp(0.0, 1.0),
                  onChanged: (val) {
                    Duration duration = Duration(
                      microseconds:
                          (val * totalDurationSnapshot.data!.inMicroseconds)
                              .toInt(),
                    );
                    _player.seek(duration);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDuration(currentDurationSnapshot.data),
                      ),
                      Text(
                        formatDuration(totalDurationSnapshot.data),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
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

class FavouritesButton extends StatefulWidget {
  const FavouritesButton({
    Key? key,
  }) : super(key: key);

  @override
  State<FavouritesButton> createState() => _FavouritesButtonState();
}

class _FavouritesButtonState extends State<FavouritesButton> {
  late FToast _fToast;

  @override
  void initState() {
    super.initState();
    _fToast = FToast().init(context);
  }

  void _toastHandler(BuildContext context, FavouritesState state) {
    if (state.action == Action.add && state.status == Status.succeed) {
      _fToast.showToast(
        child: const ToastWidget(
          text: 'Added to favourites',
        ),
        fadeDuration: 50,
        toastDuration: const Duration(milliseconds: 500),
      );
    } else {
      _fToast.showToast(
        child: const ToastWidget(
          text: 'Removed from favourites',
        ),
        fadeDuration: 50,
        toastDuration: const Duration(milliseconds: 500),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerBlocState>(
      builder: (BuildContext context, PlayerBlocState playerState) {
        int index = playerState.nowPlaying;
        SongModel song = playerState.queue[index];

        return BlocConsumer<FavouritesBloc, FavouritesState>(
          listener: _toastHandler,
          builder: (BuildContext context, FavouritesState favState) {
            List<int> favIds = favState.songs.map((song) => song.id).toList();

            if (favIds.contains(song.id)) {
              return IconButton(
                onPressed: () {
                  BlocProvider.of<FavouritesBloc>(context).add(
                    MarkAsNotFavourite(song: song),
                  );
                },
                icon: const Icon(CustomIcons.heart),
              );
            } else {
              return IconButton(
                onPressed: () {
                  BlocProvider.of<FavouritesBloc>(context).add(
                    MarkAsFavourite(song: song),
                  );
                },
                icon: const Icon(CustomIcons.heart_outline),
              );
            }
          },
        );
      },
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
          onPressed: () {
            PlaybackModeBloc _playbackModeBloc =
                BlocProvider.of<PlaybackModeBloc>(context);
            if (state.playbackMode == PlaybackMode.order) {
              _playbackModeBloc.add(
                const PlaybackModeEvent(
                  playbackMode: PlaybackMode.shuffle,
                ),
              );
            } else if (state.playbackMode == PlaybackMode.shuffle) {
              _playbackModeBloc.add(
                const PlaybackModeEvent(
                  playbackMode: PlaybackMode.repeat,
                ),
              );
            } else {
              _playbackModeBloc.add(
                const PlaybackModeEvent(
                  playbackMode: PlaybackMode.order,
                ),
              );
            }
          },
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

  void _handlePress(BuildContext context) {
    PlayerBloc _playerBloc = BlocProvider.of<PlayerBloc>(context);
    PlaybackModeBloc _playbackModeBloc =
        BlocProvider.of<PlaybackModeBloc>(context);
    if (_playbackModeBloc.state.playbackMode == PlaybackMode.shuffle) {
      _playerBloc.add(PlayRandomSong(
        context: context,
      ));
    } else {
      _playerBloc.add(PlayNextSong(
        context: context,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerBlocState>(
      builder: (context, state) {
        return CircularIconButton(
          backgroundColor: Colors.black12,
          child: const Icon(CustomIcons.next),
          radius: 25.0,
          iconSize: 18.0,
          onPressed: () => _handlePress(context),
        );
      },
    );
  }
}

class PlayPreviousButton extends StatelessWidget {
  const PlayPreviousButton({
    Key? key,
  }) : super(key: key);

  void _handlePress(BuildContext context) {
    PlayerBloc _playerBloc = BlocProvider.of<PlayerBloc>(context);
    PlaybackModeBloc _playbackModeBloc =
        BlocProvider.of<PlaybackModeBloc>(context);
    if (_playbackModeBloc.state.playbackMode == PlaybackMode.shuffle) {
      _playerBloc.add(
        PlayRandomSong(
          context: context,
        ),
      );
    } else {
      _playerBloc.add(
        PlayPreviousSong(
          context: context,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerBlocState>(
      builder: (context, state) {
        return CircularIconButton(
          backgroundColor: Colors.black12,
          child: const Icon(CustomIcons.previous),
          radius: 25.0,
          iconSize: 18.0,
          onPressed: () => _handlePress(context),
        );
      },
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    Key? key,
  }) : super(key: key);

  void _handlePress(BuildContext context, PlayerBlocState state) async {
    SongModel _song = state.queue[state.nowPlaying];
    await _player.playLocalFile(_song, context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerBlocState>(
      builder: (context, state) {
        return StreamBuilder<PlayerState>(
          stream: _audioPlayer.onPlayerStateChanged,
          builder: (context, snapshot) {
            _audioPlayer.onPlayerCompletion.listen((event) {
              PlaybackMode _playbackMode =
                  BlocProvider.of<PlaybackModeBloc>(context).state.playbackMode;
              PlayerBloc _playerBloc = BlocProvider.of<PlayerBloc>(context);
              if (_playbackMode == PlaybackMode.order) {
                _playerBloc.add(
                  PlayNextSong(
                    context: context,
                  ),
                );
              } else if (_playbackMode == PlaybackMode.shuffle) {
                _playerBloc.add(
                  PlayRandomSong(
                    context: context,
                  ),
                );
              } else {
                _playerBloc.add(
                  PlaySongAgain(
                    context: context,
                  ),
                );
              }
            });

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
                onPressed: () => _handlePress(context, state),
              );
            }
          },
        );
      },
    );
  }
}
