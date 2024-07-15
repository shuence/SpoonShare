import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spoonshare/l10n/app_localization.dart';
import 'package:spoonshare/screens/donate/donate_food.dart';
import 'package:spoonshare/screens/donate/share_food.dart';
import 'package:spoonshare/screens/donate/share_water.dart';
import 'package:spoonshare/screens/home/home.dart';
import 'package:spoonshare/utils/label_keys.dart';

class DonatePage extends StatelessWidget {
  const DonatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 300,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1.5, color: const Color(0x23FF9300)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      shape: const CircleBorder(),
                      color: Colors.red,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                          );
                        },
                      ),
                    ),
                  ),
                   Text(
                    localization.translate(LabelKey.donatePageOption)!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DonationButton(
                    buttonText: localization.translate(LabelKey.donateFood)!,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DonateFoodScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildOrText(),
                  const SizedBox(height: 10),
                  DonationButton(
                    buttonText: localization.translate(LabelKey.shareFreeFood)!,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShareFoodScreen()),
                      );
                    },
                  ),
                  _buildOrText(),
                  const SizedBox(height: 10),
                  DonationButton(
                    buttonText: localization.translate(LabelKey.shareWater)!,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShareWaterScreen()),
                      );
                    },
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
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
              fontSize: 14,
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
        ],
      ),
    );
  }
}

class DonationButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const DonationButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF9300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
