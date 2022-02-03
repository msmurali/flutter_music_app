import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/src/global/constants/index.dart';
import 'package:music/src/interface/widgets/preferences_option.dart';
import 'package:music/src/logic/bloc/preferences_bloc/bloc.dart';

class ViewPreferences extends StatelessWidget {
  const ViewPreferences({Key? key}) : super(key: key);

  Widget _blocBuilder(BuildContext context, PreferencesState state) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<PreferencesBloc, PreferencesState>(
      builder: (context, state) {
        PreferencesState currentState =
            BlocProvider.of<PreferencesBloc>(context).state;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'View',
              style: theme.textTheme.bodyText2,
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PreferencesOption(
                  active: currentState.view == View.list,
                  asset: 'asset/images/list_view.svg',
                  title: 'List',
                  onTap: () {
                    BlocProvider.of<PreferencesBloc>(context).add(
                      const SetListView(),
                    );
                  },
                ),
                const SizedBox(width: 12.0),
                PreferencesOption(
                  active: currentState.view == View.grid,
                  asset: 'asset/images/grid_view.svg',
                  title: 'Grid',
                  onTap: () {
                    BlocProvider.of<PreferencesBloc>(context).add(
                      const SetGridView(),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                Text(
                  'Number of tiles in\na row',
                  style: theme.textTheme.subtitle1!.copyWith(
                    color: currentState.view == View.list
                        ? Colors.green
                        : theme.colorScheme.secondary,
                  ),
                ),
                const Spacer(),
                ...gridSizes
                    .map((size) => Row(
                          children: [
                            const SizedBox(width: 20.0),
                            PreferencesOption(
                              enabled: currentState.view == View.grid,
                              active: currentState.gridSize == size,
                              title: size.toString(),
                              onTap: () {
                                BlocProvider.of<PreferencesBloc>(context).add(
                                  ChangeGridSize(
                                    size: size,
                                  ),
                                );
                              },
                            ),
                          ],
                        ))
                    .toList(),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
      ),
      child: BlocBuilder<PreferencesBloc, PreferencesState>(
        buildWhen: (PreferencesState previous, PreferencesState current) =>
            previous.view != current.view,
        builder: _blocBuilder,
      ),
    );
  }
}
