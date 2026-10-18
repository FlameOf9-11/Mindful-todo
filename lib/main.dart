import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/token_storage.dart';
import 'package:flutter_application_1/routes/app_router.dart';
import 'package:flutter_application_1/routes/app_routes.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'screens/todo_screen.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart'; // Ensure this matches your file name

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final bool isLoggedIn = await TokenStorage.hasToken();
  runApp(MyApp(initialRoute: isLoggedIn ? AppRoutes.homeRoute: AppRoutes.loginRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key,required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false, // Removes the debug banner on the top right
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryGreen),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      onGenerateRoute: AppRouter().onGenerateRoute, // Points to the Stateful widget we just created
    );
  }
}