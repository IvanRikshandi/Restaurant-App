import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../view_model/riview_viewmodel.dart';

class RiviewView extends StatefulWidget {
  const RiviewView({super.key});

  @override
  State<RiviewView> createState() => _RiviewViewState();
}

class _RiviewViewState extends State<RiviewView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  String formattedDateTime =
      DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  void postReview(RiviewViewModel viewModel) async {
    String name = _nameController.text.trim();
    String review = _reviewController.text.trim();

    if (name.isNotEmpty && review.isNotEmpty) {
      await viewModel
          .postRestaurantReview(name, review, formattedDateTime)
          .then((value) => AnimatedSnackBar.material('Success add review',
                  type: AnimatedSnackBarType.success)
              .show(context));

      await viewModel
          .fetchRestaurantReviews()
          .then((value) => Navigator.of(context).pop());
    } else {
      AnimatedSnackBar.material('Name and Review cannot be empty',
              type: AnimatedSnackBarType.warning)
          .show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RiviewViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _reviewController,
              decoration: const InputDecoration(labelText: 'Review'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                postReview(viewModel);
              },
              child: const Text('Post Review'),
            ),
          ],
        ),
      ),
    );
  }
}
