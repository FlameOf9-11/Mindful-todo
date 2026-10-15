import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/routes/app_routes.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<SignupScreen> createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  //variables

  bool is_visibile = false;
  final linkStyle = GoogleFonts.plusJakartaSans(
    color: AppColors.textLink,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
    decorationThickness: 2,
    decorationColor: AppColors.textLink,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.cardBorderPurple),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 18),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'MINDFUL',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Sign Up',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48),
              Text(
                'Begin Your Foucs',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'A calm space for your daily tasks and thoughts.',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.textPrimary,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w400,
                  wordSpacing: -1,
                ),
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.person_outline,
                    color: AppColors.primaryGreen,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  Text('Full Name'),
                ],
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 4,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  //style of user type
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hint: Text(
                      'Your name',
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.textHint,
                        fontSize: 16,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.inputBackground,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.email_outlined,
                    color: AppColors.primaryGreen,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  Text('Email Address'),
                ],
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 4,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  //style of user type
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hint: Text(
                      'GrooveStreet@gs.com',
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.textHint,
                        fontSize: 16,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.inputBackground,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lock_outline,
                    color: AppColors.primaryGreen,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  Text('Password'),
                ],
              ),
              SizedBox(height: 8),
              //password
              Container(
                //for textField shadow
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 4,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  //style of user input
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        is_visibile
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          is_visibile = !is_visibile;
                        });
                      },
                    ),
                    contentPadding: EdgeInsets.all(18),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hint: Text(
                      '••••••••',
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.textHint,
                        fontSize: 16,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.inputBackground,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: is_visibile,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(172, 125, 164, 141),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Recommended 8+ characters for peaceful security',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              FilledButton.icon(
                icon: const Icon(
                  Icons.arrow_forward, // Or Icons.east
                  size: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                // Places the icon on the right (after the label)
                iconAlignment: IconAlignment.end,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
                },
                label: Text(
                  'Create Account',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.inputBackground,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  padding: EdgeInsets.fromLTRB(100, 16, 100, 16),
                  alignment: Alignment.center,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: 'By signing up, you agree to our ',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                    children: [
                      TextSpan(text: 'Terms of Service', style: linkStyle),
                      const TextSpan(text: ' & \n'),
                      TextSpan(text: 'Privacy Policy.', style: linkStyle),
                    ],
                  ),
                ),
              ),
              Spacer(),

              Padding(
                
                padding: const EdgeInsets.fromLTRB(70, 0, 70, 40),
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: 'Already have an account?',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.loginRoute,
                            );
                          },
                          child: Text(
                            'Log In',
                            style: GoogleFonts.plusJakartaSans(
                              color: AppColors.textLink,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
