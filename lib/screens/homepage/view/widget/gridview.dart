// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// // import 'package:restaurant_app/screens/homepage_detail/view/homepage_detail.dart';
// import '../../view_model/homepage_viewmodel.dart';
// import 'package:restaurant_app/screens/homepage/models/restaurantmodels.dart';

// class BuildRestaurantList extends StatelessWidget {
//   const BuildRestaurantList({
//     super.key,
//     required this.viewModel,
//   });

//   final HomepageRestaurantViewModel viewModel;

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: MediaQuery.of(context).orientation == Orientation.landscape
//           ? const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 4,
//               crossAxisSpacing: 2,
//               mainAxisSpacing: 8,
//               childAspectRatio: 0.8,
//             )
//           : const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 2,
//               mainAxisSpacing: 8,
//               childAspectRatio: 0.8),
//       shrinkWrap: true,
//       itemCount: viewModel.restaurantList.length,
//       itemBuilder: (context, idx) {
//         final resto = viewModel.restaurantList[idx];
//         final imgUrl = viewModel.getImageUrl(resto.pictureId);
//         return _buildCard(imgUrl, resto);
//       },
//     );
//   }

//   GestureDetector _buildCard(String imgUrl, Restaurant resto) {
//     return GestureDetector(
//       onTap: () {
//         // Navigator.of(context).push(
//         //     MaterialPageRoute(builder: (x) => HomePageDetail(item: menus)));
//       },
//       child: Card(
//         semanticContainer: true,
//         elevation: 5,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Flexible(
//                 flex: 5,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(15),
//                   child: SizedBox(
//                     height: 180,
//                     child: Image.network(
//                       imgUrl,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Flexible(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         resto.name,
//                         textAlign: TextAlign.left,
//                         overflow: TextOverflow.ellipsis,
//                         style: GoogleFonts.poppins(
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Flexible(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         const Icon(Icons.location_on, size: 10),
//                         Text(
//                           resto.city,
//                           style: GoogleFonts.poppins(fontSize: 10),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.star_rate_rounded,
//                           size: 12,
//                           color: Colors.red,
//                         ),
//                         Text(
//                           '${resto.rating}',
//                           style: GoogleFonts.poppins(fontSize: 10),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
