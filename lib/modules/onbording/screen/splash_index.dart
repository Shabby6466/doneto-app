import 'package:doneto/core/widgets/base_widget.dart';
import 'package:flutter/material.dart';


class SplashIndex extends StatefulWidget {
  const SplashIndex({super.key});

  @override
  State<SplashIndex> createState() => _SplashIndexState();
}

class _SplashIndexState extends State<SplashIndex> {
  @override
  Widget build(BuildContext context) {
    return Background(child: Column(children: [Text('Doneto')],));
  }
}