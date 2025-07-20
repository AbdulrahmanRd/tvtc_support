import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tvtc_support/routes.dart';


void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Pre-cache any heavy resources
  await Future.wait([
    // Add any heavy initialization here
    // For example: precache images, initialize services, etc.
  ]);

  // Run the app with error handling
  runApp(
    Directionality(
      textDirection: TextDirection.rtl, // Set RTL globally
      child: TVTCSupportApp(),
    ),
  );
}

class TVTCSupportApp extends StatelessWidget {
  const TVTCSupportApp({super.key});

  // Modern, minimal, calming color scheme
  final ColorScheme lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF2563eb), // Calming blue
    onPrimary: Colors.white,
    secondary: Color(0xFF34a853), // Gentle green accent
    onSecondary: Colors.white,
    error: Color(0xFFB3261E),
    onError: Colors.white,
    surface: Color(0xFFF4F6F8), // Light gray
    onSurface: Color(0xFF22272A),
    surfaceContainerHighest: Color(0xFFE3E7EB), // Muted gray for cards/inputs
    onSurfaceVariant: Color(0xFF495057),
    outline: Color(0xFFB6BBC0),
  );

  final ColorScheme darkColorScheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF60A5FA), // Softer blue for dark
    onPrimary: Color(0xFF1A1C1E),
    secondary: Color(0xFF81C995), // Softer green
    onSecondary: Color(0xFF1A1C1E),
    error: Color(0xFFF2B8B5),
    onError: Color(0xFF601410),
    surface: Color(0xFF23272B), // Very dark gray
    onSurface: Color(0xFFE3E7EB),
    surfaceContainerHighest: Color(0xFF2A2D31), // Muted dark for cards/inputs
    onSurfaceVariant: Color(0xFFE3E7EB),
    outline: Color(0xFF495057),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TVTC الدعم الفني',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        fontFamily: 'Cairo', // Use a modern, readable Arabic font if available
        scaffoldBackgroundColor: lightColorScheme.surface,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: lightColorScheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: lightColorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: lightColorScheme.primary, width: 2),
          ),
          labelStyle: TextStyle(color: lightColorScheme.onSurfaceVariant),
          prefixIconColor: lightColorScheme.primary,
          suffixIconColor: lightColorScheme.primary,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: lightColorScheme.primary,
          foregroundColor: lightColorScheme.onPrimary,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: lightColorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Cairo',
          ),
        ),
        iconTheme: IconThemeData(color: lightColorScheme.primary),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: lightColorScheme.primary,
            foregroundColor: lightColorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: darkColorScheme.surface,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: darkColorScheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: darkColorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: darkColorScheme.primary, width: 2),
          ),
          labelStyle: TextStyle(color: darkColorScheme.onSurfaceVariant),
          prefixIconColor: darkColorScheme.primary,
          suffixIconColor: darkColorScheme.primary,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: darkColorScheme.primary,
          foregroundColor: darkColorScheme.onPrimary,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: darkColorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Cairo',
          ),
        ),
        iconTheme: IconThemeData(color: darkColorScheme.primary),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: darkColorScheme.primary,
            foregroundColor: darkColorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'SA'),
      ],
      locale: const Locale('ar', 'SA'),
      // This prevents the locale from being overridden by the device locale
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        // Always use Arabic (Saudi Arabia) regardless of device settings
        return const Locale('ar', 'SA');
      },
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
