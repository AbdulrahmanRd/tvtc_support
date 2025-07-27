import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _baseUrl = 'YOUR_BACKEND_URL'; // Replace with your backend URL that will handle the LDAP authentication
  static const String _authTokenKey = 'auth_token';
  static const String _usernameKey = 'username';
  
  // Active Directory configuration
  static const String _ldapServer = '172.16.16.12';
  static const String _ldapPath = 'DC=mctvt,DC=edu,DC=sa';
  static const String _domain = 'mctvt.edu.sa';
  
  // SharedPreferences instance
  static late final SharedPreferences _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Login method
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      // In a real app, you would make an HTTP request to your backend
      // For now, we'll simulate a successful login
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate successful login
      final token = 'simulated_token_${DateTime.now().millisecondsSinceEpoch}';
      
      // Store the auth token and username
      await _prefs.setString(_authTokenKey, token);
      await _prefs.setString(_usernameKey, username);
      
      return {
        'success': true,
        'user': {
          'username': username,
          'name': 'User', // You would get this from your backend
          'email': '$username@mctvt.edu.sa',
        },
        'token': token,
      };
      
      // Uncomment this in production to use the real API
      /*
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'ldapServer': _ldapServer,
          'ldapPath': _ldapPath,
          'domain': _domain,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['token'] != null) {
          await _prefs.setString(_authTokenKey, data['token']);
          await _prefs.setString(_usernameKey, username);
        }
        return {'success': true, 'user': data};
      } else {
        return {
          'success': false,
          'message': 'فشل تسجيل الدخول. الرجاء التأكد من اسم المستخدم وكلمة المرور',
        };
      }
      */
    } catch (e) {
      return {
        'success': false,
        'message': 'حدث خطأ في الاتصال بالخادم. الرجاء المحاولة مرة أخرى لاحقاً',
      };
    }
  }

  // Check if user is logged in
  bool get isLoggedIn {
    return _prefs.getString(_authTokenKey) != null;
  }

  // Get auth token
  String? get token => _prefs.getString(_authTokenKey);

  // Get stored username
  String? get username => _prefs.getString(_usernameKey);

  // Logout
  Future<void> logout() async {
    await _prefs.remove(_authTokenKey);
    await _prefs.remove(_usernameKey);
  }
}
