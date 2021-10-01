import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whisper_arts_tests/dataclass/clock_data.dart';
import 'package:whisper_arts_tests/pages/basket/basket.dart';
import 'package:whisper_arts_tests/pages/basket/basket_singleton.dart';
import 'package:whisper_arts_tests/pages/clock_details.dart';
import 'package:whisper_arts_tests/parser/json_parser.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<bool> addFavorite = [];

  int indexCount = 0;
  void changeValue(bool value) {
    setState(() {
      this.addFavorite[indexCount] = value;
    });
  }

  void deleteValue() {
    setState(() {
      for (int i = 0; i <= addFavorite.length - 1; i++) {
        this.addFavorite[i] = true;
      }
    });
  }

  void changeValue2(int indexCount2) {
    setState(() {
      int id = indexCount2;
      bool i = false;
      if (BasketSingleton().clockID.isEmpty) {
        this.addFavorite[indexCount2 - 1] = true;
      } else {
        for (var Id in BasketSingleton().clockID) {
          if (id == Id) {
            i = true;
          }
        }
        if (i) {
          this.addFavorite[indexCount2 - 1] = false;
        } else {
          this.addFavorite[indexCount2 - 1] = true;
        }
      }
    });
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
                                      setState(() {
                                        if (addFavorite.isEmpty) {
                                          for (int i = 1;
                                              i <= snapshot.data!.length;
                                              i++) {
                                            addFavorite.add(true);
                                          }
                                        }
                                        addFavorite[index] =
                                            !addFavorite[index];
                                      });
                                      addFavorite[index]
                                          ? BasketSingleton().deleteID(
                                              snapshot.data![index].id)
                                          : BasketSingleton()
                                              .addID(snapshot.data![index].id);
                                      // changeBasketIcon();
                                    },
                                    icon: Icon(
                                      addFavorite.isEmpty
                                          ? Icons.add_box_outlined
                                          : addFavorite[index]
                                              ? Icons.add_box_outlined
                                              : Icons.add_box_rounded,
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
                        if (addFavorite.isEmpty) {
                          for (int i = 1; i <= snapshot.data!.length; i++) {
                            addFavorite.add(true);
                          }
                        }
                        indexCount = index;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Container(
                                child: ClockDetails(changeValue,
                                    snapshot.data![index], addFavorite[index]),
                                width: 200,
                                height: 200,
                                color: Colors.red);
                          }),
                        );
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
                IconButton(
                  padding: EdgeInsets.only(right: 30),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            Basket(changeValue2, deleteValue)));
                  },
                  icon: Container(
                    child: Icon(
                      BasketSingleton().clockID.isEmpty
                          ? Icons.shopping_basket_outlined
                          : Icons.shopping_basket_rounded,
                      size: 40,
                    ),
                  ),
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
