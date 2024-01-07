import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/constants/constants.dart';
import '../../../homepage_detail/view/homepage_detail.dart';
import '../../view_model/homepage_viewmodel.dart';
import 'package:restaurant_app/screens/homepage/models/restaurantmodels.dart';

class BuildRestaurantList extends StatefulWidget {
  const BuildRestaurantList({
    super.key,
  });

  @override
  State<BuildRestaurantList> createState() => _BuildRestaurantListState();
}

class _BuildRestaurantListState extends State<BuildRestaurantList> {
  HomepageRestaurantViewModel get viewModel =>
      context.read<HomepageRestaurantViewModel>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await viewModel.fetchData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageRestaurantViewModel>(
        builder: (context, viewModel, _) {
      if (viewModel.state == ResultState.failure) {
        return buildErrorData(viewModel);
      } else if (viewModel.state == ResultState.noData) {
        return buildNoData(viewModel);
      } else if (viewModel.state == ResultState.loading) {
        return buildLoading(viewModel);
      } else {
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate:
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.8,
                    )
                  : const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      childAspectRatio: 0.8),
          shrinkWrap: true,
          itemCount: viewModel.restaurantAppModel.restaurants.length,
          itemBuilder: (context, idx) {
            final resto = viewModel.restaurantAppModel.restaurants[idx];
            final imgUrl = viewModel.getImageUrl(resto.pictureId);
            return _buildCard(imgUrl, resto, context, viewModel);
          },
        );
      }
    });
  }

  GestureDetector _buildCard(String imgUrl, Restaurant resto, context,
      HomepageRestaurantViewModel viewModel) {
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    height: 180,
                    child: FadeInImage(
                      placeholder: AssetImage(viewModel.getPlaceHolderImg()),
                      image: NetworkImage(imgUrl),
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 10),
                        Text(
                          resto.city,
                          style: GoogleFonts.poppins(fontSize: 10),
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
                          style: GoogleFonts.poppins(fontSize: 10),
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
  }

  Widget buildNoData(HomepageRestaurantViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(viewModel.getImgNoData()),
        const Text('No data available'),
      ],
    );
  }

  Widget buildErrorData(HomepageRestaurantViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(viewModel.getImg404Error()),
        const Text('Error: Failed to load data'),
      ],
    );
  }

  Widget buildLoading(HomepageRestaurantViewModel viewModel) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
