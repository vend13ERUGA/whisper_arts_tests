import 'package:flutter/material.dart';
import 'package:whisper_arts_tests/dataclass/clock_data.dart';
import 'package:whisper_arts_tests/pages/favourites/favourites_singleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:whisper_arts_tests/dataclass/database_data.dart';
import 'package:whisper_arts_tests/database/database.dart';
import 'package:whisper_arts_tests/pages/clock_details.dart';

class Favourites extends StatefulWidget {
  Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "ИЗБРАННОЕ",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal[900],
      ),
      body: ListView.builder(
          itemCount: FavouritesSingleton().getFavouritesList().length,
          itemBuilder: (BuildContext context, int index) {
            var favouritesList =
                FavouritesSingleton().getFavouritesList().toList();
            return Dismissible(
              key: Key(favouritesList[index].id.toString()),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.teal.shade900,
                      width: 4,
                    ),
                    image: DecorationImage(
                        image: NetworkImage(favouritesList[index].url),
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
                              favouritesList[index].name,
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
                  onTap: () {
                    ClockData clockData = ClockData(
                        favouritesList[index].id,
                        favouritesList[index].name,
                        favouritesList[index].url,
                        favouritesList[index].description,
                        favouritesList[index].price);
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ClockDetails(clockData))).then((_) {
                        setState(() {});
                      });
                    });
                  },
                ),
              ),
              onDismissed: (direction) {
                FavouritesSingleton().delete(favouritesList[index].id);
                BasketFavourutesDatabase.instance
                    .delete(favouritesList[index].id, tableFavourites);
              },
            );
          }),
    );
  }
}
