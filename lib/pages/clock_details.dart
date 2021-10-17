import 'package:flutter/material.dart';
import 'package:whisper_arts_tests/dataclass/clock_data.dart';
import 'package:whisper_arts_tests/pages/basket/basket_singleton.dart';
import 'package:whisper_arts_tests/pages/basket/database/basket_database.dart';
import 'package:whisper_arts_tests/dataclass/basket_database_data.dart';

class ClockDetails extends StatefulWidget {
  ClockData listClockData;

  ClockDetails(this.listClockData);

  @override
  _ClockDetailsState createState() => _ClockDetailsState(listClockData);
}

class _ClockDetailsState extends State<ClockDetails> {
  @override
  ClockData listClockData;

  _ClockDetailsState(this.listClockData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        centerTitle: true,
        title: Text(
          listClockData.name,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            child: Text(
              BasketSingleton().convertPrise(),
              style: TextStyle(
                  color: Colors.yellowAccent,
                  fontSize: 25,
                  fontFamily: "BebasNeue"),
            ),
            onPressed: () {
              setState(() {
                Navigator.pushNamed(context, '/basket').then((_) {
                  setState(() {});
                });
              });
            },
          ),
        ],
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
                  BasketSingleton().hasIDInBasket(listClockData.id)
                      ? "В корзине"
                      : "Положить в корзину",
                  style: TextStyle(color: Colors.teal[900]),
                ),
                icon: Icon(
                    BasketSingleton().hasIDInBasket(listClockData.id)
                        ? Icons.check_rounded
                        : Icons.add_shopping_cart_outlined,
                    color: Colors.teal[900]),
                onPressed: () {
                  if (BasketSingleton().hasIDInBasket(listClockData.id)) {
                    BasketSingleton().delete(listClockData.id);
                    BasketDatabase.instance.delete(listClockData.id);
                  } else {
                    BasketSingleton().add(listClockData);
                    BasketDatabase.instance.create(BasketData(
                        idClock: listClockData.id,
                        quantity: 1,
                        name: listClockData.name,
                        url: listClockData.url,
                        description: listClockData.description,
                        price: listClockData.price));
                  }
                  setState(() {});
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
