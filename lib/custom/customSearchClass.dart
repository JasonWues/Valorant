// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:valorant/models/searchModel.dart';

class CustomSearchClass extends SearchDelegate {
  late List<SearchModel> searchList;
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
    searchList = searchList
        .where((element) => element.displayName!.contains(query))
        .toList();
    return Center(
        child: ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
              backgroundImage: NetworkImage(searchList[index].displayIcon!)),
          title: Text(searchList[index].displayName!),
        );
      },
      itemCount: searchList.length,
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
