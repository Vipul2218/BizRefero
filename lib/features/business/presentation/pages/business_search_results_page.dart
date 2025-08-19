import 'package:flutter/material.dart';

class BusinessSearchResultsPage extends StatelessWidget {
  final String query;
  final String? category;
  final String? location;

  const BusinessSearchResultsPage({
    super.key,
    required this.query,
    this.category,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results for "$query"'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search, size: 64),
            const SizedBox(height: 16),
            Text('Search Results for: $query'),
            if (category != null) Text('Category: $category'),
            if (location != null) Text('Location: $location'),
            const SizedBox(height: 24),
            const Text('Search results will be implemented here'),
          ],
        ),
      ),
    );
  }
}
