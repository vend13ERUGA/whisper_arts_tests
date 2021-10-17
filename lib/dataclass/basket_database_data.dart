final String tableBasket = 'basket';

class BasketFields {
  static final List<String> values = [
    id,
    idClock,
    quantity,
    name,
    url,
    description,
    price
  ];

  static final String id = '_id';
  static final String idClock = 'idClock';
  static String quantity = 'quantity';
  static final String name = 'name';
  static final String url = 'url';
  static final String description = 'description';
  static final String price = 'price';
}

class BasketData {
  final int? id;
  final int idClock;
  int quantity;
  final String name;
  final String url;
  final String description;
  final String price;

  BasketData(
      {this.id,
      required this.idClock,
      required this.quantity,
      required this.name,
      required this.url,
      required this.description,
      required this.price});

  BasketData copy(
          {int? id,
          int? idClock,
          int? quantity,
          String? name,
          String? url,
          String? description,
          String? price}) =>
      BasketData(
          id: id ?? this.id,
          idClock: idClock ?? this.idClock,
          quantity: quantity ?? this.quantity,
          name: name ?? this.name,
          url: url ?? this.url,
          description: description ?? this.description,
          price: price ?? this.price);

  static BasketData fromJson(Map<String, Object?> json) => BasketData(
      id: json[BasketFields.id] as int?,
      idClock: json[BasketFields.idClock] as int,
      quantity: json[BasketFields.quantity] as int,
      name: json[BasketFields.name] as String,
      url: json[BasketFields.url] as String,
      description: json[BasketFields.description] as String,
      price: json[BasketFields.price] as String);

  Map<String, Object?> toJson() => {
        BasketFields.id: id,
        BasketFields.idClock: idClock,
        BasketFields.quantity: quantity,
        BasketFields.name: name,
        BasketFields.url: url,
        BasketFields.description: description,
        BasketFields.price: price
      };
}
