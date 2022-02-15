import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music/src/interface/widgets/toast.dart';

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
    );
  }

  Widget _buildForm(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Form(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
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
                    await _playlistsServices.createPlaylist(_name);
                    _showToastMsg('Playlist created');
                    setState(() {});
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
