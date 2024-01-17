import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/screens/homepage_detail/view_model/detailhomepage_viewmodel.dart';
import 'package:restaurant_app/screens/riviewpage/view/riview_view.dart';
import '../../models/restaurant_detail.dart';
import 'container_background.dart';

class BuildDetailHasData extends StatelessWidget {
  const BuildDetailHasData({
    super.key,
    required this.imgUrl,
    required this.restaurant,
    required this.viewModel,
  });

  final String imgUrl;
  final RestaurantDetail restaurant;
  final DetailRestaurantViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundWidget(imgUrl: imgUrl),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              actions: [
                IconButton(
                    onPressed: () async {
                      await viewModel.toggleFavorite();
                    },
                    icon: Icon(
                      viewModel.isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color:
                          viewModel.isFavorite ? Colors.yellow : Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (x) => RiviewView(
                                restaurantId: restaurant.id,
                              )));
                    },
                    icon: const Icon(Icons.add_comment)),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
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
                          buildGridFoodMenu(),
                          buildGridDrinksMenu(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Customer Review',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  Icons.comment_bank_rounded,
                                  color: Colors.green,
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                          buildGridComment(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Container buildGridFoodMenu() {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(vertical: 10),
      width: double.infinity,
      height: 35,
      child: GridView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: restaurant.menus.foods.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
    );
  }

  Container buildGridDrinksMenu() {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(vertical: 10),
      width: double.infinity,
      height: 35,
      child: GridView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: restaurant.menus.drinks.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1 / 3,
          ),
          itemBuilder: ((context, index) {
            final drinks = restaurant.menus.drinks[index];
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
    );
  }

  Widget buildGridComment() {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: restaurant.customerReviews.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 2,
          mainAxisSpacing: 8,
          childAspectRatio: 5,
        ),
        itemBuilder: ((context, index) {
          final review = restaurant.customerReviews[index];
          return GridTile(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      review.review,
                      maxLines: 2,
                      style: const TextStyle(
                        overflow: TextOverflow.clip,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      review.date,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
