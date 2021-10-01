import 'package:flutter/material.dart';
import 'package:whisper_arts_tests/dataclass/clock_data.dart';
import 'package:whisper_arts_tests/pages/basket/basket_singleton.dart';

class ClockDetails extends StatefulWidget {
  void Function(bool) changeValue;
  ClockData listClockData;
  bool clockState;

  ClockDetails(this.changeValue, this.listClockData, this.clockState);

  @override
  _ClockDetailsState createState() =>
      _ClockDetailsState(changeValue, listClockData, clockState);
}

class _ClockDetailsState extends State<ClockDetails> {
  @override
  void Function(bool) changeValue;
  ClockData listClockData;
  bool clockState;
  _ClockDetailsState(this.changeValue, this.listClockData, this.clockState);

  String ttt = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        centerTitle: true,
        title: Text(
          listClockData.name,
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
              listClockData.name,
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
            Image.network(listClockData.url),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                listClockData.description,
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
              listClockData.price,
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
            FloatingActionButton.extended(
                backgroundColor: Colors.yellow,
                label: Text(
                  clockState ? "Положить в корзину" : "В корзине",
                  style: TextStyle(color: Colors.teal[900]),
                ),
                icon: Icon(
                    clockState
                        ? Icons.add_shopping_cart_outlined
                        : Icons.check_rounded,
                    color: Colors.teal[900]),
                onPressed: () {
                  setState(() {
                    clockState = !clockState;
                    if (clockState) {
                      BasketSingleton().deleteID(listClockData.id);
                    } else {
                      BasketSingleton().addID(listClockData.id);
                    }
                  });
                  changeValue(clockState);
                }),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
