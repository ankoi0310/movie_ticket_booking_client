import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/general.dart';

enum ProductType {
  food("FOOD"),
  drink("DRINK"),
  item("ITEM");

  final String value;

  const ProductType(this.value);

  factory ProductType.fromValue(String value) {
    return ProductType.values.firstWhere((element) => element.value == value);
  }
}

class Product extends General {
  String? name;
  int price;
  ProductType productType;
  String image;
  int stock;

  Product({
    required int id,
    required this.name,
    required this.price,
    required this.productType,
    required this.image,
    required this.stock,
    required GeneralState state,
    required DateTime createdDate,
    required DateTime modifiedDate,
    required DateTime? deletedDate,
  }) : super(id: id, state: state, createdDate: createdDate, modifiedDate: modifiedDate, deletedDate: deletedDate);

  Product.empty()
      : name = null,
        price = 0,
        productType = ProductType.food,
        image = "",
        stock = 0,
        super.empty();

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      productType: ProductType.fromValue(json['productType']),
      image: json['image'],
      stock: json['stock'],
      state: GeneralState.fromValue(json['state']),
      createdDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['createdDate']),
      modifiedDate:
      DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['modifiedDate']),
      deletedDate: json['deletedDate'] != null
          ? DateTime.parse(json['deletedDate'])
          : null,
    );

  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'productType': productType.value,
      'image': image,
      'stock': stock,
      'state': state.value,
      'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
      'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
      'deletedDate': deletedDate != null
          ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!)
          : null,
    };
  }

}
