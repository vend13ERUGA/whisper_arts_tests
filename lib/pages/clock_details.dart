import 'package:flutter/material.dart';
import 'package:whisper_arts_tests/dataclass/clock_data.dart';

class ClockDetails extends StatelessWidget {
  final Word clockData;
  const ClockDetails({Key? key, required this.clockData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        centerTitle: true,
        title: Text(
          clockData.name,
          style: TextStyle(color: Colors.grey[300]),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              // "jfhjd",
              clockData.name,
              // clockData.nameClock,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'BebasNeue',
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Colors.grey[700],
                  decoration: TextDecoration.none),
            ),
            SizedBox(
              height: 20,
            ),
            Image.network(clockData.url),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                clockData.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontFamily: 'EBGaramond',
                    fontWeight: FontWeight.w400,
                    fontSize: 25,
                    color: Colors.grey[700],
                    decoration: TextDecoration.none),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              clockData.price,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontFamily: 'Birthstone',
                  fontWeight: FontWeight.w400,
                  fontSize: 45,
                  color: Colors.teal[900],
                  decoration: TextDecoration.none),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
