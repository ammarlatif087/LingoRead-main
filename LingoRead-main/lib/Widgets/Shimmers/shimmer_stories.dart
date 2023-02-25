import 'package:flutter/material.dart';
import 'package:lingoread/Utils/app_constants.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerStories extends StatelessWidget {
  const ShimmerStories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400.withOpacity(0.5),
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  left: AppConst.padding * 0.5,
                  right: AppConst.padding * 0.5,
                  bottom: AppConst.padding * 0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 15,
                        width: 150,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 12,
                            width: 80,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 12,
                            width: 30,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        height: 12,
                        width: 40,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        height: 40,
                        width: 150,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Container(
                    height: 90,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
