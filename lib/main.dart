import 'package:flutter/material.dart';
import 'package:Mindful/models/token_storage.dart';
import 'package:Mindful/routes/app_router.dart';
import 'package:Mindful/routes/app_routes.dart';
import 'package:Mindful/core/theme/app_colors.dart'; // Ensure this matches your file name

//to display a message across the screens
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
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
      //attaching the global messenger
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
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