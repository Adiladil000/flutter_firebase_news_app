import 'package:flutter/material.dart';

import 'package:flutter_firebase_news_app/product/models/tag.dart';

class HomeSearchDelegate extends SearchDelegate<Tag?> {
  HomeSearchDelegate(this.tagList);

  final List<Tag> tagList;
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      onPressed: () {
        query = '';
      },
      icon: const Icon(Icons.clear),
    );
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = tagList.where((element) => element.name?.toLowerCase().contains(query.toLowerCase()) ?? false);
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(results.elementAt(index).name ?? ''),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = tagList.where((element) => element.name?.toLowerCase().contains(query.toLowerCase()) ?? false);
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            onTap: () {
              close(context, results.elementAt(index));
            },
            title: Text(results.elementAt(index).name ?? ''),
          ),
        );
      },
    );
  }
}
//