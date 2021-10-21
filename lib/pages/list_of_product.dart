import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whisper_arts_tests/dataclass/clock_data.dart';
import 'package:whisper_arts_tests/dataclass/database_data.dart';
import 'package:whisper_arts_tests/pages/basket/basket_singleton.dart';
import 'package:whisper_arts_tests/pages/clock_details.dart';
import 'package:whisper_arts_tests/parser/json_parser.dart';
import 'package:whisper_arts_tests/database/database.dart';

class ListOfProduct extends StatefulWidget {
  ListOfProduct({Key? key}) : super(key: key);
  @override
  _ListOfProductState createState() => _ListOfProductState();
}

class _ListOfProductState extends State<ListOfProduct> {
  @override
  void initState() {
    setState(() {});
    super.initState();
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
                                      if (BasketSingleton().hasIDInBasket(
                                          snapshot.data![index].id)) {
                                        //delete from BasketList
                                        BasketSingleton()
                                            .delete(snapshot.data![index].id);
                                        //delete from Database
                                        BasketFavourutesDatabase.instance
                                            .delete(snapshot.data![index].id,
                                                tableBasket);
                                      } else {
                                        //add to BasketList
                                        BasketSingleton()
                                            .add(snapshot.data![index]);
                                        //add to Database
                                        BasketFavourutesDatabase.instance
                                            .create(
                                                DatabaseData(
                                                    idClock: snapshot
                                                        .data![index].id,
                                                    quantity: 1,
                                                    name: snapshot
                                                        .data![index].name,
                                                    url: snapshot
                                                        .data![index].url,
                                                    description: snapshot
                                                        .data![index]
                                                        .description,
                                                    price: snapshot
                                                        .data![index].price),
                                                tableBasket);
                                      }
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      BasketSingleton().hasIDInBasket(
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
                        setState(() {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ClockDetails(snapshot.data![index])))
                              .then((_) {
                            setState(() {});
                          });
                        });
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
            body: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: children,
            ),
          );
        });
  }
}
