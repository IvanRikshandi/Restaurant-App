import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/screens/homepage/models/restaurantmodels.dart';
import '../widgets/container_background.dart';

class HomePageDetail extends StatelessWidget {
  const HomePageDetail({
    super.key,
    required this.item,
  });

  final Restaurant item;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return _landscapeMode();
    } else {
      return _portraitMode();
    }
  }

  Stack _portraitMode() {
    return Stack(
      children: [
        BackgroundWidget(item: item),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 5,
                  ),
                  height: 500,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        item.city,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rate_rounded,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${item.rating}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                thickness: 1,
                                indent: 20,
                                endIndent: 20,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                item.description,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Popular Menu',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                    size: 15,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.symmetric(
                              vertical: 10),
                          width: double.infinity,
                          height: 35,
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: item.menus.foods.length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 250,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1 / 4,
                              ),
                              itemBuilder: ((context, index) {
                                final foods = item.menus.foods[index];
                                return GridTile(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                        child: FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: Text(
                                        foods.name,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    )),
                                  ),
                                );
                              })),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.symmetric(
                              vertical: 10),
                          width: double.infinity,
                          height: 35,
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: item.menus.drinks.length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 250,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1 / 3,
                              ),
                              itemBuilder: ((context, index) {
                                final drinks = item.menus.drinks[index];
                                return GridTile(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                        child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        drinks.name,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    )),
                                  ),
                                );
                              })),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Stack _landscapeMode() {
    return Stack(
      children: [
        BackgroundWidget(item: item),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        item.city,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rate_rounded,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${item.rating}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                thickness: 1,
                                indent: 20,
                                endIndent: 20,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                item.description,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Popular Menu',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                    size: 15,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.symmetric(
                              vertical: 10),
                          width: double.infinity,
                          height: 40,
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: item.menus.foods.length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 250,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1 / 4,
                              ),
                              itemBuilder: ((context, index) {
                                final foods = item.menus.foods[index];
                                return GridTile(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                        child: FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: Text(
                                        foods.name,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    )),
                                  ),
                                );
                              })),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.symmetric(
                              vertical: 10),
                          width: double.infinity,
                          height: 35,
                          child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: item.menus.drinks.length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 250,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1 / 3,
                              ),
                              itemBuilder: ((context, index) {
                                final drinks = item.menus.drinks[index];
                                return GridTile(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                        child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        drinks.name,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    )),
                                  ),
                                );
                              })),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
