class OrdersModel {
  int id;
  String title;
  double price;
  String image;
  int quantity;

  OrdersModel({
    this.id = 0,
    this.title = '',
    this.price = 0.0,
    this.image = '',
    this.quantity = 0,
  });
}
