import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

// Color Scheme
const Color primaryDark = Color(0xFF00638B);
const Color primary = Color(0xFF00A3B0);
const Color primaryLight = Color(0xFF15B3B2);
const Color textPrimary = Color(0xFF1A365D);
const Color textSecondary = Color(0xFF4A5568);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [primaryDark, primary, primaryLight],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 
                           MediaQuery.of(context).padding.vertical,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      // Logo
                      Center(
                        child: SvgPicture.asset(
                          'assets/images/idrwMbnV7-.svg',
                          width: 200,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Title
                      Text(
                        'نظام الخدمات الالكترونية',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'E-service System',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.9),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Login Card
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'تسجيل الدخول',
                                style: GoogleFonts.cairo(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: textPrimary,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              const SizedBox(height: 28),
                              // Username Field
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'اسم المستخدم',
                                    style: GoogleFonts.cairo(
                                      fontSize: 14,
                                      color: textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: _usernameController,
                                    textAlign: TextAlign.right,
                                  
                                    style: GoogleFonts.cairo(
                                      fontSize: 15,
                                      color: textPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'أدخل اسم المستخدم',
                                      hintStyle: GoogleFonts.cairo(
                                        color: Colors.grey[500],
                                        fontSize: 14,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.person_outline_rounded,
                                        color: primary,
                                        size: 22,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[50],
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Colors.grey[300]!),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Colors.grey[300]!),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: primary, width: 1.5),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.red, width: 1.5),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // Password Field
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'كلمة المرور',
                                    style: GoogleFonts.cairo(
                                      fontSize: 14,
                                      color: textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: _passwordController,
                                    textAlign: TextAlign.right,
                                    obscureText: _obscurePassword,
                                    style: GoogleFonts.cairo(
                                      fontSize: 15,
                                      color: textPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'أدخل كلمة المرور',
                                      hintStyle: GoogleFonts.cairo(
                                        color: Colors.grey[500],
                                        fontSize: 14,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.lock_outline_rounded,
                                        color: primary,
                                        size: 22,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscurePassword
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color: Colors.grey[500],
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword = !_obscurePassword;
                                          });
                                        },
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[50],
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Colors.grey[300]!),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Colors.grey[300]!),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: primary, width: 1.5),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.red, width: 1.5),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              // Login Button
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _handleLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    'تسجيل الدخول',
                                    style: GoogleFonts.cairo(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Footer
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Text(
                          'جميع الحقوق محفوظة © ${DateTime.now().year} تقنية المعلومات - الادارة العامة للتدريب التقني والمهني بالمدينة المنورة',
                          style: GoogleFonts.cairo(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
