import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/screens/homepage/view/widget/carousel.dart';
import 'package:restaurant_app/screens/homepage/view/widget/gridview.dart';
import '../../view_model/homepage_viewmodel.dart';

class BuildHasData extends StatelessWidget {
  const BuildHasData({
    super.key,
    required this.viewModel,
  });

  final HomepageRestaurantViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                BuildRestaurantList(viewModel: viewModel)
              ],
            ),
          ],
        ),
      ],
    );
  }
}
