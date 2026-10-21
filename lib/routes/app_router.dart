import 'package:flutter/material.dart';
import 'package:Mindful/routes/app_routes.dart';
import 'package:Mindful/screens/login_screen.dart';
import 'package:Mindful/screens/signup_screen.dart';
import 'package:Mindful/screens/todo_screen.dart';

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case AppRoutes.signupRoute:
        return MaterialPageRoute(builder: (_) => SignupScreen());

      case AppRoutes.homeRoute:
        return MaterialPageRoute(builder: (_) => TodoScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
