import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gas_leak_safety/models/slide.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SlideItem extends StatelessWidget {
  final int index;
  const SlideItem(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: 200,
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(slideList[index].imageUrl),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(
              height: 18,
            ),
            GradientText(
              colors:[Color(0xff00366f),Color(0xffd51b33)],
              slideList[index].title,
              style: const TextStyle(
                fontSize: 22,
                //color: Color(0xff41436a),
                fontFamily: 'Sfpro',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                slideList[index].description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Sfpro',
                  color: Color.fromARGB(255, 42, 58, 66)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
