import 'package:pesen_id/bindings/auth_bind.dart';
import 'package:pesen_id/bindings/dashboard_bind.dart';
import 'package:pesen_id/bindings/detail_bind.dart';
import 'package:pesen_id/bindings/menu_bind.dart';
import 'package:pesen_id/bindings/search_bind.dart';
import 'package:pesen_id/bindings/splash_bind.dart';
import 'package:pesen_id/routes/routes_name.dart';
import 'package:pesen_id/views/dashboard.dart';
import 'package:pesen_id/views/detail.dart';
import 'package:pesen_id/views/menu.dart';
import 'package:pesen_id/views/search.dart';
import 'package:pesen_id/views/signin.dart';
import 'package:pesen_id/views/splash.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final route = [
    GetPage(
      name: AppRoutesName.splash,
      page: () => const SplashScreen(),
      binding: SplashBind(),
    ),
    GetPage(
      name: AppRoutesName.signin,
      page: () => const SigninScreen(),
      binding: AuthBind(),
    ),
    GetPage(
      name: AppRoutesName.signout,
      page: () => const SigninScreen(),
      binding: AuthBind(),
    ),
    GetPage(
      name: AppRoutesName.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBind(),
    ),
    GetPage(
      name: AppRoutesName.detail,
      page: () => const DetailScreen(),
      binding: DetailBind(),
    ),
    GetPage(
      name: AppRoutesName.menu,
      page: () => const MenuScreen(),
      transition: Transition.rightToLeft,
      binding: MenuBind(),
    ),
    GetPage(
      name: AppRoutesName.search,
      page: () => const SearchScreen(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 250),
      binding: SearchBind(),
    )
  ];
}
