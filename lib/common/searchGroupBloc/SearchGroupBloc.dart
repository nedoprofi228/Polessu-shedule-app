import 'package:application/common/repositories/GroupRepository.dart';
import 'package:application/common/services/SearchGroupService.dart';
import 'package:application/common/usecases/GetGroupsUsecase.dart';
import 'package:application/features/SearchShedule/Domain/entities/searchHistoryEntity.dart';
import 'package:application/features/SearchShedule/Domain/usecases/deleteHistoryUsecase.dart';
import 'package:application/features/SearchShedule/Domain/usecases/deleteSearchHistoryUsecase.dart';
import 'package:application/features/SearchShedule/Domain/usecases/getSearchHistory.dart';
import 'package:application/features/SearchShedule/Domain/usecases/saveSearchInHistory.dart';
import 'package:application/features/Shedule/Domain/usecases/GetAllShedule.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchGroupBloc extends Bloc<SearchGroupEvent, SearchGroupState> {
  final GetGroupsUsecase getGroupsUsecase;
  final SearchGtroupService searchService;
  final GetSearchHistory getSearchHistory;
  final SaveSearchInHistoryUsecase saveSearchInHistoryUsecase;
  final DeleteSearchHistoryUsecase deleteSearchHistoryUsecase;
  final Deletehistoryusecase deletehistoryusecase;
  List<String> allGroups = [];

  SearchGroupBloc({
    required this.searchService,
    required this.getGroupsUsecase,
    required this.getSearchHistory,
    required this.saveSearchInHistoryUsecase,
    required this.deleteSearchHistoryUsecase,
    required this.deletehistoryusecase,
  }) : super(SearchGroupState.initial()) {
    on<SearchTextChanged>((event, emit) {
      if (event.searchText == "") {
        emit(state.copyWith(groups: []));
        return;
      }

      emit(
        state.copyWith(
          groups: searchService.searchGroups(event.searchText, allGroups),
        ),
      );
    });

    on<LoadingGroups>((event, emit) async {
      try {
        allGroups = await getGroupsUsecase();
        var history = await getSearchHistory();
        emit(
          state.copyWith(
            status: SearchGroupStatus.loaded,
            history: history.reversed.toList(),
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: SearchGroupStatus.failure,
            error: e.toString(),
          ),
        );
      }
    });

    on<SelectNewGroup>((event, emit) async {
      try {
        int id = await saveSearchInHistoryUsecase(event.groupName);

        SearchHistoryEntity historyEntity = SearchHistoryEntity(
          groupName: event.groupName,
          id: id,
        );

        state.history.add(historyEntity);

        emit(state.copyWith(selectedGroup: event.groupName));
      } catch (e) {
        print("ошибка сохранения в истории");
      }
    });

    on<SelectGroupFromHistory>((event, emit) async {
      emit(state.copyWith(selectedGroup: event.groupName));
    });

    on<DeleteFromHistory>((event, emit) async {
      try {
        await deleteSearchHistoryUsecase(event.id);
        var item = state.history.firstWhere((e) => e.id == event.id);
        List<SearchHistoryEntity> newHistory = List.generate(
          state.history.length,
          (index) => SearchHistoryEntity(groupName: "", id: 0),
        );
        List.copyRange(newHistory, 0, state.history);

        newHistory.remove(item);
        emit(state.copyWith(history: newHistory));
      } catch (e) {
        print("ошибка удаления из истории");
      }
    });

    on<DeleteHistory>((event, emit) async {
      await deletehistoryusecase();
      emit(state.copyWith(history: []));
    });
  }
}

enum SearchGroupStatus { loading, loaded, failure }

class SearchGroupState extends Equatable {
  final List<SearchHistoryEntity> history;
  final String selectedGroup;
  final SearchGroupStatus status;
  final List<String> groups;
  final String searchText;
  final String error;

  const SearchGroupState({
    required this.history,
    required this.status,
    required this.searchText,
    required this.error,
    required this.groups,
    required this.selectedGroup,
  });

  factory SearchGroupState.initial() {
    return SearchGroupState(
      history: [],
      searchText: "",
      error: "",
      groups: [],
      status: SearchGroupStatus.loading,
      selectedGroup: "",
    );
  }

  @override
  List<Object?> get props => [
    status,
    groups,
    searchText,
    error,
    selectedGroup,
    history,
  ];

  SearchGroupState copyWith({
    List<SearchHistoryEntity>? history,
    String? searchText,
    String? error,
    List<String>? groups,
    SearchGroupStatus? status,
    String? selectedGroup,
  }) {
    return SearchGroupState(
      history: history ?? this.history,
      status: status ?? this.status,
      searchText: searchText ?? this.searchText,
      error: error ?? this.error,
      groups: groups ?? this.groups,
      selectedGroup: selectedGroup ?? this.selectedGroup,
    );
  }
}

class SearchGroupEvent {
  const SearchGroupEvent();
}

class SearchTextChanged extends SearchGroupEvent {
  final String searchText;

  const SearchTextChanged({required this.searchText});
}

class LoadingGroups extends SearchGroupEvent {}

class SelectNewGroup extends SearchGroupEvent {
  final String groupName;

  const SelectNewGroup({required this.groupName});
}

class SelectGroupFromHistory extends SearchGroupEvent {
  final String groupName;

  const SelectGroupFromHistory({required this.groupName});
}

class DeleteFromHistory extends SearchGroupEvent {
  final int id;

  const DeleteFromHistory({required this.id});
}

class DeleteHistory extends SearchGroupEvent {}
