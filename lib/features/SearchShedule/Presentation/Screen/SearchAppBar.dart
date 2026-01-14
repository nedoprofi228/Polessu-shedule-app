import 'package:application/common/searchGroupBloc/SearchGroupBloc.dart';
import 'package:application/common/widgets/SearchGroupPanel.dart';
import 'package:application/common/widgets/SheduleTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class SearchAppBar extends StatelessWidget {
  final Widget child;
  const SearchAppBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return BlocBuilder<SearchGroupBloc, SearchGroupState>(
      builder: (context, state) {
        return Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  color: theme.primaryColor,
                ),

                Expanded(child: child),
              ],
            ),

            Positioned(
              top: 65,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),

                child: SearchGroupPanel(
                  theme: theme,
                  onClick: (searchState, groupName) {
                    context.read<SearchGroupBloc>().add(
                      SelectNewGroup(groupName: groupName),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
