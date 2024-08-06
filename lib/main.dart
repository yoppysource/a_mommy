import 'package:amommy/views/main_app.dart';
import 'package:amommy/views/splash/app_init_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AppInitWidget(
          onLoaded: (context) => const HomeOrProfilePage(),
        ),
      ),
    ),
  );
}
