import 'package:device_preview/device_preview.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/constant/app_colors.dart';
import 'package:flutter_application/constant/app_strings.dart';
import 'package:flutter_application/router/application.dart';
import 'package:flutter_application/router/routers.dart';
import 'package:flutter_application/utils/shared_preferences_util.dart';
import 'package:flutter_application/view_model/cart_view_model.dart';
import 'package:flutter_application/view_model/user_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var _userViewModel = UserViewModel();
  var _cartViewModel = CartViewModel();
  await _userViewModel.refreshData();
  SharedPreferencesUtil.getInstance().getString(AppStrings.TOKEN).then((value) {
    if (value != null) {
      _cartViewModel.queryCart();
    }
  });
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserViewModel>.value(value: _userViewModel),
      ChangeNotifierProvider<CartViewModel>.value(value: _cartViewModel)
    ],
    child: DevicePreview(
//      enabled: !kReleaseMode,
      enabled: false,
      builder: (context) => MallApp(),
    ),
  ));
}

class MallApp extends StatelessWidget {
  MallApp() {
    final router = FluroRouter();
    Routers.configureRoutes(router);
    Application.router = router;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(750, 1334),
        allowFontScaling: false,
        child: MaterialApp(
          locale: DevicePreview.locale(context),
          // <--- /!\ Add the locale
          builder: DevicePreview.appBuilder,
          // <--- /!\ Add the builder
          title: AppStrings.APP_NAME,
          navigatorKey: Application.navigatorKey,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Application.router.generator,
          theme: ThemeData(
              primarySwatch: AppColors.themeColor,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              scaffoldBackgroundColor: AppColors.COLOR_F8F8F8),
        ));
  }
}
