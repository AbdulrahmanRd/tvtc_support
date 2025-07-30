import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  String _status = '';
  String _name = '';
  String _role = '';
  bool _isLoading = false;

  Future<void> login() async {
    setState(() {
      _isLoading = true;
      _status = '';
      _name = '';
      _role = '';
    });

    final url = Uri.parse('http://192.168.1.100/adapi/login.aspx'); // CHANGE IP

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': _username.text.trim(),
        'password': _password.text.trim(),
      }),
    );

    setState(() => _isLoading = false);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json['success'] == true) {
        setState(() {
          _status = json['message'];
          _name = json['name'];
          _role = json['role'];
        });
      } else {
        setState(() {
          _status = json['message'];
        });
      }
    } else {
      setState(() {
        _status = 'خطأ في الاتصال بالسيرفر (${response.statusCode})';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تسجيل الدخول')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _username,
              decoration: const InputDecoration(labelText: 'اسم المستخدم'),
            ),
            TextField(
              controller: _password,
              decoration: const InputDecoration(labelText: 'كلمة المرور'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : login,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('تسجيل الدخول'),
            ),
            const SizedBox(height: 20),
            if (_status.isNotEmpty) Text(_status, style: const TextStyle(fontSize: 16)),
            if (_name.isNotEmpty) Text('مرحباً $_name'),
            if (_role.isNotEmpty) Text('الدور: $_role'),
          ],
        ),
      ),
    );
  }
}
