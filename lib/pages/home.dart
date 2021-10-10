import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whisper_arts_tests/dataclass/clock_data.dart';
import 'package:whisper_arts_tests/pages/basket/basket_singleton.dart';
import 'package:whisper_arts_tests/pages/clock_details.dart';
import 'package:whisper_arts_tests/parser/json_parser.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
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
    return FutureBuilder<List<ClockData>>(
        future: loadJSON(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ClockData>> snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children = GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: (0.7),
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.teal.shade900,
                        width: 4,
                      ),
                      image: DecorationImage(
                          image: NetworkImage(snapshot.data![index].url),
                          fit: BoxFit.cover),
                    ),
                    child: GestureDetector(
                      child: Card(
                          borderOnForeground: false,
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ListTile(
                                title: Text(
                                  snapshot.data![index].name,
                                  style: TextStyle(
                                    fontFamily: 'BebasNeue',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor: Colors.transparent,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![index].price,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: 'Birthstone',
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.transparent,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    padding:
                                        EdgeInsets.only(bottom: 35, right: 35),
                                    onPressed: () {
                                      if (BasketSingleton().findIDInBasket(
                                          snapshot.data![index].id)) {
                                        BasketSingleton()
                                            .delete(snapshot.data![index].id);
                                      } else {
                                        BasketSingleton()
                                            .add(snapshot.data![index]);
                                      }
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      BasketSingleton().findIDInBasket(
                                              snapshot.data![index].id)
                                          ? Icons.add_box_rounded
                                          : Icons.add_box_outlined,
                                      color: Colors.white,
                                      size: 60.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0,
                                  ),
                                ],
                              ),
                            ],
                          )),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ClockDetails(snapshot.data![index])));
                      },
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            children = SizedBox(
              child: Center(
                  child: Text(
                "ERROR",
                style: TextStyle(
                    color: Colors.teal[900],
                    fontFamily: 'BebasNeue',
                    fontSize: 26),
              )),
            );
          } else {
            children = SizedBox(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.teal[900],
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.teal[900],
              title: Text(
                'ROLEX',
                style: TextStyle(color: Colors.white),
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
            body: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: children,
            ),
          );
        });
  }
}
