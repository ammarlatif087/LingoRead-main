import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class ShimmerViewBanners extends StatelessWidget {
  const ShimmerViewBanners({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300.withOpacity(0.5),
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          Container(
            // margin: EdgeInsets.only(right: 15, left: 15, bottom: 14),
            height: 150,

            decoration: BoxDecoration(
              color: Colors.grey,

              // borderRadius: BorderRadius.circular(15)
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  color: Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 15,
                      width: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Container(
                      height: 15,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Container(
                      height: 75,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
