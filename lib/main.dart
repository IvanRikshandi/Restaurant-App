import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/constants/constants.dart';
import 'package:restaurant_app/screens/homepage/view_model/homepage_viewmodel.dart';
import 'package:restaurant_app/screens/homepage_detail/view_model/detailHomepage_viewmodel.dart';
import 'package:restaurant_app/screens/riviewpage/view_model/riview_viewmodel.dart';
import 'package:restaurant_app/screens/splashscreen/splashscreen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                HomepageRestaurantViewModel(apiService: BaseConstant())),
        ChangeNotifierProvider(create: (_) => DetailRestaurantViewModel()),
        ChangeNotifierProvider(create: (_) => RiviewViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xffFFFFFF),
          secondaryHeaderColor: const Color(0xff212121),
          scaffoldBackgroundColor: const Color(0xffF6F7FC),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xffF6F7FC),
            foregroundColor: Color(0xff212121),
          ),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
