import 'package:application/common/searchGroupBloc/SearchGroupBloc.dart';
import 'package:application/features/SearchShedule/Domain/usecases/deleteHistoryUsecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchHistoryWidget extends StatelessWidget {
  const SearchHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return BlocBuilder<SearchGroupBloc, SearchGroupState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text("История поиска", style: theme.textTheme.bodyLarge),
            SizedBox(height: 10),

            state.history.isNotEmpty
                ? TextButton(
                    onPressed: () {
                      context.read<SearchGroupBloc>().add(DeleteHistory());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("очистить все", style: theme.textTheme.bodySmall),
                        Icon(Icons.close),
                      ],
                    ),
                  )
                : SizedBox(),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Container(
                    color: theme.primaryColorLight,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              fixedSize: Size.fromHeight(40),
                              // Убираем внутренние отступы самой кнопки, чтобы мы могли управлять ими вручную
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              state.history[index].groupName,
                              style: theme.textTheme.bodyLarge,
                            ),

                            onPressed: () {
                              context.read<SearchGroupBloc>().add(
                                SelectGroupFromHistory(
                                  groupName: state.history[index].groupName,
                                ),
                              );
                            },
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            context.read<SearchGroupBloc>().add(
                              DeleteFromHistory(id: state.history[index].id),
                            );
                          },
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  color: const Color.fromARGB(255, 224, 224, 224),
                  indent: 20,
                  endIndent: 20,
                ),
                itemCount: state.history.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
