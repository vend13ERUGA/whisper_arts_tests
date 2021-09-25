import 'package:flutter/material.dart';
import 'package:whisper_arts_tests/dataclass/clockData.dart';

class ClockDetails extends StatelessWidget {
  final ClockData clockData;
  const ClockDetails({Key? key, required this.clockData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ROLEX',
          style: TextStyle(color: Colors.grey[300]),
        ),
        backgroundColor: Colors.grey[700],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              clockData.nameClock,
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
            Image.network(clockData.imageUrl),
            SizedBox(
              height: 20,
            ),
            Text(
              clockData.descriptionClock,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontFamily: 'EBGaramond',
                  fontWeight: FontWeight.w400,
                  fontSize: 25,
                  color: Colors.grey[700],
                  decoration: TextDecoration.none),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              clockData.priceClock,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontFamily: 'Birthstone',
                  fontWeight: FontWeight.w400,
                  fontSize: 45,
                  color: Colors.grey[500],
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
