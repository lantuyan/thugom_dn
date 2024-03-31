import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/controllers/login/login_binding.dart';
import 'package:thu_gom/controllers/main/home/admin/chart/bar_chart_binding.dart';
import 'package:thu_gom/controllers/main/home/admin/chart/pie_chart_binding.dart';
import 'package:thu_gom/controllers/main/home/home_binding.dart';
import 'package:thu_gom/controllers/main/infomation/infomation_binding.dart';
import 'package:thu_gom/controllers/main/main_binding.dart';
import 'package:thu_gom/controllers/main/process_collector/collector_detail_process_binding.dart';
import 'package:thu_gom/controllers/main/rate/user_detail_binding.dart';
import 'package:thu_gom/controllers/main/request_detail/request_detail_binding.dart';
import 'package:thu_gom/controllers/main/request_person/request_person_binding.dart';
import 'package:thu_gom/controllers/onboarding/onboarding_binding.dart';
import 'package:thu_gom/controllers/profile/profile_binding.dart';
import 'package:thu_gom/controllers/register/register_binding.dart';
import 'package:thu_gom/controllers/splash/splash_binding.dart';
import 'package:thu_gom/views/auth/login/login_screen.dart';
import 'package:thu_gom/views/auth/register/register_screen.dart';
import 'package:thu_gom/views/landing/landing_sceen.dart';
import 'package:thu_gom/views/auth/onboarding/intro/intro_screen.dart';
import 'package:thu_gom/views/auth/onboarding/profile/profile_screen.dart';
import 'package:thu_gom/views/main/home/collector_detail_process_screen.dart';
import 'package:thu_gom/views/main/home/home_screen_person.dart';
import 'package:thu_gom/views/main/home/home_screen_collecter.dart';
import 'package:thu_gom/views/main/home/rate/user_detail_confirm.dart';
import 'package:thu_gom/views/main/home/request_person_screen.dart';
import 'package:thu_gom/views/main/home/request_detail_screen.dart';
import 'package:thu_gom/views/main/home/statistic/bar_chart_screen.dart';
import 'package:thu_gom/views/main/home/statistic/line_chart_screen.dart';
import 'package:thu_gom/views/main/home/statistic/pie_chart_screen.dart';
import 'package:thu_gom/views/main/home/tab/notification_collector.dart';
import 'package:thu_gom/views/main/home/tab/notification_user.dart';
import 'package:thu_gom/views/main/infomation/feedback_screen.dart';
import 'package:thu_gom/views/main/infomation/infomation_screen.dart';
import 'package:thu_gom/views/main/main_screen.dart';
import 'package:thu_gom/views/main/map/map_collecter_screen.dart';
import 'package:thu_gom/views/main/map/map_screen.dart';
import 'package:thu_gom/views/main/map/map.dart';
import 'package:thu_gom/views/splash/splash_screen.dart';

class Routes {
  static const INITIAL = '/splash';
  static final routes = [
    GetPage(
      name: '/splash',
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: '/landingPage',
      page: () => LandingScreen(),
    ),
    GetPage(
      name: '/loginPage',
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    // reigster
    GetPage(
      name: '/registerPage',
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name : '/introPage',
      page: () => IntroScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name:  '/profilePage',
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name:  '/requestDetailPage',
      page: () => RequestDetailScreen(),
      binding: RequestDetailBinding(),
    ),
    GetPage(
      name:  '/user_detail_confirm',
      page: () => UserDetailConfirmScreen(),
      binding: UserDetailConfirmBinding(),
    ),
    GetPage(
      name:  '/confirmm_user',
      page: () => NotificationUser(),
    ),
    GetPage(
      name:  '/processing_collector',
      page: () => NotificationCollector(),
    ),
    GetPage(
      name: '/requestPersonPage',
      page: () => RequestPersonScreen(),
      binding: RequestPersonBinding(),
    ),
    GetPage(
      name: '/feedbackTrashPage',
      page:() => FeedbackScreen(),
      binding: RequestPersonBinding(),
    ),
    GetPage(
      name: '/collector_detail_process',
      page: () => CollectorDetailProcessScreen(),
      binding: CollectorDetailProcessBinding(),
    ),
    GetPage(
      name: '/barChartPage',
      page: () => BarChartScreen(),
      binding: BarChartBinding(),
    ),
    GetPage(
      name: '/lineChartPage',
      page: () => LineChartScreen(),
      // binding: RequestPersonBinding(),
    ),
    GetPage(
      name: '/pieChartPage',
      page: () => PieChartScreen(),
      binding: PieChartBinding(),
    ),
    GetPage(
        name: '/mainPage',
        page: () => MainScreen(),
        binding: MainBinding(),
        children: [
          GetPage(
            name: '/homePage',
            page: () => HomeScreenCollector(),
            children: [
              GetPage(
                name: '/homePageCollector',
                page: () => HomeScreenCollector(),
                binding: HomeBinding(),
              ),
              GetPage(
                name: '/homePagePerson',
                page: () => HomeScreenPerson(),
                binding: HomeBinding(),
              ),
            ],
          ),
          GetPage(
            name: '/mapPage',
            page: () => Map(),
            children: [
              GetPage(
                name: '/mapCollecterScreen',
                page: () => MapCollecterScreen(),
              ),
              GetPage(
                name: '/mapScreen',
                page: () => MapScreen(),
              ),
            ],
          ),
          GetPage(
            name: '/infomationPage',
            page: () => InfomationScreen(),
            binding: InfomationBinding(),
          ),
        ]
    ),
  ];
}
