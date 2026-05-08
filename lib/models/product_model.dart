class StoreModel {
  final int id;
  final String name;
  final String username;

  StoreModel({required this.id, required this.name, required this.username});

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
    );
  }
}

class ProductClassModel {
  final int id;
  final String name;

  ProductClassModel({required this.id, required this.name});

  factory ProductClassModel.fromJson(Map<String, dynamic> json) {
    return ProductClassModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ProductModel {
  final int id;
  final String name;
  final double price;
  final String description;
  final String createdAt;
  final String updatedAt;
  final StoreModel store;
  final ProductClassModel classInfo;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.store,
    required this.classInfo,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      description: json['description'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      store: StoreModel.fromJson(json['store']),
      classInfo: ProductClassModel.fromJson(json['class']),
    );
  }

  String get formattedPrice {
    final parts = price.toStringAsFixed(0).split('');
    final result = StringBuffer();
    for (int i = 0; i < parts.length; i++) {
      if (i > 0 && (parts.length - i) % 3 == 0) result.write('.');
      result.write(parts[i]);
    }
    return 'Rp ${result.toString()}';
  }
}