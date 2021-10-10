import 'package:flutter/material.dart';
import 'package:whisper_arts_tests/pages/basket/basket_singleton.dart';

class Basket extends StatefulWidget {
  Basket();

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  _BasketState();

  double getScreenHeightExcludeSafeArea(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double finalHeight = height - padding.top - padding.bottom;
    return finalHeight * 0.7;
  }

  double getWidth(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return width * 0.9;
  }

  @override
  Widget build(BuildContext context) {
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
        child: Container(
          color: Colors.teal[900],
          child: Column(
            children: [
              Container(
                color: Colors.white,
                // height: 600,
                height: getScreenHeightExcludeSafeArea(context),
                child: ListView.builder(
                    itemCount: BasketSingleton().getBasketList().length,
                    itemBuilder: (BuildContext context, int index) {
                      var basketList =
                          BasketSingleton().getBasketList().toList();
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
                                    image: NetworkImage(basketList[index].url),
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
                                          basketList[index].name,
                                          style: TextStyle(
                                            fontFamily: 'BebasNeue',
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            backgroundColor: Colors.transparent,
                                            color: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                basketList[index].price,
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
                                        .delete(basketList[index].id);
                                    // BasketSingleton()
                                    //     .deleteID(snapshot.data![index].id);
                                    // changeValue2(snapshot.data![index].id);
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
                                    // BasketSingleton().addID(snapshot.data![index]);
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
                BasketSingleton().getPrice().toString(),
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
                    // deleteValue();
                    // Navigator.pop(context, "jhjjhj");
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              content: Text('Покупка совершена'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
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
        ),
      ),
    );

    //   Container(
    //     color: Colors.teal[900],
    //     child: Column(
    //       children: [
    //         Container(
    //           color: Colors.white,
    //           height: 600,
    //           // height: getScreenHeightExcludeSafeArea(context),
    //           child: ListView.builder(
    //               // itemCount: BasketSingleton().tttrrr().length,
    //               itemCount: 4,
    //               itemBuilder: (BuildContext context, int index) {
    //                 return Column(
    //                   children: [
    //                     Container(
    //                       height: 100,
    //                       // decoration: BoxDecoration(
    //                       //     border: Border.all(
    //                       //       color: Colors.teal.shade900,
    //                       //       width: 4,
    //                       //     ),
    //                       //     image: DecorationImage(
    //                       //         image: NetworkImage(BasketSingleton().tttrrr()),
    //                       //         fit: BoxFit.cover)),
    //                       child: GestureDetector(
    //                         child: Card(
    //                             borderOnForeground: false,
    //                             color: Colors.transparent,
    //                             child: Column(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 // ListTile(
    //                                 //   title: Text(
    //                                 //     snapshot.data![index].name,
    //                                 //     style: TextStyle(
    //                                 //       fontFamily: 'BebasNeue',
    //                                 //       fontSize: 25,
    //                                 //       fontWeight: FontWeight.bold,
    //                                 //       backgroundColor: Colors.transparent,
    //                                 //       color: Colors.grey[300],
    //                                 //     ),
    //                                 //   ),
    //                                 // ),
    //                               ],
    //                             )),
    //                       ),
    //                     ),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                       children: [
    //                         // Text(
    //                         //   BasketSingleton().tttt().first,
    //                         //   textAlign: TextAlign.right,
    //                         //   style: TextStyle(
    //                         //     fontSize: 19,
    //                         //     fontFamily: 'EBGaramond',
    //                         //     fontWeight: FontWeight.w400,
    //                         //   ),
    //                         // ),
    //                         SizedBox(
    //                           width: 15,
    //                         ),
    //                         IconButton(
    //                           padding: EdgeInsets.only(right: 30),
    //                           onPressed: () {
    //                             setState(() {
    //                               // BasketSingleton()
    //                               //     .deleteID(snapshot.data![index].id);
    //                               // changeValue2(snapshot.data![index].id);
    //                             });
    //                           },
    //                           icon: Container(
    //                             child: Icon(Icons.delete),
    //                           ),
    //                         ),
    //                         IconButton(
    //                           padding: EdgeInsets.only(right: 30),
    //                           onPressed: () {
    //                             setState(() {
    //                               // BasketSingleton().addID(snapshot.data![index]);
    //                             });
    //                           },
    //                           icon: Container(
    //                             child: Icon(Icons.plus_one),
    //                           ),
    //                         ),
    //                       ],
    //                     )
    //                   ],
    //                 );
    //               }),
    //         ),
    //         // Text(
    //         //   // fullPrice(snapshot.data!),
    //         //   style: TextStyle(
    //         //     fontSize: 30,
    //         //     fontFamily: 'EBGaramond',
    //         //     fontWeight: FontWeight.w400,
    //         //     color: Colors.white,
    //         //   ),
    //         // ),
    //         ElevatedButton(
    //           style: ElevatedButton.styleFrom(
    //             primary: Colors.white, // background
    //             onPrimary: Colors.white, // foreground
    //           ),
    //           onPressed: () {
    //             setState(() {
    //               BasketSingleton().deleteAll();
    //               // deleteValue();

    //               showDialog<String>(
    //                   context: context,
    //                   builder: (BuildContext context) => AlertDialog(
    //                         content: Text('Покупка совершена'),
    //                         actions: <Widget>[
    //                           TextButton(
    //                             onPressed: () => Navigator.pop(context, 'OK'),
    //                             child: const Text('OK'),
    //                           ),
    //                         ],
    //                       ));
    //             });
    //           },
    //           child: Text(
    //             'Купить',
    //             style: TextStyle(color: Colors.teal[900]),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
  }
}
  // {
  //   return FutureBuilder<List<ClockData>>(
  //       future: loadJSON(BasketSingleton().ttt()),
  //       builder:
  //           (BuildContext context, AsyncSnapshot<List<ClockData>> snapshot) {
  //         Widget children;
  //         if (snapshot.hasData) {
  //           children =
  //           Container(
  //             color: Colors.teal[900],
  //             child: Column(
  //               children: [
  //                 Container(
  //                   color: Colors.white,
  //                   height: 600,
  //                   // height: getScreenHeightExcludeSafeArea(context),
  //                   child: ListView.builder(
  //                       itemCount: snapshot.data!.length,
  //                       itemBuilder: (BuildContext context, int index) {
  //                         return Column(
  //                           children: [
  //                             Container(
  //                               height: 100,
  //                               decoration: BoxDecoration(
  //                                   border: Border.all(
  //                                     color: Colors.teal.shade900,
  //                                     width: 4,
  //                                   ),
  //                                   image: DecorationImage(
  //                                       image: NetworkImage(
  //                                           snapshot.data![index].url),
  //                                       fit: BoxFit.cover)),
  //                               child: GestureDetector(
  //                                 child: Card(
  //                                     borderOnForeground: false,
  //                                     color: Colors.transparent,
  //                                     child: Column(
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.spaceBetween,
  //                                       children: [
  //                                         ListTile(
  //                                           title: Text(
  //                                             snapshot.data![index].name,
  //                                             style: TextStyle(
  //                                               fontFamily: 'BebasNeue',
  //                                               fontSize: 25,
  //                                               fontWeight: FontWeight.bold,
  //                                               backgroundColor:
  //                                                   Colors.transparent,
  //                                               color: Colors.grey[300],
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     )),
  //                               ),
  //                             ),
  //                             Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceAround,
  //                               children: [
  //                                 Text(
  //                                   snapshot.data![index].price + " руб",
  //                                   textAlign: TextAlign.right,
  //                                   style: TextStyle(
  //                                     fontSize: 19,
  //                                     fontFamily: 'EBGaramond',
  //                                     fontWeight: FontWeight.w400,
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   width: 15,
  //                                 ),
  //                                 IconButton(
  //                                   padding: EdgeInsets.only(right: 30),
  //                                   onPressed: () {
  //                                     setState(() {
  //                                       BasketSingleton()
  //                                           .deleteID(snapshot.data![index].id);
  //                                       // changeValue2(snapshot.data![index].id);
  //                                     });
  //                                   },
  //                                   icon: Container(
  //                                     child: Icon(Icons.delete),
  //                                   ),
  //                                 ),
  //                                 IconButton(
  //                                   padding: EdgeInsets.only(right: 30),
  //                                   onPressed: () {
  //                                     setState(() {
  //                                       BasketSingleton()
  //                                           .addID(snapshot.data![index]);
  //                                     });
  //                                   },
  //                                   icon: Container(
  //                                     child: Icon(Icons.plus_one),
  //                                   ),
  //                                 ),
  //                               ],
  //                             )
  //                           ],
  //                         );
  //                       }),
  //                 ),
  //                 // Text(
  //                 //   // fullPrice(snapshot.data!),
  //                 //   style: TextStyle(
  //                 //     fontSize: 30,
  //                 //     fontFamily: 'EBGaramond',
  //                 //     fontWeight: FontWeight.w400,
  //                 //     color: Colors.white,
  //                 //   ),
  //                 // ),
  //                 ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     primary: Colors.white, // background
  //                     onPrimary: Colors.white, // foreground
  //                   ),
  //                   onPressed: () {
  //                     setState(() {
  //                       BasketSingleton().deleteAll();
  //                       // deleteValue();

  //                       showDialog<String>(
  //                           context: context,
  //                           builder: (BuildContext context) => AlertDialog(
  //                                 content: Text('Покупка совершена'),
  //                                 actions: <Widget>[
  //                                   TextButton(
  //                                     onPressed: () =>
  //                                         Navigator.pop(context, 'OK'),
  //                                     child: const Text('OK'),
  //                                   ),
  //                                 ],
  //                               ));
  //                     });
  //                   },
  //                   child: Text(
  //                     'Купить',
  //                     style: TextStyle(color: Colors.teal[900]),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         } else if (snapshot.hasError) {
  //           children = SizedBox(
  //             child: Center(
  //                 child: Text(
  //               "ERROR",
  //               style: TextStyle(
  //                   color: Colors.teal[900],
  //                   fontFamily: 'BebasNeue',
  //                   fontSize: 26),
  //             )),
  //           );
  //         } else {
  //           children = SizedBox(
  //             child: Center(
  //               child: CircularProgressIndicator(
  //                 color: Colors.teal[900],
  //               ),
  //             ),
  //           );
  //         }
  //         return Scaffold(
  //           appBar: AppBar(
  //             centerTitle: true,
  //             backgroundColor: Colors.teal[900],
  //             title: Text(
  //               'КОРЗИНА',
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ),
  //           body: MediaQuery.removePadding(
  //             context: context,
  //             removeTop: true,
  //             child: children,
  //           ),
  //         );
  //       });
  // }

