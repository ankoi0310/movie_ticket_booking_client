import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class NotFoundScreen extends StatefulWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  State<NotFoundScreen> createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends State<NotFoundScreen> {
  late RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RiveAnimation.asset(
          'assets/rive/404.riv',
          fit: BoxFit.cover,
          controllers: [_controller],
        ),
      ),
    );
  }
}