import 'package:amommy/views/common/error_view.dart';
import 'package:amommy/views/splash/app_init.dart';
import 'package:amommy/views/splash/splash_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Widget class to manage asynchronous app initialization
class AppInitWidget extends ConsumerWidget {
  const AppInitWidget({super.key, required this.onLoaded});
  final WidgetBuilder onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appInitProvider);
    return appStartupState.when(
      data: (_) => onLoaded(context),
      loading: () => const SplashLoadingScreen(),
      error: (e, st) => ErrorView(
        errorMessage: e.toString(),
        onRetry: () => ref.invalidate(appInitProvider),
      ),
    );
  }
}
