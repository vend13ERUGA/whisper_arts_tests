class ClockData {
  final int id;
  final String name;
  final String url;
  final String description;
  final String price;
  ClockData(this.id, this.name, this.url, this.description, this.price);
}

class ClockQuantity {
  final ClockData clockData;
  int quantity;
  ClockQuantity(this.clockData, this.quantity);
}
