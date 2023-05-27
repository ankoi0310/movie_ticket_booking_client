import 'package:flutter/material.dart';

class UnauthorizedScreen extends StatefulWidget {
  const UnauthorizedScreen({Key? key}) : super(key: key);

  @override
  State<UnauthorizedScreen> createState() => _UnauthorizedScreenState();
}

class _UnauthorizedScreenState extends State<UnauthorizedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Unauthorized',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
