import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/service/constants.dart';
import 'package:restaurant_app/screens/homepage_detail/view_model/detailhomepage_viewmodel.dart';
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
        return BuildDetailHasData(
            imgUrl: imgUrl, restaurant: restaurant, viewModel: viewModel);
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
          imgUrl: imgUrl,
          restaurant: restaurant,
          viewModel: viewModel,
        );
      }
    });
  }
}

Widget buildNoData(DetailRestaurantViewModel viewModel) {
  return const Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_off_rounded, size: 48, color: Colors.yellow),
          SizedBox(height: 16),
          Text(
            'Data is Empty',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ],
      ),
    ),
  );
}

Widget buildErrorData(DetailRestaurantViewModel viewModel) {
  return const Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red),
          Text(
            'Not Connected to the Internet',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ],
      ),
    ),
  );
}

Widget buildLoading(DetailRestaurantViewModel viewModel) {
  return Center(child: Lottie.asset(viewModel.getLottieLoading()));
}
