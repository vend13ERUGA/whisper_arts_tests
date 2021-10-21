import 'package:flutter/material.dart';
import 'package:whisper_arts_tests/pages/favourites/favourites.dart';
import 'package:whisper_arts_tests/pages/list_of_product.dart';
import 'package:whisper_arts_tests/database/database.dart';
import 'package:whisper_arts_tests/pages/favourites/favourites_singleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:whisper_arts_tests/dataclass/clock_data.dart';
import 'package:whisper_arts_tests/dataclass/database_data.dart';
import 'package:whisper_arts_tests/pages/basket/basket_singleton.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  Widget _ListOfProduct = SizedBox(
    child: Center(
      child: CircularProgressIndicator(
        color: Colors.teal[900],
      ),
    ),
  );
  Widget _ListFavourites = SizedBox(
    child: Center(
      child: CircularProgressIndicator(
        color: Colors.teal[900],
      ),
    ),
  );
  Future loadInDatabase() async {
    final basket = await BasketFavourutesDatabase.instance.readAll(tableBasket);
    if (BasketSingleton().isEmpty()) {
      for (var init in basket) {
        ClockData clockData = ClockData(
            init.idClock, init.name, init.url, init.description, init.price);
        ClockQuantity clockQuantity = ClockQuantity(clockData, init.quantity);
        BasketSingleton().addAll(clockQuantity);
      }
    }
    final favourites =
        await BasketFavourutesDatabase.instance.readAll(tableFavourites);
    if (FavouritesSingleton().isEmpty()) {
      for (var init in favourites) {
        ClockData clockData = ClockData(
            init.idClock, init.name, init.url, init.description, init.price);
        ClockQuantity clockQuantity = ClockQuantity(clockData, init.quantity);
        FavouritesSingleton().addAll(clockQuantity);
      }
    }
    _ListOfProduct = ListOfProduct();
    _ListFavourites = Favourites();
    setState(() {});
  }

  Future initDB() async {
    await BasketFavourutesDatabase.instance.initDB('basket.db');
    loadInDatabase();
  }

  void initState() {
    initDB();
    super.initState();
  }

  void dispose() {
    BasketFavourutesDatabase.instance.close();
    super.dispose();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.getBody(),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.amber,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.teal[900],
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Все товары"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text("Избранное"),
          ),
        ],
        onTap: (int index) {
          this.onTapHandler(index);
        },
      ),
    );
  }

  Widget getBody() {
    if (this.selectedIndex == 0) {
      return this._ListOfProduct;
    } else {
      return this._ListFavourites;
    }
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }
}
