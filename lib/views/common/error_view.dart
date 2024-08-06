import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  final String errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ErrorText("Oops! Something went wrong."),
            ErrorText(errorMessage),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorText extends StatelessWidget {
  const ErrorText(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          height: 1.71,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
