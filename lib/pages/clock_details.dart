import 'package:flutter/material.dart';
import 'package:whisper_arts_tests/dataclass/clock_data.dart';
import 'package:whisper_arts_tests/pages/basket/basket_singleton.dart';

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

  String convertPrise() {
    var price = BasketSingleton().getPrice();
    if (price > 999 && price <= 999999) {
      if (price % 1000 == 0) {
        int div = price ~/ 1000;
        return div.toString() + "K";
      } else {
        double divmod = price / 1000;
        return divmod.toString() + "K";
      }
    } else if (price > 999999 && price < 999999999) {
      if (price % 1000000 == 0) {
        int div = price ~/ 1000000;
        return div.toString() + "M";
      } else {
        double divmod = price / 1000000;
        return divmod.toString() + "M";
      }
    } else if (price > 999999999) {
      if (price % 1000000000 == 0) {
        int div = price ~/ 1000000000;
        return div.toString() + "MM";
      } else {
        double divmod = price / 1000000000;
        return divmod.toString() + "MM";
      }
    } else {
      return price.toString();
    }
  }

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
        actions: [
          TextButton(
            child: Text(convertPrise()),
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
                  BasketSingleton().findIDInBasket(listClockData.id)
                      ? "В корзине"
                      : "Положить в корзину",
                  style: TextStyle(color: Colors.teal[900]),
                ),
                icon: Icon(
                    BasketSingleton().findIDInBasket(listClockData.id)
                        ? Icons.check_rounded
                        : Icons.add_shopping_cart_outlined,
                    color: Colors.teal[900]),
                onPressed: () {
                  if (BasketSingleton().findIDInBasket(listClockData.id)) {
                    BasketSingleton().delete(listClockData.id);
                  } else {
                    BasketSingleton().add(listClockData);
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
