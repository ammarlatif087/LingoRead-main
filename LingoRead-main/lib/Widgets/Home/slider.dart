// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lingoread/Controllers/Theme/homecontroller.dart';
// import 'package:lingoread/Routes/routes_names.dart';
// import 'package:lingoread/Utils/app_constants.dart';

// import 'carasol_container.dart';

// class CarasoleWidget extends StatelessWidget {
//   CarasoleWidget(this.listBanners, {Key? key}) : super(key: key);
//   int activeIndex = 0;
//   get child => null;

//   final List listBanners;
//   final HomeController homeController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CarouselSlider(
//           items: listBanners
//               .map((e) => InkWell(
//                     onTap: (() {
//                       Get.toNamed(Routes.stories_page, arguments: e);
//                     }),
//                     child: CarasolContainer(
//                       // imagePath: e["image"],
//                       date: e["created_on"],
//                       title: e["title"],
//                       description: e["description"],
//                     ),
//                   ))
//               .toList(),

//           //Slider Container properties
//           options: CarouselOptions(
//             onPageChanged: (index, reason) {
//               print(index);
//               homeController.setIndex(index);
//             },
//             height: 310.0,
//             // enlargeCenterPage: true,
//             autoPlay: true,
//             aspectRatio: 16 / 9,
//             autoPlayCurve: Curves.fastOutSlowIn,
//             enableInfiniteScroll: true,
//             viewportFraction: 1.0,
//           ),
//         ),
//         Obx(
//           () => Padding(
//             padding: EdgeInsets.symmetric(vertical: AppConst.padding * 0.5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   backgroundColor: homeController.indexSlider.value == 0
//                       ? Theme.of(context).primaryColorDark
//                       : Theme.of(context).primaryColorLight,
//                   radius: 5,
//                 ),
//                 const SizedBox(
//                   width: 2,
//                 ),
//                 CircleAvatar(
//                   backgroundColor: homeController.indexSlider.value == 1
//                       ? Theme.of(context).primaryColorDark
//                       : Theme.of(context).primaryColorLight,
//                   radius: 5,
//                 ),
//                 const SizedBox(
//                   width: 2,
//                 ),
//                 CircleAvatar(
//                   backgroundColor: homeController.indexSlider.value == 2
//                       ? Theme.of(context).primaryColorDark
//                       : Theme.of(context).primaryColorLight,
//                   radius: 5,
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
