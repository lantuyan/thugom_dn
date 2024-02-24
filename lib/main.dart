import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thu_gom/app_binding.dart';
import 'package:thu_gom/controllers/theme/themes_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:thu_gom/routes/routes.dart';
import 'package:thu_gom/shared/themes/Themes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/shared/translations/localization_service.dart';

void main() async {
  await GetStorage.init();

  runApp(App());
}

class App extends StatelessWidget {
  final ThemesController themeController = Get.put(ThemesController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return SafeArea(
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Thu Gom',
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            themeMode: getThemeMode(themeController.theme),
            locale: LocalizationService.locale,
            fallbackLocale: LocalizationService.fallbackLocale,
            translations: LocalizationService(),
            getPages: Routes.routes,
            initialRoute: Routes.INITIAL,
            initialBinding: AppBinding(),
          ),
        );
      },
    );
  }

  ThemeMode getThemeMode(String type) {
    ThemeMode themeMode = ThemeMode.system;
    switch (type) {
      case "system":
        themeMode = ThemeMode.system;
        break;
      case "dark":
        themeMode = ThemeMode.dark;
        break;
      default:
        themeMode = ThemeMode.light;
        break;
    }
    return themeMode;
  }
}
