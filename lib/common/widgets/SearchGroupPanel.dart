import 'package:application/common/searchGroupBloc/SearchGroupBloc.dart';
import 'package:application/common/widgets/SheduleTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchGroupPanel extends StatelessWidget {
  final Function(SearchGroupState searchState, String groupName) onClick;

  const SearchGroupPanel({
    super.key,
    required this.theme,
    required this.onClick,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchGroupBloc, SearchGroupState>(
      builder: (context, searchState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SheduleTextField(
              onChanged: (value) => {
                context.read<SearchGroupBloc>().add(
                  SearchTextChanged(searchText: value),
                ),
              },
            ),
            searchState.groups.isEmpty?
            SizedBox():
            Container(
              padding: EdgeInsets.symmetric( vertical: 5),
              constraints: BoxConstraints(maxHeight: 300, minHeight: 0), 
              child: ClipRRect(
                borderRadius: BorderRadius.all( Radius.circular(10)),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  itemCount: searchState.groups.length,
                  itemBuilder: (context, index) {
                    return TextButton(
                      onPressed: () {
                        onClick(searchState, searchState.groups[index]);
                      },
                      style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        overlayColor: const Color.fromARGB(255, 26, 26, 26),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(0),
                        ),
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        searchState.groups[index],
                        style: theme.textTheme.bodyLarge,
                      ),
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
