// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:lingoread/Controllers/Theme/themecontroller.dart';
// import 'package:lingoread/Utils/app_constants.dart';
// import 'package:shimmer/shimmer.dart';

// class CarasolContainer extends StatelessWidget {
//   CarasolContainer(
//       {Key? key,
//       //  required this.imagePath,
//       required this.date,
//       required this.title,
//       required this.description})
//       : super(key: key);
//   //final String imagePath;
//   final String date;
//   final String title;
//   final String description;
//   DateFormat dateFormat = DateFormat("MMM dd, yyyy");
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 200,
//           // margin: EdgeInsets.all(6.0),
//           decoration: BoxDecoration(
//             color: Colors.grey,
//             // image: DecorationImage(
//             //   image: NetworkImage(imagePath.contains("http")
//             //       ? imagePath
//             //       : (AppConst.imagebaseurl + imagePath)),
//             //   fit: BoxFit.cover,
//             // ),
//           ),
//         ),
//         Obx(
//           () => Container(
//               decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(5),
//                   bottomRight: Radius.circular(5),
//                 ),
//                 color: Theme.of(context).primaryColorLight,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       dateFormat.format(DateTime.parse(date)),
//                       textAlign: TextAlign.start,
//                       style: Theme.of(context).textTheme.headline5!.copyWith(
//                           color: ThemeController.to.isDark.isTrue
//                               ? AppConst.light_textColor_gw
//                               : AppConst.colorPrimaryLight,
//                           fontSize: 14),
//                     ),
//                     Text(
//                       title,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: Theme.of(context).textTheme.headline4!.copyWith(
//                             color: Theme.of(context).primaryColorDark,
//                           ),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             description,
//                             maxLines: 3,
//                             overflow: TextOverflow.ellipsis,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .headline5!
//                                 .copyWith(
//                                   color: ThemeController.to.isDark.isTrue
//                                       ? AppConst.light_textColor_gw
//                                       : Theme.of(context).colorScheme.onSurface,
//                                 ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 8.0,
//                     )
//                   ],
//                 ),
//               )),
//         )
//       ],
//     );
//   }
// }
