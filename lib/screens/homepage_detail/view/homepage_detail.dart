import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/constants/constants.dart';
import 'package:restaurant_app/screens/homepage_detail/view_model/detailHomepage_viewmodel.dart';
import 'widgets/stack_landscape_builddata.dart';
import 'widgets/stack_portrait_builddata.dart';

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
        return BuildDetailHasData(imgUrl: imgUrl, restaurant: restaurant);
      }
    });
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
        return BuildDetailHasDataLandscape(
            imgUrl: imgUrl, restaurant: restaurant);
      }
    });
  }
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
  return Center(child: Lottie.asset(viewModel.getLottieLoading()));
}
