import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/todo_screen.dart';
import 'package:flutter_application_1/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  //variables
  int _counter = 0;
  bool is_visibile = false;
  final _forget_pass_config = GoogleFonts.plusJakartaSans(
    color: AppColors.textLink,
    fontWeight: FontWeight.w600,
  );
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
                    'Log In',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48),
              //welcome card
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFF1F5F2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Serene Space tag
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFE2EBE4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.spa, color: Color(0xFF2E4F3E), size: 14),
                          SizedBox(width: 6),
                          Text(
                            'SERENE SPACE',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                              color: const Color(0xFF2E4F3E),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),

                    //Title
                    Text(
                      'Welcome Back',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E2822),
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // 3. Subtitle Description
                    Text(
                      'Sign in to access your calm, focused workspace',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6B7A70),
                        height: 1.4, // Line height for comfortable reading
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Email address',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              TextField(
                //style of user input
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.alternate_email_outlined),
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
                    'CJ@gs.com',
                    style: GoogleFonts.plusJakartaSans(
                      color: AppColors.textHint,
                      fontSize: 16,
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.inputBackground,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              Text(
                'Password',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              TextField(
                //style of user input
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      !is_visibile
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        is_visibile = !is_visibile;
                      });
                    },
                  ),
                  prefixIcon: Icon(Icons.lock_open_outlined),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        side: BorderSide.none,
                        value: _rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        shape: CircleBorder(),
                        fillColor: WidgetStateProperty.resolveWith<Color>((
                          Set<WidgetState> states,
                        ) {
                          if (states.contains(WidgetState.selected)) {
                            return const Color(0xFF2E4F3E);
                          }
                          return const Color(0xFFE0E3DF);
                        }),
                      ),

                      Text(
                        'Remember me',
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Forgot password?',
                      style: _forget_pass_config,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  icon: const Icon(
                    Icons.arrow_forward, // Or Icons.east
                    size: 20,
                    color: Colors.white,
                  ),
                  // Places the icon on the right (after the label)
                  iconAlignment: IconAlignment.end,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TodoScreen()),
                    );
                  },
                  label: Text(
                    'Log In',
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
                    // padding: EdgeInsets.fromLTRB(120, 16, 120, 16),
                    alignment: Alignment.center,
                    minimumSize: Size(350, 55),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 0, 80, 40),
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: "Don't have an account?",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                    children: [
                      TextSpan(
                        text: ' Sign Up',
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.textLink,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none,
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
