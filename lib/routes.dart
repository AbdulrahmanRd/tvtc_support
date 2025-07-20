import 'package:flutter/material.dart';
import 'package:tvtc_support/screens/home_screen.dart';
import 'package:tvtc_support/screens/it_support_screen.dart';
import 'package:tvtc_support/screens/login_screen_new.dart';
import 'package:tvtc_support/screens/maintenance_request_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String home = '/home';
  static const String maintenance = '/maintenance';
  static const String itSupport = '/it-support';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case maintenance:
        return MaterialPageRoute(builder: (_) => const MaintenanceRequestScreen());
      case itSupport:
        return MaterialPageRoute(builder: (_) => const ITSupportScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static void configureRoutes(BuildContext context) {
    // This can be used to configure any route-specific settings if needed
  }
}
