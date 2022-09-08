import 'package:flutter/material.dart';

class SearchObject extends StatefulWidget {
  final String date;
  final String heure;
  final String intervention;

  const SearchObject(
      {Key? key,
      required this.date,
      required this.heure,
      required this.intervention})
      : super(key: key);

  @override
  State<SearchObject> createState() => _SearchObjectState();
}

class _SearchObjectState extends State<SearchObject> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.white,
          (widget.intervention == "Sans intervention")
              ? Color.fromARGB(255, 99, 7, 0)
              : Color.fromARGB(255, 0, 110, 6)
        ], stops: [
          0.95,
          1
        ])),
        height: 70,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Color(0xff00366f),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      widget.date,
                      style: const TextStyle(
                          fontFamily: 'Sfpro', color: Color(0xff00366f)),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      'à',
                      style: TextStyle(
                          fontFamily: 'Sfpro',
                          color: Color.fromARGB(255, 92, 97, 105)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      widget.heure,
                      style: const TextStyle(
                          fontFamily: 'Sfpro', color: Color(0xff00366f)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  widget.intervention,
                  style: const TextStyle(
                    fontFamily: 'Sfpro',
                    fontSize: 15,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
