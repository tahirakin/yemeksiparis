class DishList {
  final int dish_id;
  final String name;
  // Diğer özellikler...

  DishList({
    required this.dish_id,
    required this.name,
    // Diğer özelliklerin değişkenleri...
  });

  factory DishList.fromJson(Map<String, dynamic> json) {
    // JSON'dan Dish nesnesi oluşturma logic'i...
    return DishList(
      dish_id: json['dish_id'],
      name: json['name'],
      // Diğer özelliklerin değişkenleri...
    );
  }

  // Varsayılan yemek (default dish) örneği
  static DishList get defaultDish => DishList(
    dish_id: -1,
    name: 'Default Dish',
    // Diğer özelliklerin değişkenleri...
  );

  get length => null;

  getIndex(int index) {}
}
