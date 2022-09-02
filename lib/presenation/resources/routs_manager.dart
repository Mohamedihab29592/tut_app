import 'package:flutter/material.dart';
import 'package:tut_app/presenation/main/pages/search/view/search_page.dart';
import 'package:tut_app/presenation/main/pages/setting/contact_us.dart';
import 'package:tut_app/presenation/resources/strings_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../app/di.dart';
import '../forget_password/view/forgetPassword_view.dart';
import '../login/view/login_view.dart';
import '../main/main_view.dart';
import '../onboarding/view/onboarding_view.dart';
import '../register/register_view/register_view.dart';
import '../splash/splash_view.dart';
import '../store_details/view/store_details_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String searchRoute = "/search";
  static const String contactUs = "/contactUs";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      case Routes.contactUs:
        initStoreDetailsModule();
        return MaterialPageRoute(builder: (_) => const ContactUs());
      case Routes.searchRoute:
        initSearchModule();
        return MaterialPageRoute(builder: (_) => const SearchPage());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title:  Text(AppStrings.noRouteFound.tr()),
              ),
              body:  Center(child: Text(AppStrings.noRouteFound.tr())),
            ));
  }
}
