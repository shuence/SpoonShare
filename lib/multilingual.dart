import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spoonshare/main.dart';
import 'package:spoonshare/screens/home/home.dart';
import 'package:spoonshare/services/change_notifier.dart';

class MultilingualScreen extends StatelessWidget {
  const MultilingualScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Language")
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _changeLanguage(context, const Locale('en', 'US'));
              },
              child: const Text('English'),
            ),
            ElevatedButton(
              onPressed: () {
                _changeLanguage(context, const Locale('mr', 'MR'));
              },
              child: const Text('Marathi'),
            ),
            ElevatedButton(
              onPressed: () {
                _changeLanguage(context, const Locale('hi', 'HI'));
              },
              child: const Text('Hindi'),
            ),
            ElevatedButton(
              onPressed: () {
                _changeLanguage(context, const Locale('ka', 'KA'));
              },
              child: const Text('Kannada'),
            ),
          ],
        ),
      ),
    );
  }

  void _changeLanguage(BuildContext context, Locale locale) {
    final provider = Provider.of<LanguageProvider>(context, listen: false);
    provider.changeLanguage(locale);
    navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }
}
