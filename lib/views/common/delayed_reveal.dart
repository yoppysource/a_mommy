import 'dart:async';

import 'package:flutter/material.dart';

class DelayedReveal extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const DelayedReveal({
    super.key,
    required this.child,
    required this.delay,
  });

  @override
  State<DelayedReveal> createState() => _DelayedRevealState();
}

class _DelayedRevealState extends State<DelayedReveal> with SingleTickerProviderStateMixin {
  late Timer _timer;
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _timer = Timer(widget.delay, _controller.forward);
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        if (child == null) return const Offstage();
        return Opacity(
          opacity: _animation.value,
          child: Transform.translate(
            offset: Offset(0.0, (1 - _animation.value) * 20.0),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
