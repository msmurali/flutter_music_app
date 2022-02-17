import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/playlist_services.dart';
import '../../global/constants/enums.dart';
import '../../logic/bloc/playlists_bloc/bloc.dart';
import '../utils/helpers.dart';

class PlaylistCreationForm extends StatelessWidget {
  final String _formTitle = 'Create Playlist';
  final TextEditingController _textEditingController = TextEditingController();
  final PlaylistServices _playlistsServices = PlaylistServices();

  PlaylistCreationForm({Key? key}) : super(key: key);

  Widget _buildForm(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: BlocListener<PlaylistsBloc, PlaylistsState>(
        listener: (BuildContext context, PlaylistsState state) {
          if (state.action == Action.add && state.status == Status.succeed) {
            showToastMsg(
              context: context,
              text: 'Playlist created',
            );
          } else if (state.action == Action.add &&
              state.status == Status.failed) {
            showToastMsg(
              context: context,
              text: 'Something went wrong',
            );
          }
        },
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              FormTextField(
                textEditingController: _textEditingController,
              ),
              const SizedBox(height: 32.0),
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
                        showToastMsg(
                          context: context,
                          text: 'Playlist name should not be empty',
                        );
                      } else if (_playlistsServices
                          .playlistAlreadyExists(_name)) {
                        showToastMsg(
                          context: context,
                          text: 'Playlist already exists',
                        );
                      } else {
                        BlocProvider.of<PlaylistsBloc>(context).add(
                          CreatePlaylist(
                            playlistName: _name,
                          ),
                        );
                        Navigator.pop(context);
                      }
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
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: Text(
        _formTitle,
        style: theme.textTheme.headline6,
      ),
      alignment: Alignment.center,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      children: [
        SizedBox(
          child: _buildForm(context),
          width: MediaQuery.of(context).size.width,
        ),
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
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(
            color: theme.colorScheme.secondary.withOpacity(0.05),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(
            color: theme.colorScheme.onSurface,
            width: 1,
          ),
        ),
        isDense: true,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: theme.colorScheme.secondary.withOpacity(0.05),
      ),
      controller: textEditingController,
    );
  }
}

class PlaylistRenameForm extends StatelessWidget {
  final String playlistName;
  final String _formTitle = 'Rename Playlist';
  final PlaylistServices _playlistsServices = PlaylistServices();

  PlaylistRenameForm({
    Key? key,
    required this.playlistName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController(
      text: playlistName,
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
                        showToastMsg(
                          context: context,
                          text: 'Playlist name should not be empty',
                        );
                        return;
                      } else if (_newName != playlistName &&
                          _playlistsServices.playlistAlreadyExists(_newName)) {
                        showToastMsg(
                          context: context,
                          text: 'Playlist already exists',
                        );
                        return;
                      } else if (_newName == playlistName) {
                        showToastMsg(
                          context: context,
                          text: 'Playlist renamed successfully',
                        );
                        Navigator.pop(context);
                      } else {
                        PlaylistsBloc _bloc =
                            BlocProvider.of<PlaylistsBloc>(context);
                        _bloc.add(
                          RenamePlaylist(
                            oldName: playlistName,
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
