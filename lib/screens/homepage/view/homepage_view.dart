import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/constants/constants.dart';
import 'package:restaurant_app/screens/homepage/view_model/homepage_viewmodel.dart';
import 'package:restaurant_app/screens/homepage/view/widget/carousel.dart';
import '../../homepage_detail/view/homepage_detail.dart';
import 'widget/gridview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomepageRestaurantViewModel viewModel = HomepageRestaurantViewModel();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await viewModel.fetchRestaurantList();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return Scaffold(
        body: SafeArea(
          child: _landscapeMode(),
        ),
      );
    } else {
      return Scaffold(
        body: SafeArea(
          child: _portraitMode(),
        ),
      );
    }
  }

  Widget _portraitMode() {
    return Consumer<HomepageRestaurantViewModel>(
      builder: (context, viewModel, _) {
        print(viewModel.state);
        if (viewModel.state == ResultState.loading) {
          return Center(
              child: LottieBuilder.network(
                  'https://lottie.host/35aef488-5036-4b59-8c35-c3a7a3fcc4df/6ulvzRF4gl.json'));
        } else if (viewModel.state == ResultState.failure) {
          return const Text('Error: Failed to load data');
        } else if (viewModel.state == ResultState.noData) {
          return const Text('No data available');
        } else {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Foodies',
                                style: GoogleFonts.poppins(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'Discover your best culinary experience \nhere.',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Carousel(),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            'Recomendation',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.orange),
                          ),
                        ],
                      ),
                      const Divider(thickness: 1),
                      const SizedBox(height: 10),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 8,
                                childAspectRatio: 0.8,
                              )
                            : const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 8,
                                childAspectRatio: 0.8),
                        shrinkWrap: true,
                        itemCount:
                            viewModel.restaurantAppModel.restaurants.length,
                        itemBuilder: (context, idx) {
                          final resto =
                              viewModel.restaurantAppModel.restaurants[idx];
                          final imgUrl = viewModel.getImageUrl(resto.pictureId);
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (x) => HomePageDetail(
                                        restaurantId: resto.id,
                                      )));
                            },
                            child: Card(
                              semanticContainer: true,
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      flex: 5,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: SizedBox(
                                          height: 180,
                                          child: Image.network(
                                            imgUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Flexible(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              resto.name,
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Icons.location_on,
                                                  size: 10),
                                              Text(
                                                resto.city,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star_rate_rounded,
                                                size: 12,
                                                color: Colors.red,
                                              ),
                                              Text(
                                                '${resto.rating}',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  Widget _landscapeMode() {
    return FutureBuilder(
      future: viewModel.fetchRestaurantList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: LottieBuilder.network(
                  'https://lottie.host/35aef488-5036-4b59-8c35-c3a7a3fcc4df/6ulvzRF4gl.json'));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome Foodies',
                                  style: GoogleFonts.poppins(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Discover your best culinary experience here.',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Carousel(),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'Recomendation',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.orange),
                            ),
                          ],
                        ),
                        const Divider(thickness: 1),
                        const SizedBox(height: 10),
                        //BuildRestaurantList(viewModel: viewModel),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
