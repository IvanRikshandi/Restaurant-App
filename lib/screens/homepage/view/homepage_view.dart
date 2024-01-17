import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/service/constants.dart';
import 'package:restaurant_app/screens/homepage/view/widget/carousel.dart';
import 'widget/gridview.dart';
import 'widget/textfield_search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var networkStatus = Provider.of<ConnectivityStatus>(context);

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return Scaffold(
        body: networkStatus == ConnectivityStatus.connected
            ? SafeArea(
                child: _landscapeMode(),
              )
            : _buildNoConnectionPage(),
      );
    } else {
      return Scaffold(
        body: networkStatus == ConnectivityStatus.connected
            ? SafeArea(
                child: _portraitMode(),
              )
            : _buildNoConnectionPage(),
      );
    }
  }

  Widget _portraitMode() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      children: [
        Column(
          children: [
            Column(
              children: [
                const TextFieldWidget(),
                const SizedBox(height: 20),
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
                const BuildRestaurantList()
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _landscapeMode() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      children: [
        Column(
          children: [
            Column(
              children: [
                const TextFieldWidget(),
                const SizedBox(height: 20),
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
                const BuildRestaurantList()
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNoConnectionPage() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.signal_wifi_off, size: 48, color: Colors.red),
          SizedBox(height: 16),
          Text(
            'No Internet Connection',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
