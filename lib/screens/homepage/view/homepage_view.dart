import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/constants/constants.dart';
import 'package:restaurant_app/screens/homepage/view_model/homepage_viewmodel.dart';
import 'widget/listview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomepageRestaurantViewModel get viewModel =>
      context.read<HomepageRestaurantViewModel>();

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
        if (viewModel.state == ResultState.loading) {
          return buildLoading(viewModel);
        } else if (viewModel.state == ResultState.failure) {
          return buildErrorData(viewModel);
        } else if (viewModel.state == ResultState.noData) {
          return buildNoData(viewModel);
        } else {
          return BuildHasData(viewModel: viewModel);
        }
      },
    );
  }

  Widget _landscapeMode() {
    return Consumer<HomepageRestaurantViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.state == ResultState.loading) {
          return buildLoading(viewModel);
        } else if (viewModel.state == ResultState.failure) {
          return buildErrorData(viewModel);
        } else if (viewModel.state == ResultState.noData) {
          return buildNoData(viewModel);
        } else {
          return BuildHasData(viewModel: viewModel);
        }
      },
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
    return Center(child: LottieBuilder.asset(viewModel.getLottieLoading()));
  }
}
