import 'package:flutter/material.dart';
import 'package:Mindful/routes/app_routes.dart';
import 'package:Mindful/screens/todo_screen.dart';
import 'package:Mindful/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/token_storage.dart';
import '../routes/app_routes.dart';
import '../models/auth_service.dart';

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

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  bool _isLoading = false;

  //remember me button values to be used as profile instead of login again(autofill)
  List<Map<String, dynamic>> _savedAccounts = [];
  bool _showSavedAccounts = false;

  //methods

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }
  

Future<void> _loadSavedCredentials() async {
    final accounts = await TokenStorage.getSavedAccounts();
    if (mounted && accounts.isNotEmpty) {
      setState(() {
        _savedAccounts = accounts;
        _showSavedAccounts = true; // Show profiles by default if they exist
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

void _quickLogin(String email, String password) async {
    setState(() => _isLoading = true);
    try {
      await _authService.login(email: email, password: password);
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // void _handleLogin () {
  //   // 3. Extract the text
  //   final email = _emailController.text.trim();
  //   final password = _passwordController.text;

  //   if (email.isEmpty || password.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Please fill in all fields')),
  //     );
  //     return;
  //   }
  //   Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
  //   // Trigger API authentication or navigation
  //   print('Attempting login with: $email');
  // }
  void _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
      return;
    }
    setState(() => _isLoading = true);
    try {
      await _authService.login(email: email, password: password);

      await TokenStorage.saveRememberMe(
          remember: _rememberMe,
          email: email,
          password: password,
        );
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
        
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _handleLogout() async {
    await TokenStorage.deleteToken();

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.loginRoute,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints
                    .maxHeight, // Forces container to match screen height
              ),
              child: IntrinsicHeight(
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 20,
                        ),
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
                                  Icon(
                                    Icons.spa,
                                    color: Color(0xFF2E4F3E),
                                    size: 14,
                                  ),
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
                                height:
                                    1.4, // Line height for comfortable reading
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      if (_showSavedAccounts && _savedAccounts.isNotEmpty)
                        Column(
                          children: [
                            // Generate a card for each saved account
                            ..._savedAccounts.map((account) {
                              final email = account['email'] ?? '';
                              final password = account['password'] ?? '';
                              final prefix = email.split('@').first;
                              final name = prefix.isNotEmpty 
                                  ? prefix[0].toUpperCase() + prefix.substring(1) 
                                  : 'U';

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: InkWell(
                                  onTap: _isLoading ? null : () => _quickLogin(email, password),
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: const Color(0xFFE8ECE9)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.03),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: const Color(0xFFD3EEDD),
                                          foregroundColor: const Color(0xFF2E4F3E),
                                          radius: 24,
                                          child: Text(
                                            name.substring(0, 1).toUpperCase(),
                                            style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                name,
                                                style: GoogleFonts.plusJakartaSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: const Color(0xFF1E2822),
                                                ),
                                              ),
                                              Text(
                                                email,
                                                style: GoogleFonts.plusJakartaSans(
                                                  fontSize: 13,
                                                  color: const Color(0xFF6B7A70),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFF1F5F2),
                                            shape: BoxShape.circle,
                                          ),
                                          child: _isLoading
                                              ? const SizedBox(
                                                  width: 16,
                                                  height: 16,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: Color(0xFF2E4F3E),
                                                  ),
                                                )
                                              : const Icon(
                                                  Icons.arrow_forward,
                                                  size: 16,
                                                  color: Color(0xFF6B7A70),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),

                            const SizedBox(height: 12),
                            TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  _showSavedAccounts = false; // Switch to text fields
                                  _emailController.clear();
                                  _passwordController.clear();
                                  _rememberMe = false;
                                });
                              },
                              icon: const Icon(
                                Icons.add_circle_outline,
                                size: 18,
                                color: Color(0xFF345444),
                              ),
                              label: Text(
                                'Log in with another account',
                                style: GoogleFonts.plusJakartaSans(
                                  color: const Color(0xFF345444),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email address',
                              style: GoogleFonts.plusJakartaSans(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            TextField(
                              controller: _emailController,
                              //style of user input
                              style: GoogleFonts.plusJakartaSans(
                                color: AppColors.textPrimary,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.alternate_email_outlined,
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
                              controller: _passwordController,
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
                              obscureText: !is_visibile,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                      side: BorderSide.none,
                                      value: _rememberMe,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _rememberMe = value ?? false;
                                        });
                                      },
                                      shape: CircleBorder(),
                                      fillColor:
                                          WidgetStateProperty.resolveWith<
                                            Color
                                          >((Set<WidgetState> states) {
                                            if (states.contains(
                                              WidgetState.selected,
                                            )) {
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
                                  _handleLogin();
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
                          ],
                        ),
                      Spacer(),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              text: "Don't have an account?",
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
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        AppRoutes.signupRoute,
                                      );
                                    },
                                    child: Text(
                                      ' Sign Up',
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
