import 'package:flutter/material.dart';

class HomepageItem extends StatefulWidget {
  final String title;
  HomepageItem({Key? key, required this.title}) : super(key: key);

  @override
  State<HomepageItem> createState() => _HomepageItemState();
}

class _HomepageItemState extends State<HomepageItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: TextStyle(fontFamily: 'Sfpro'),),
      ),
      body: Center(
        child: Text('This is the body of the page!!'),
      ),
    );
  }
}
