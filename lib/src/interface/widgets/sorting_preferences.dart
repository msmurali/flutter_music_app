import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../global/constants/index.dart';
import '../../logic/bloc/preferences_bloc/bloc.dart';

class SortingPreferences extends StatelessWidget {
  const SortingPreferences({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SongsSortingPreferences(),
        AlbumsSortingPreferences(),
        ArtistsSortingPreferences(),
      ],
    );
  }
}

class ArtistsSortingPreferences extends StatelessWidget {
  const ArtistsSortingPreferences({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<PreferencesBloc, PreferencesState>(
          buildWhen: (previous, current) =>
              previous.artistsSortType != current.artistsSortType,
          builder: (context, state) {
            return PreferencesDropDown(
              title: 'Sort artists by',
              value: sortArtistsByText[BlocProvider.of<PreferencesBloc>(context)
                  .state
                  .artistsSortType]!,
              options: ArtistSortType.values,
              optionsText: sortArtistsByText,
              onChanged: (dynamic sortType) {
                BlocProvider.of<PreferencesBloc>(context).add(
                  ChangeArtistSortType(
                    sortType: sortType,
                  ),
                );
              },
            );
          },
        ),
        BlocBuilder<PreferencesBloc, PreferencesState>(
          buildWhen: (previous, current) =>
              previous.artistsOrderType != current.artistsOrderType,
          builder: (context, state) {
            return PreferencesDropDown(
              title: 'Order artists by',
              value: orderByText[BlocProvider.of<PreferencesBloc>(context)
                  .state
                  .artistsOrderType]!,
              options: OrderType.values,
              optionsText: orderByText,
              onChanged: (dynamic orderType) {
                BlocProvider.of<PreferencesBloc>(context).add(
                  ChangeArtistOrderType(
                    orderType: orderType,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class AlbumsSortingPreferences extends StatelessWidget {
  const AlbumsSortingPreferences({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<PreferencesBloc, PreferencesState>(
          buildWhen: (previous, current) =>
              previous.albumsSortType != current.albumsSortType,
          builder: (context, state) {
            return PreferencesDropDown(
              title: 'Sort albums by',
              value: sortAlbumsByText[BlocProvider.of<PreferencesBloc>(context)
                  .state
                  .albumsSortType]!,
              options: AlbumSortType.values,
              optionsText: sortAlbumsByText,
              onChanged: (dynamic sortType) {
                BlocProvider.of<PreferencesBloc>(context).add(
                  ChangeAlbumSortType(
                    sortType: sortType,
                  ),
                );
              },
            );
          },
        ),
        BlocBuilder<PreferencesBloc, PreferencesState>(
          buildWhen: (previous, current) =>
              previous.albumsOrderType != current.albumsOrderType,
          builder: (context, state) {
            return PreferencesDropDown(
              title: 'Order albums by',
              value: orderByText[BlocProvider.of<PreferencesBloc>(context)
                  .state
                  .albumsOrderType]!,
              options: OrderType.values,
              optionsText: orderByText,
              onChanged: (dynamic orderType) {
                BlocProvider.of<PreferencesBloc>(context).add(
                  ChangeAlbumOrderType(
                    orderType: orderType,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class SongsSortingPreferences extends StatelessWidget {
  const SongsSortingPreferences({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<PreferencesBloc, PreferencesState>(
          buildWhen: (previous, current) =>
              previous.songsSortType != current.songsSortType,
          builder: (context, state) {
            return PreferencesDropDown(
              title: 'Sort songs by',
              value: sortSongsByText[BlocProvider.of<PreferencesBloc>(context)
                  .state
                  .songsSortType]!,
              options: SongSortType.values,
              optionsText: sortSongsByText,
              onChanged: (dynamic sortType) {
                BlocProvider.of<PreferencesBloc>(context).add(
                  ChangeSongSortType(
                    sortType: sortType,
                  ),
                );
              },
            );
          },
        ),
        BlocBuilder<PreferencesBloc, PreferencesState>(
          buildWhen: (previous, current) =>
              previous.songsOrderType != current.songsOrderType,
          builder: (context, state) {
            return PreferencesDropDown(
              title: 'Order songs by',
              value: orderByText[BlocProvider.of<PreferencesBloc>(context)
                  .state
                  .songsOrderType]!,
              options: OrderType.values,
              optionsText: orderByText,
              onChanged: (dynamic orderType) {
                BlocProvider.of<PreferencesBloc>(context).add(
                  ChangeSongOrderType(
                    orderType: orderType,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class PreferencesDropDown extends StatelessWidget {
  final String title;
  final String value;
  final List<dynamic> options;
  final Map<dynamic, String> optionsText;
  final void Function(dynamic) onChanged;

  const PreferencesDropDown({
    Key? key,
    required this.title,
    required this.value,
    required this.options,
    required this.optionsText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(height: 20.0),
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                width: 1.4,
                color: Colors.pinkAccent.shade400,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<dynamic>(
                hint: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                items: options
                    .map(
                      (option) => DropdownMenuItem(
                        value: option,
                        child: Text(
                          optionsText[option]!,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
