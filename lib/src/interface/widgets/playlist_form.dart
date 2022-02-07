import 'package:flutter/material.dart';
import 'package:music/src/interface/widgets/theme_preferences.dart';

import '../../data/services/playlist_services.dart';

class PlaylistForm extends StatefulWidget {
  const PlaylistForm({Key? key}) : super(key: key);

  @override
  State<PlaylistForm> createState() => _PlaylistFormState();
}

class _PlaylistFormState extends State<PlaylistForm> {
  final String _formTitle = 'Create Playlist';
  final TextEditingController _textEditingController = TextEditingController();
  final PlaylistServices _playlistsServices = PlaylistServices();

  Widget _buildForm(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Form(
      child: Column(
        children: [
          TextField(
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
            controller: _textEditingController,
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
              TextButton(
                onPressed: () {
                  // check value is null
                  // check if playlist name already exits
                  // create playlist
                },
                child: const Text(
                  'Create',
                ),
              ),
            ],
          ),
        ],
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
