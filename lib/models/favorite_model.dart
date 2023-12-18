class FavoriteModel {
  String? status;
  List<Productf>? products;

  FavoriteModel({this.products});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['favoriteProducts'] != null) {
      products = <Productf>[];
      json['favoriteProducts'].forEach((v) {
        products!.add(Productf.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (products != null) {
      data['favoriteProducts'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productf {
  String? sId;
  String? status;
  String? category;
  String? name;
  dynamic price;
  String? description;
  String? image;
  List<String>? images;
  String? company;
  int? countInStock;
  int? iV;
  int? sales;
  bool? isFavorite;

  Productf(
      {this.sId,
      this.status,
      this.category,
      this.name,
      this.price,
      this.description,
      this.image,
      this.images,
      this.company,
      this.countInStock,
      this.iV,
      this.sales,
      this.isFavorite});

  Productf.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    category = json['category'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    images = json['images'].cast<String>();
    company = json['company'];
    countInStock = json['countInStock'];
    iV = json['__v'];
    sales = json['sales'];
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['status'] = status;
    data['category'] = category;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['image'] = image;
    data['images'] = images;
    data['company'] = company;
    // data['countInStock'] = countInStock;
    data['__v'] = iV;
    data['sales'] = sales;
    data['isFavorite'] = isFavorite;
    return data;
  }
}
