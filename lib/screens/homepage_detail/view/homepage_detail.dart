import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/constants/constants.dart';
import 'package:restaurant_app/screens/homepage_detail/view_model/detailHomepage_viewmodel.dart';
import 'widgets/container_background.dart';

class HomePageDetail extends StatefulWidget {
  const HomePageDetail({
    super.key,
    required this.restaurantId,
  });

  final String restaurantId;

  @override
  State<HomePageDetail> createState() => _HomePageDetailState();
}

class _HomePageDetailState extends State<HomePageDetail> {
  DetailRestaurantViewModel get viewModel =>
      context.read<DetailRestaurantViewModel>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await viewModel.fetchRestaurantDetail(widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return _landscapeMode();
    } else {
      return _portraitMode();
    }
  }

  Widget _portraitMode() {
    return Consumer<DetailRestaurantViewModel>(
        builder: (context, viewModel, _) {
      if (viewModel.state == ResultState.loading) {
        return buildLoading(viewModel);
      } else if (viewModel.state == ResultState.failure) {
        return buildErrorData(viewModel);
      } else if (viewModel.state == ResultState.noData) {
        return buildNoData(viewModel);
      } else {
        final restaurant = viewModel.restaurantDetailApp.restaurant;
        String imgUrl =
            DetailRestaurantViewModel().getImageUrl(restaurant.pictureId);
        return Stack(
          children: [
            BackgroundWidget(imgUrl: imgUrl),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    restaurant.name,
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
                                            restaurant.city,
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
                                            '${restaurant.rating}',
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
                                    restaurant.description,
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
                                  itemCount: restaurant.menus.foods.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 250,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1 / 4,
                                  ),
                                  itemBuilder: ((context, index) {
                                    final foods = restaurant.menus.foods[index];
                                    return GridTile(
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                  itemCount: restaurant.menus.drinks.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 250,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1 / 3,
                                  ),
                                  itemBuilder: ((context, index) {
                                    final drinks =
                                        restaurant.menus.drinks[index];
                                    return GridTile(
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10),
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
    });
  }

  Widget buildNoData(DetailRestaurantViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(viewModel.getImgNoData()),
        const Text('No data available'),
      ],
    );
  }

  Widget buildErrorData(DetailRestaurantViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(viewModel.getImg404Error()),
        const Text('Error: Failed to load data'),
      ],
    );
  }

  Widget buildLoading(DetailRestaurantViewModel viewModel) {
    return Center(child: LottieBuilder.network(viewModel.getLottieLoading()));
  }

  Widget _landscapeMode() {
    return Consumer<DetailRestaurantViewModel>(
        builder: (context, viewModel, _) {
      if (viewModel.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else {
        final restaurant = viewModel.restaurantDetailApp.restaurant;
        String imgUrl =
            DetailRestaurantViewModel().getImageUrl(restaurant.pictureId);

        return Stack(
          children: [
            BackgroundWidget(imgUrl: imgUrl),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    restaurant.name,
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
                                            restaurant.city,
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
                                            '${restaurant.rating}',
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
                                    restaurant.description,
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
                                  itemCount: restaurant.menus.foods.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 250,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1 / 4,
                                  ),
                                  itemBuilder: ((context, index) {
                                    final foods = restaurant.menus.foods[index];
                                    return GridTile(
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                  itemCount: restaurant.menus.drinks.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 250,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1 / 3,
                                  ),
                                  itemBuilder: ((context, index) {
                                    final drinks =
                                        restaurant.menus.drinks[index];
                                    return GridTile(
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10),
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
    });
  }
}
