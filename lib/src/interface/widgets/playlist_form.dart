import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music/src/interface/widgets/toast.dart';

import '../../data/services/playlist_services.dart';
import '../../global/constants/enums.dart';
import '../../logic/bloc/playlists_bloc/bloc.dart';

class PlaylistCreationForm extends StatefulWidget {
  const PlaylistCreationForm({Key? key}) : super(key: key);

  @override
  State<PlaylistCreationForm> createState() => _PlaylistCreationFormState();
}

class _PlaylistCreationFormState extends State<PlaylistCreationForm> {
  final String _formTitle = 'Create Playlist';
  final TextEditingController _textEditingController = TextEditingController();
  final PlaylistServices _playlistsServices = PlaylistServices();
  late FToast _fToast;

  @override
  void initState() {
    super.initState();
    _fToast = FToast().init(context);
  }

  void _showToastMsg(String msg) {
    _fToast.showToast(
      child: ToastWidget(text: msg),
      gravity: ToastGravity.BOTTOM,
      fadeDuration: 50,
      toastDuration: const Duration(milliseconds: 500),
    );
  }

  Widget _buildForm(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: BlocListener<PlaylistsBloc, PlaylistsState>(
        listener: (BuildContext context, PlaylistsState state) {
          if (state.action == Action.add && state.status == Status.succeed) {
            _showToastMsg('Playlist created');
          } else if (state.action == Action.add &&
              state.status == Status.failed) {
            _showToastMsg('Something went wrong');
          }
        },
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              FormTextField(
                textEditingController: _textEditingController,
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Discard',
                    ),
                    style: theme.textButtonTheme.style,
                  ),
                  const SizedBox(width: 20.0),
                  TextButton(
                    onPressed: () async {
                      String _name = _textEditingController.text.trim();
                      if (_name.isEmpty) {
                        _showToastMsg('Playlist name should not be empty');
                        return;
                      }
                      if (_playlistsServices.playlistAlreadyExists(_name)) {
                        _showToastMsg('Playlist already exists');
                        return;
                      }
                      BlocProvider.of<PlaylistsBloc>(context).add(
                        CreatePlaylist(
                          playlistName: _name,
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Create',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SimpleDialog(
      title: Text(
        _formTitle,
        style: theme.textTheme.headline6,
      ),
      alignment: Alignment.center,
      contentPadding: const EdgeInsets.all(16.0),
      children: [
        _buildForm(context),
      ],
    );
  }
}

class FormTextField extends StatelessWidget {
  const FormTextField({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return TextField(
      cursorColor: theme.colorScheme.onSurface,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.05),
            width: 1.4,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.colorScheme.onSurface,
            width: 1.4,
          ),
        ),
        isDense: true,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
      ),
      controller: textEditingController,
    );
  }
}

class PlaylistRenameForm extends StatefulWidget {
  final String playlistName;

  const PlaylistRenameForm({
    Key? key,
    required this.playlistName,
  }) : super(key: key);

  @override
  State<PlaylistRenameForm> createState() => _PlaylistRenameFormState();
}

class _PlaylistRenameFormState extends State<PlaylistRenameForm> {
  final String _formTitle = 'Rename Playlist';
  final PlaylistServices _playlistsServices = PlaylistServices();
  late FToast _fToast;

  @override
  void initState() {
    super.initState();
    _fToast = FToast().init(context);
  }

  void _showToastMsg(String msg) {
    _fToast.showToast(
      child: ToastWidget(text: msg),
      gravity: ToastGravity.BOTTOM,
      fadeDuration: 50,
      toastDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController(
      text: widget.playlistName,
    );
    ThemeData theme = Theme.of(context);

    return SimpleDialog(
      title: Text(
        _formTitle,
        style: theme.textTheme.headline6,
      ),
      alignment: Alignment.center,
      contentPadding: const EdgeInsets.all(16.0),
      children: [
        Form(
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              FormTextField(
                textEditingController: _textEditingController,
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Discard',
                    ),
                    style: theme.textButtonTheme.style,
                  ),
                  const SizedBox(width: 20.0),
                  TextButton(
                    onPressed: () async {
                      String _newName = _textEditingController.text.trim();
                      if (_newName.isEmpty) {
                        _showToastMsg('Playlist name should not be empty');
                        return;
                      } else if (_playlistsServices
                          .playlistAlreadyExists(_newName)) {
                        _showToastMsg('Playlist already exists');
                        return;
                      } else if (_newName == widget.playlistName) {
                        _showToastMsg('Playlist renamed successfully');
                        Navigator.pop(context);
                      } else {
                        PlaylistsBloc _bloc =
                            BlocProvider.of<PlaylistsBloc>(context);
                        _bloc.add(
                          RenamePlaylist(
                            oldName: widget.playlistName,
                            newName: _newName,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Rename',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
