import 'package:amommy/views/theme.dart';
import 'package:flutter/material.dart';

class SplashLoadingScreen extends StatelessWidget {
  const SplashLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: Palette.gradient2),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/icon.png",
                width: 99,
                height: 88,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
