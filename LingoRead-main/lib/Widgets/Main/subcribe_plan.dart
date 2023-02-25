import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../Utils/app_constants.dart';
import '../shop_wigdet.dart';

class SubcribePlan extends StatefulWidget {
  const SubcribePlan({Key? key}) : super(key: key);

  @override
  State<SubcribePlan> createState() => _SubcribePlanState();
}

class _SubcribePlanState extends State<SubcribePlan> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: Colors.transparent,
      child: Container(
          child: Align(
        alignment: Alignment.center,
        child: Container(
          color: const Color(0xff757575).withOpacity(0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
                  child: Container(
                    padding: EdgeInsets.all(AppConst.padding * 0.5),
                    alignment: Alignment.center,
                    width: Get.width / 1.08,
                    decoration: BoxDecoration(
                        color: Get.theme.backgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context, false);
                                },
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                        ),
                        Text('Subscribe',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dignissim, elit vel viverra ornare, lacus ipsum aliquet massa, nec lacinia nunc diam vel velit. Mauris nec rutrum mi. ',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ShopWidget(
                            'Monthly Plan',
                            'Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum',
                            Color(0xffE17614)),
                        SizedBox(
                          height: 20,
                        ),
                        ShopWidget(
                            'Monthly Plan',
                            'Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum',
                            Color(0xff4A00C4)),
                        SizedBox(
                          height: AppConst.padding * 2,
                        ),
                        Container(
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color(0xff00ACC4)),
                            child: InkWell(
                              onTap: () {},
                              child: Center(
                                  child: Text(
                                'Subscribe',
                                style: Theme.of(context).textTheme.headline4,
                              )),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
