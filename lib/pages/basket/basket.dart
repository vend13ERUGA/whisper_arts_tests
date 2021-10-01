import 'package:flutter/material.dart';
import 'package:whisper_arts_tests/pages/basket/basket_singleton.dart';
import 'package:whisper_arts_tests/dataclass/clock_data.dart';
import 'package:whisper_arts_tests/parser/json_parser.dart';

class Basket extends StatefulWidget {
  void Function(int) changeValue2;
  void Function() deleteValue;
  Basket(this.changeValue2, this.deleteValue);

  @override
  _BasketState createState() => _BasketState(changeValue2, deleteValue);
}

class _BasketState extends State<Basket> {
  void Function(int) changeValue2;
  void Function() deleteValue;
  _BasketState(this.changeValue2, this.deleteValue);
  List<int>? shoppingList = BasketSingleton().clockID;

  double getScreenHeightExcludeSafeArea(BuildContext context) {
    int lenghtShoppingList = shoppingList!.length;
    final double height = MediaQuery.of(context).size.height;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double finalHeight = height - padding.top - padding.bottom;
    if (lenghtShoppingList == 1) {
      return finalHeight * 0.3;
    } else if (lenghtShoppingList == 2) {
      return finalHeight * 0.5;
    } else if (lenghtShoppingList == 3) {
      return finalHeight * 0.65;
    } else {
      return finalHeight * 0.75;
    }
  }

  double getWidth(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return width * 0.9;
  }

  String fullPrice(List<ClockData> snapshot) {
    int result = 0;
    int ttt = shoppingList!.length;
    print(ttt);
    if (shoppingList!.isEmpty) {
      return "";
    } else {
      for (var idInShoddingList in shoppingList!) {
        for (var idInSnapshot in snapshot) {
          if (idInSnapshot.id == idInShoddingList) {
            result = result + int.parse(idInSnapshot.price);
          }
        }
      }
      return "Итог: " + result.toString() + " ₽";
    }
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<ClockData>>(
        future: loadJSON(shoppingList),
        builder:
            (BuildContext context, AsyncSnapshot<List<ClockData>> snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children = Container(
              color: Colors.teal[900],
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    height: getScreenHeightExcludeSafeArea(context),
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                height: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.teal.shade900,
                                      width: 4,
                                    ),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            snapshot.data![index].url),
                                        fit: BoxFit.cover)),
                                child: GestureDetector(
                                  child: Card(
                                      borderOnForeground: false,
                                      color: Colors.transparent,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ListTile(
                                            title: Text(
                                              snapshot.data![index].name,
                                              style: TextStyle(
                                                fontFamily: 'BebasNeue',
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                backgroundColor:
                                                    Colors.transparent,
                                                color: Colors.grey[300],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    snapshot.data![index].price + " руб",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontFamily: 'EBGaramond',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.only(right: 30),
                                    onPressed: () {
                                      setState(() {
                                        BasketSingleton()
                                            .deleteID(snapshot.data![index].id);
                                        changeValue2(snapshot.data![index].id);
                                      });
                                    },
                                    icon: Container(
                                      child: Icon(Icons.delete),
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.only(right: 30),
                                    onPressed: () {
                                      setState(() {
                                        BasketSingleton()
                                            .addID(snapshot.data![index].id);
                                      });
                                    },
                                    icon: Container(
                                      child: Icon(Icons.plus_one),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        }),
                  ),
                  Text(
                    fullPrice(snapshot.data!),
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'EBGaramond',
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      setState(() {
                        BasketSingleton().deleteAll();
                        deleteValue();

                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  content: Text('Покупка совершена'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                      });
                    },
                    child: Text(
                      'Купить',
                      style: TextStyle(color: Colors.teal[900]),
                    ),
                  ),
                ],
              ),
            );
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
                'КОРЗИНА',
                style: TextStyle(color: Colors.white),
              ),
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
