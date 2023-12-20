class LaptopsModel {
  String? status;
  String? message;
  List<Product>? product;
  List<Product>? newProducts;
  List<Product>? usedProducts;

  LaptopsModel({this.status, this.message, this.product}) {
    categorizeProductsByStatus();
  }

  LaptopsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
      categorizeProductsByStatus();
    }
  }

  void categorizeProductsByStatus() {
    newProducts = [];
    usedProducts = [];

    product?.forEach((product) {
      if (product.status == "New") {
        newProducts?.add(product);
      } else if (product.status == "Used") {
        usedProducts?.add(product);
      }
    });
  }
}


//   Map<String, List<Product>> categorizeProductsByStatus() {
//     Map<String, List<Product>> categorizedProducts = {};
    
//     product?.forEach((product) {
//       String productStatus = product.status ?? "Unknown";
      
//       if (!categorizedProducts.containsKey(productStatus)) {
//         categorizedProducts[productStatus] = [];
//       }

//       categorizedProducts[productStatus]?.add(product);
//     });

//     return categorizedProducts;
//   }
// }

class Product {
  String? sId;
  String? status;
  String? category;
  String? name;
  dynamic price;
  String? description;
  String? image;
  String? company;
  dynamic countInStock;
  List<String>? images;
  dynamic iV;
  bool? isFavorite;

  Product(
      {this.sId,
      this.status,
      this.category,
      this.name,
      this.price,
      this.description,
      this.image,
      this.company,
      this.countInStock,
      this.iV,
      this.isFavorite});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    category = json['category'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    company = json['company'];
    images = json['images'].cast<String>();
    countInStock = json['countInStock'];
    iV = json['__v'];
    isFavorite = json['isFavorite'];
  }
}

