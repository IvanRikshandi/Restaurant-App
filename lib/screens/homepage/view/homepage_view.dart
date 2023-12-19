import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_app/screens/homepage/view_model/homepage_viewmodel.dart';
import 'package:restaurant_app/screens/homepage/view/widget/carousel.dart';
import 'widget/gridview.dart';

class HomePage extends StatelessWidget {
  final HomepageRestaurantViewModel viewModel = HomepageRestaurantViewModel();
  HomePage({super.key}) {
    viewModel.getMenuFromJson();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return Scaffold(body: _landscapeMode());
    } else {
      return Scaffold(body: _portraitMode());
    }
  }

  FutureBuilder<void> _portraitMode() {
    return FutureBuilder(
      future: viewModel.getMenuFromJson(),
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
                        BuildRestaurantList(viewModel: viewModel),
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

  FutureBuilder<void> _landscapeMode() {
    return FutureBuilder(
      future: viewModel.getMenuFromJson(),
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
                        BuildRestaurantList(viewModel: viewModel),
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
