import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/homepage_viewmodel.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageRestaurantViewModel>(
        builder: (context, viewModel, _) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: 40,
        child: TextField(
          onChanged: (query) {
            viewModel.isSearching = query.isNotEmpty;
            viewModel.querys = query;
            viewModel.fetchData();
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            prefixIcon: const Icon(Icons.search),
            hintText: 'Search Restaurant',
            isDense: true,
            contentPadding: const EdgeInsets.all(5),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      );
    });
  }
}
