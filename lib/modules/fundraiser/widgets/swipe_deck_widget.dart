import 'package:doneto/core/utils/resource/r.dart';
import 'package:flutter/material.dart';
import 'package:swipe_deck/swipe_deck.dart';

class SwipeDeckWidget extends StatefulWidget {
  const SwipeDeckWidget({super.key});

  @override
  State<SwipeDeckWidget> createState() => _SwipeDeckWidgetState();
}

class _SwipeDeckWidgetState extends State<SwipeDeckWidget> {
  var IMAGES = [R.assets.graphics.pngIcons.img, R.assets.graphics.pngIcons.img, R.assets.graphics.pngIcons.img];
  final borderRadius = BorderRadius.circular(20.0);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 600,
        child: Center(
          child: SwipeDeck(
            startIndex: 3,
            emptyIndicator: Container(child: Center(child: Text("Nothing Here"))),
            cardSpreadInDegrees: 5,
            // Change the Spread of Background Cards
            onSwipeLeft: () {
              print("USER SWIPED LEFT -> GOING TO NEXT WIDGET");
            },
            onSwipeRight: () {
              print("USER SWIPED RIGHT -> GOING TO PREVIOUS WIDGET");
            },
            onChange: (index) {
              print(IMAGES[index]);
            },
            widgets:
                IMAGES
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          print(e);
                        },
                        child: ClipRRect(borderRadius: borderRadius, child: Image.asset("assets/images/$e.jpg", fit: BoxFit.cover)),
                      ),
                    )
                    .toList(),
          ),
        ),
      ),
    );
  }
}
