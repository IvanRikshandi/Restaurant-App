import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/screens/homepage/view/favoritelist_page/viewmodel/favoritelist_viewmodel.dart';
import 'package:restaurant_app/screens/homepage_detail/view/homepage_detail.dart';

class FavoriteListPageView extends StatelessWidget {
  const FavoriteListPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteListViewModel viewModel = FavoriteListViewModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite List'),
      ),
      body: FutureBuilder(
        future: viewModel.fetchFavoriteRestaurants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            if (viewModel.favoriteRestaurants.isEmpty) {
              return const Center(
                child: Text('No favorite restaurants.'),
              );
            } else {
              return ListView.builder(
                itemCount: viewModel.favoriteRestaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = viewModel.favoriteRestaurants[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) =>
                              HomePageDetail(restaurantId: restaurant['id']),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            viewModel.getImageUrl(restaurant['imgUrlId']),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              color: Colors.black.withOpacity(0.7),
                              height: 50,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          restaurant['name'],
                                          style: GoogleFonts.poppins(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.red,
                                              size: 14,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              restaurant['rating'].toString(),
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      restaurant['address'],
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}

// body: Consumer<FavoriteListViewModel>(
//         builder: (context, viewModel, _) {
//           if (viewModel.state == ResultState.loading) {
//             return const CircularProgressIndicator();
//           } else if (viewModel.state == ResultState.failure) {
//             return const Text('Error fetching favorite restaurants.');
//           } else if (viewModel.state == ResultState.noData) {
//             return const Text('No favorite restaurants.');
//           } else {
//             return ListView.builder(
//               itemCount: viewModel.favoriteRestaurants.length,
//               itemBuilder: (context, index) {
//                 final restaurant = viewModel.favoriteRestaurants[index];
//                 return ListTile(
//                   title: Text(restaurant['name']),
//                   subtitle: Text(restaurant['address']),
//                   // Add more details as needed
//                 );
//               },
//             );
//           }
//         },
//       ),

// body: FutureBuilder(
//         future: viewModel.fetchFavoriteRestaurants(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             return ListView.builder(
//               itemCount: viewModel.favoriteRestaurants.length,
//               itemBuilder: (context, index) {
//                 final restaurant = viewModel.favoriteRestaurants[index];
//                 return ListTile(
//                   title: Text(restaurant['name']),
//                   subtitle: Text(restaurant['address']),
//                 );
//               },
//             );
//           }
//         },
//       ),