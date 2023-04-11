// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:valorant/models/searchModel.dart';

class CustomSearchClass extends SearchDelegate {
  late List<SearchModel> searchList;
  final List<SearchModel> searchResult = List.empty(growable: true);
  CustomSearchClass(this.searchList);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      searchResult.clear();
    } else {
      searchResult.addAll(searchList
          .where((element) => element.displayName!.contains(query))
          .toList());
    }

    return Center(
        child: ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
              backgroundImage: NetworkImage(searchResult[index].displayIcon!)),
          title: Text(searchResult[index].displayName!),
        );
      },
      itemCount: searchResult.length,
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
