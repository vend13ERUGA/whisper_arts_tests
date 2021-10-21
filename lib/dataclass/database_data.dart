final String tableBasket = 'basket';
final String tableFavourites = 'favourites';

class databaseFields {
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

class DatabaseData {
  final int? id;
  final int idClock;
  int quantity;
  final String name;
  final String url;
  final String description;
  final String price;

  DatabaseData(
      {this.id,
      required this.idClock,
      required this.quantity,
      required this.name,
      required this.url,
      required this.description,
      required this.price});

  DatabaseData copy(
          {int? id,
          int? idClock,
          int? quantity,
          String? name,
          String? url,
          String? description,
          String? price}) =>
      DatabaseData(
          id: id ?? this.id,
          idClock: idClock ?? this.idClock,
          quantity: quantity ?? this.quantity,
          name: name ?? this.name,
          url: url ?? this.url,
          description: description ?? this.description,
          price: price ?? this.price);

  static DatabaseData fromJson(Map<String, Object?> json) => DatabaseData(
      id: json[databaseFields.id] as int?,
      idClock: json[databaseFields.idClock] as int,
      quantity: json[databaseFields.quantity] as int,
      name: json[databaseFields.name] as String,
      url: json[databaseFields.url] as String,
      description: json[databaseFields.description] as String,
      price: json[databaseFields.price] as String);

  Map<String, Object?> toJson() => {
        databaseFields.id: id,
        databaseFields.idClock: idClock,
        databaseFields.quantity: quantity,
        databaseFields.name: name,
        databaseFields.url: url,
        databaseFields.description: description,
        databaseFields.price: price
      };
}
