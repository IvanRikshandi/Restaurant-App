import 'package:flutter/material.dart';
import '../../view_model/homepage_viewmodel.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.viewModel,
  });

  final HomepageRestaurantViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 40,
      child: TextField(
        onChanged: (query) {
          viewModel.searchRestaurants(query);
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
  }
}
