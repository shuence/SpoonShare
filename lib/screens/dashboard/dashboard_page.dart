import 'package:flutter/material.dart';
import 'package:spoonshare/l10n/app_localization.dart';
import 'package:spoonshare/screens/ngo/ngo_form.dart';
import 'package:spoonshare/screens/volunteer/volunteer_form.dart';
import 'package:spoonshare/utils/label_keys.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: MediaQuery.of(context).padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTitle(
                  localization!.translate(LabelKey.dashboardPageSlogan)!,
                  localization.translate(LabelKey.dashboardPageSlogan2)!),
              const SizedBox(height: 32),
              _buildGradientBox(context),
              const SizedBox(height: 8),
              _buildOrText(),
              const SizedBox(height: 16),
              _buildGradientBoxNGO(context),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title1, String title2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title1,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Lora',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title2,
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: 14,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildGradientBox(BuildContext context) {
    var localization = AppLocalization.of(context)!;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VolunteerFormScreen(),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/dashboard.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16, // Adjust the right padding
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14), // Horizontal padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Align children to both ends
                children: [
                  Text(
                    localization.translate(LabelKey.joinVolunteer)!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Lora',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientBoxNGO(BuildContext context) {
    var localization = AppLocalization.of(context)!;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NGOFormScreen(),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/NGOJoin.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16, // Adjust the right padding
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14), // Horizontal padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Align children to both ends
                children: [
                  Text(
                    localization.translate(LabelKey.joinNgo)!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Lora',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrText() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 2,
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'OR',
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontSize: 18,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 2,
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
