import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'screens/todo_screen.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart'; // Ensure this matches your file name

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false, // Removes the debug banner on the top right
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryGreen),
        useMaterial3: true,
      ),
      home: LoginScreen(), // Points to the Stateful widget we just created
    );
  }
}