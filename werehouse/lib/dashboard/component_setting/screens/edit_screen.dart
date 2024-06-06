import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:werehouse/shared/global.dart';

enum ContentType {
  success,
  error,
}

class AwesomeSnackbarContent extends StatelessWidget {
  final String title;
  final String message;
  final ContentType contentType;

  const AwesomeSnackbarContent({
    Key? key,
    required this.title,
    required this.message,
    required this.contentType,
  }) : super(key: key);

  Color get _backgroundColor {
    switch (contentType) {
      case ContentType.success:
        return Colors.green;
      case ContentType.error:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  IconData get _iconData {
    switch (contentType) {
      case ContentType.success:
        return Icons.check_circle;
      case ContentType.error:
        return Icons.error;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(
            _iconData,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({Key? key}) : super(key: key);

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  String? name;
  String? email;
  String? oldPassword;
  String? token;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('userName');
      email = prefs.getString('userEmail');
      oldPassword = prefs.getString('userPassword');
      token = prefs.getString('token');
      _nameController.text = name ?? '';
      _emailController.text = email ?? '';
    });
  }

  Future<void> saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _nameController.text);
    await prefs.setString('userEmail', _emailController.text);
    if (token != null) {
      await prefs.setString('token', token!);
    }
  }

  Future<void> updatePassword(String currentPassword, String newPassword,
      String confirmPassword, String token) async {
    final url = Uri.parse('${Global.baseUrl}${Global.updatePasswordPath}');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'current_password': currentPassword,
        'password': newPassword,
        'password_confirmation': confirmPassword,
      }),
    );

    if (response.statusCode == 200) {
      _showSnackBar(context, 'Password berhasil diperbarui.', ContentType.success);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userPassword', newPassword);

      _passwordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    } else {
      _showSnackBar(context, 'Gagal memperbarui password ', ContentType.error);
      //_showSnackBar(context, 'Gagal memperbarui password ${response.body}', ContentType.error);
    }
  }

  void _showSnackBar(BuildContext context, String message, ContentType type) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: type == ContentType.success ? 'Sukses' : 'Error',
        message: message,
        contentType: type,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Akun'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Account",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/avatar.png"),
            ),
            const SizedBox(height: 40),
            EditItem(
              title: "Nama",
              widget: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan nama',
                ),
              ),
            ),
            const SizedBox(height: 20),
            EditItem(
              title: "Email",
              widget: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan email',
                ),
              ),
            ),
            const SizedBox(height: 20),
            EditItem(
              title: "Password Saat Ini",
              widget: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan password saat ini',
                ),
              ),
            ),
            const SizedBox(height: 20),
            EditItem(
              title: "Password Baru",
              widget: TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan password baru',
                ),
              ),
            ),
            const SizedBox(height: 20),
            EditItem(
              title: "Konfirmasi Password Baru",
              widget: TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Konfirmasi password baru',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_newPasswordController.text !=
                    _confirmPasswordController.text) {
                  _showSnackBar(context, 'Password baru dan konfirmasi password tidak cocok.', ContentType.error);
                  return;
                }
                await saveUserData();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? savedToken = prefs.getString('token');
                if (savedToken != null) {
                  updatePassword(
                      _passwordController.text,
                      _newPasswordController.text,
                      _confirmPasswordController.text,
                      savedToken);
                } else {
                  _showSnackBar(context, 'Token tidak tersedia.', ContentType.error);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
              ),
              child: Text(
                'Simpan',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditItem extends StatelessWidget {
  final String title;
  final Widget widget;

  const EditItem({Key? key, required this.title, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        widget,
      ],
    );
  }
}
