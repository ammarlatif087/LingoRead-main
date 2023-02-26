import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoread/Widgets/Main/custom_container.dart';
import 'package:lingoread/Widgets/Main/footer.dart';

import '../Utils/app_constants.dart';
import '../Widgets/Header/CustomerHeader.dart';

class ActivePlan extends StatelessWidget {
  const ActivePlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeContainer(
      child: Scaffold(
        body: Stack(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 25, 35, 15),
                child: Column(
                  children: [
                    SizedBox(height: AppConst.padding * 3),
                    CustomerHeader(
                      image: "assets/images/pay_online.png",
                      title: "Active Plan",
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(AppConst.padding * 1),
                child: Row(children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppConst.padding * 0.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Monthly Plan',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(color: const Color(0xff016064))),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dignissim, elit vel viverra ornare, lacus ipsum aliquet massa, nec lacinia nunc diam vel velit. Mauris nec rutrum mi.',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(AppConst.padding * 0.5),
                      child: Column(
                        children: [
                          Text(
                            '20 USD',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily),
                          ),
                          Text('per month',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color: const Color(0xff00ACC4),
                                      fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Start Date',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      fontWeight: FontWeight.bold)),
                          Text(
                            '2-27-2022',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: const Color(0xff00ACC4),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('End Date',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      fontWeight: FontWeight.bold)),
                          Text(
                            '3-27-2022',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: const Color(0xff00ACC4),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
              )
            ],
          )
        ]),
      ),
    );
  }
}
