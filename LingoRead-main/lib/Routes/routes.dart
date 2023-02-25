import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:lingoread/Pages/active_plan.dart';
import 'package:lingoread/Pages/change_password.dart';
import 'package:lingoread/Pages/edit_profile.dart';
import 'package:lingoread/Pages/favorite_Screen.dart';
import 'package:lingoread/Pages/home_screen.dart';
import 'package:lingoread/Pages/introduction.dart';
import 'package:lingoread/Pages/levels_screen.dart';
import 'package:lingoread/Pages/login.dart';
import 'package:lingoread/Pages/pay_online.dart';
import 'package:lingoread/Pages/setting.dart';
import 'package:lingoread/Pages/setting_voucher.dart';
import 'package:lingoread/Pages/signup.dart';
import 'package:lingoread/Pages/splash_screen.dart';
import 'package:lingoread/Pages/otp_verification.dart';
import 'package:lingoread/Pages/stories_pages.dart';
import 'package:lingoread/Pages/total_words.dart';
import 'package:lingoread/Pages/training_screen.dart';
import 'package:lingoread/Routes/routes_names.dart';
import 'package:lingoread/Widgets/bottom_nav.dart';

import '../Pages/profile.dart';
import '../Pages/shop.dart';
import '../Pages/pay_online.dart';

List<GetPage<dynamic>> listRoutes = [
  GetPage(
    name: Routes.home,
    page: () => const SplashScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.introduction,
    page: () => const Introduction(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.login,
    page: () => const Login(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.register,
    page: () => const SignUp(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.otpverify,
    page: () => const OTPVerification(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.bottomNavBar,
    page: () => const BottomNav(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.homeScreen,
    page: () => const HomeScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.levelsScreen,
    page: () => const LevelsScreen(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.userProfile,
    page: () => const UserProfile(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.setting,
    page: () => Settings(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.setting_voucher,
    page: () => const SettingVoucher(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.favourites,
    page: () => const Favourites(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.training,
    page: () => Training(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.stories_page,
    page: () => StoriesPage(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.shop,
    page: () => const Shop(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.total_words,
    page: () => const TotalWords(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.edit_profile,
    page: () => EditProfile(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: Routes.change_password,
    page: () => ChangePassword(),
    transition: Transition.noTransition,
  ),
];
