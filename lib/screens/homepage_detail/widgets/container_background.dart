import 'package:flutter/material.dart';
import '../../homepage/models/restaurantmodels.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    super.key,
    required this.item,
  });

  final Restaurant item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(item.pictureId),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.8),
            BlendMode.darken,
          ),
        ),
      ),
    );
  }
}
