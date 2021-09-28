import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whisper_arts_tests/dataclass/clock_data.dart';
import 'package:whisper_arts_tests/pages/clock_details.dart';
import 'package:whisper_arts_tests/parser/json_parser.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Clock>(
        future: loadJSON(),
        builder: (BuildContext context, AsyncSnapshot<Clock> snapshot) {
          Widget chidren;
          if (snapshot.hasData) {
            chidren = GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data!.words.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.teal.shade900,
                            width: 4,
                          ),
                          image: DecorationImage(
                              image:
                                  NetworkImage(snapshot.data!.words[index].url),
                              fit: BoxFit.cover)),
                      child: GestureDetector(
                        child: Card(
                            borderOnForeground: false,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ListTile(
                                  title: Text(
                                    snapshot.data!.words[index].name,
                                    style: TextStyle(
                                      fontFamily: 'BebasNeue',
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.transparent,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ),
                                Text(
                                  snapshot.data!.words[index].price,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Birthstone',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor: Colors.transparent,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            )),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ClockDetails(
                                  clockData: snapshot.data!.words[index])));
                        },
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            chidren = SizedBox(
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
            chidren = SizedBox(
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
            ),
            body: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: chidren,
            ),
          );
        });
  }
}
