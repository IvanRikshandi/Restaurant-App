import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/screens/homepage/view/favoritelist_page/view/favoriteslist_pageview.dart';
import 'package:restaurant_app/screens/homepage/view/settings_page/view/settingsview_page.dart';
import '../../view_model/homepage_viewmodel.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Consumer<HomepageRestaurantViewModel>(
        builder: (context, viewModel, _) {
      return Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: searchController,
                onChanged: (query) {
                  if (query.isEmpty) {
                    viewModel.fetchRestaurantLists();
                  } else {
                    viewModel.fetchSearchRestaurants(query);
                  }
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
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const FavoriteListPageView(),
              ),
            ),
            child: const Icon(
              Icons.favorite,
              color: Colors.orange,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SettingsPageView()),
            ),
            child: const Icon(
              Icons.more_vert,
              color: Colors.orange,
            ),
          ),
        ],
      );
    });
  }
}
