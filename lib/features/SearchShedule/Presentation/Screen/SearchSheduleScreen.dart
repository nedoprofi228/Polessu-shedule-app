import 'package:application/common/searchGroupBloc/SearchGroupBloc.dart';
import 'package:application/features/SearchShedule/Presentation/Screen/SearchAppBar.dart';
import 'package:application/features/SearchShedule/Presentation/Screen/SearchHistoryWidget.dart';
import 'package:application/features/Shedule/Presentation/Bloc/SheduleBloc.dart';
import 'package:application/features/Shedule/Presentation/Bloc/SheduleEvent.dart';
import 'package:application/features/Shedule/Presentation/Screen/SheduleAppBar.dart';
import 'package:application/features/Shedule/Presentation/Screen/SheduleScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class SearchSheduleScreen extends StatelessWidget {
  const SearchSheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchGroupBloc>(
      create: (context) => getIt<SearchGroupBloc>()..add(LoadingGroups()),
      child: BlocBuilder<SearchGroupBloc, SearchGroupState>(
        builder: (context, state) {
          if (state.selectedGroup == "") {
            return SearchAppBar(child: SearchHistoryWidget());
          }

          return BlocProvider<Shedulebloc>(
            create: (context) =>
                getIt<Shedulebloc>()
                  ..add(LoadingShedule(action: LoadingAction.get, groupName: state.selectedGroup)),
            child: SheduleAppBar(groupName: state.selectedGroup, child: SheduleScreen()),
          );
        },
      ),
    );
  }
}
