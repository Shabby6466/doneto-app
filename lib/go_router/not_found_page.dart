import 'package:flutter/material.dart';

// this widget is use to show UI when an unknown routes is push on router
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No Page Found'),
    );
  }
}
