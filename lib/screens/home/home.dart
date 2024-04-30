import 'package:flutter/material.dart';
import 'package:spoonshare/models/users/user.dart';
import 'package:spoonshare/onboarding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spoonshare/screens/main_bottom_nav/main_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProfile userProfile = UserProfile();

    return FutureBuilder<void>(
      future: userProfile.loadUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!userProfile.isAuthenticated()) {
            Future.delayed(Duration.zero, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Onboarding()),
              );
            });
          }

          String name = userProfile.getFullName();
          String role = userProfile.getRole();

          return userProfile.isAuthenticated()
              ? Center(
                  child: MainBottomNav(name: name, role: role),
                )
              : Container();
        } else {
          _requestLocationPermissions(context);
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xffFF9F1C),
              ),
            ),
          );
        }
      },
    );
  }

  // Function to request location permissions
  Future<void> _requestLocationPermissions(BuildContext context) async {
    PermissionStatus permissionStatus = await Permission.location.request();
    if (permissionStatus.isDenied) {
      // Handle case where user denies location permissions
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Location Permission Required'),
            content: const Text(
              'This app requires access to your location in order to function properly.',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => openAppSettings(),
                child: const Text('Settings'),
              ),
            ],
          );
        },
      );
    }
  }
}
