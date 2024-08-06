import 'package:amommy/views/theme.dart';
import 'package:flutter/material.dart';

class SplashLoadingScreen extends StatelessWidget {
  const SplashLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: Palette.gradient2),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image.asset(
              //   Assets.logo,
              //   width: 99,
              //   height: 88,
              //   fit: BoxFit.cover,
              // ),
              // Image.asset(

              //   // Assets.logoTypo,
              //   width: 237,
              //   height: 56,
              //   fit: BoxFit.cover,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
