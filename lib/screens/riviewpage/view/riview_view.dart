import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/riview_viewmodel.dart';

class RiviewView extends StatefulWidget {
  const RiviewView({super.key, required this.restaurantId});

  final String restaurantId;

  @override
  State<RiviewView> createState() => _RiviewViewState();
}

class _RiviewViewState extends State<RiviewView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _reviewController.dispose();
  }

  void postReview(RiviewViewModel viewModel) async {
    String restaurantId = widget.restaurantId;
    String name = _nameController.text.trim();
    String review = _reviewController.text.trim();

    if (name.isNotEmpty && review.isNotEmpty) {
      try {
        await viewModel
            .postRestaurantReview(
              restaurantId,
              name,
              review,
            )
            .then((_) => AnimatedSnackBar.material('Success add review',
                    type: AnimatedSnackBarType.success)
                .show(context))
            .then((_) => Navigator.of(context).pop());
      } catch (_) {
        // ignore: use_build_context_synchronously
        AnimatedSnackBar.material('Failed to add review',
                type: AnimatedSnackBarType.success)
            .show(context);
      }
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
