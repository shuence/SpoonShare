import 'package:flutter/material.dart';
import 'package:spoonshare/screens/auth/forgot_password.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:spoonshare/constants/app_colors.dart';
import 'package:spoonshare/services/auth.dart';

class SettingPage extends StatelessWidget {
  final AuthService authService = AuthService();

  SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
        ),
        backgroundColor: const Color(0xFFFF9F1C),
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'DM Sans',
            fontSize: 18,
            fontWeight: FontWeight.w700),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () async {
                final url = Uri.parse('mailto:spoonshare7@gmail.com');
                await launchUrl(url);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text('Privacy Policy'),
                onTap: () async {
                  final url = Uri.parse(
                      'https://www.termsfeed.com/live/6c1ed152-889a-47e8-bd6b-0d6012626d40');
                  await launchUrl(url);
                }),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.report),
                title: const Text('Report Problem'),
                onTap: () async {
                  final url = Uri.parse('https://forms.gle/RegtZGpSot3w4GxA9');
                  await launchUrl(url);
                }),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Log out'),
              onTap: () {
                authService.signOut(context);
              },
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Version 1.3.0',
                style: TextStyle(
                  color: AppColors.kBlackColor,
                  fontSize: 16,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                  height: 0,
                  letterSpacing: 1.68,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '© 2024 Spoonshare',
                style: TextStyle(
                  color: AppColors.kBlackColor,
                  fontSize: 16,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                  height: 0,
                  letterSpacing: 1.68,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
