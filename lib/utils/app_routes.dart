import 'package:final_app/features/home/view/home_screen.dart';
import 'package:get/get.dart';
import '../features/splash/view/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/SplashScreen';
  static const String homeScreen = '/HomeScreen';


  static final List<GetPage> routes = [
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(name: AppRoutes.homeScreen, page: () => HomeScreen()),
  ];

}