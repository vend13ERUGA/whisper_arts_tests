import 'package:flutter/material.dart';
import 'package:whisper_arts_tests/pages/basket/basket_singleton.dart';
import 'package:whisper_arts_tests/pages/basket/database/basket_database.dart';
import 'package:whisper_arts_tests/dataclass/basket_database_data.dart';

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

  Future incrementQuantity(int idClock) async {
    late BasketData basket;
    basket = await BasketDatabase.instance.readBasket(idClock);
    BasketDatabase.instance.incrementQuantity(basket);
    print(basket.quantity);
  }

  Future decrementQuantity(int idClock) async {
    late BasketData basket;
    basket = await BasketDatabase.instance.readBasket(idClock);
    BasketDatabase.instance.decrementQuantity(basket);
    print(basket.quantity);
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
                                basketList[index].price + " ₽",
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
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        BasketSingleton().incrementQuantity(
                                            basketList[index].id);
                                        incrementQuantity(basketList[index].id);
                                      });
                                    },
                                    child: Text("+",
                                        style:
                                            TextStyle(color: Colors.teal[900])),
                                  ),
                                  Text(BasketSingleton()
                                      .getQuantity(basketList[index].id)),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        BasketSingleton().decrementQuantity(
                                            basketList[index].id);
                                        decrementQuantity(basketList[index].id);
                                      });
                                    },
                                    child: Text(
                                      "-",
                                      style: TextStyle(color: Colors.teal[900]),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                padding: EdgeInsets.only(right: 30),
                                onPressed: () {
                                  setState(() {
                                    BasketSingleton()
                                        .delete(basketList[index].id);
                                    BasketDatabase.instance
                                        .delete(basketList[index].id);
                                  });
                                },
                                icon: Container(
                                  child: Icon(Icons.delete),
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
                  BasketDatabase.instance.deleteAll();
                  setState(() {
                    BasketSingleton().deleteAll();
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              content: Text('Покупка совершена'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, 'OK');
                                    BasketDatabase.instance.init();
                                  },
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
  }
}
