import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/global/navigation.dart';
import 'package:restaurant_app/common/helper/notification_helper.dart';
import 'package:restaurant_app/common/service/background_services.dart';
import 'package:restaurant_app/common/service/constants.dart';
import 'package:restaurant_app/common/service/endpoint.dart';
import 'package:restaurant_app/common/service/network_service.dart';
import 'package:restaurant_app/screens/homepage/view/favoritelist_page/viewmodel/favoritelist_viewmodel.dart';
import 'package:restaurant_app/screens/homepage/view/settings_page/viewmodel/setting_viewmodel.dart';
import 'package:restaurant_app/screens/homepage/view_model/homepage_viewmodel.dart';
import 'package:restaurant_app/screens/homepage_detail/view_model/detailhomepage_viewmodel.dart';
import 'package:restaurant_app/screens/riviewpage/view_model/riview_viewmodel.dart';
import 'package:restaurant_app/screens/splashscreen/splashscreen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  service.initializeIsolate();

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
        StreamProvider(
            create: (_) => NetworkService().controller.stream,
            initialData: ConnectivityStatus.connected),
        ChangeNotifierProvider(
            create: (_) => HomepageRestaurantViewModel(apiService: EndPoint())),
        ChangeNotifierProvider(create: (_) => DetailRestaurantViewModel()),
        ChangeNotifierProvider(create: (_) => RiviewViewModel()),
        ChangeNotifierProvider(create: (_) => FavoriteListViewModel()),
        ChangeNotifierProvider(create: (_) => SettingsViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
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
