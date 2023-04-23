class HotsProductData {
  final String title;
  final List<Product> products;

  HotsProductData({required this.title, required this.products});

  factory HotsProductData.fromJson(Map<String, dynamic> json) {
    List<dynamic> productListJson = json['products'];
    List<Product> productList =
        productListJson.map((product) => Product.fromJson(product)).toList();
    return HotsProductData(title: json['title'], products: productList);
  }
}

class Product {
  final int id;
  final String category;
  final String title;
  final String description;
  final int price;
  final String texture;
  final String wash;
  final String place;
  final String note;
  final String story;
  final List<Color> colors;
  final List<String> sizes;
  final List<Variant> variants;
  final String mainImage;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.price,
    required this.texture,
    required this.wash,
    required this.place,
    required this.note,
    required this.story,
    required this.colors,
    required this.sizes,
    required this.variants,
    required this.mainImage,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final List<Color> colors =
        List.from(json['colors']).map((e) => Color.fromJson(e)).toList();
    final List<Variant> variants =
        List.from(json['variants']).map((e) => Variant.fromJson(e)).toList();

    return Product(
      id: json['id'],
      category: json['category'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      texture: json['texture'],
      wash: json['wash'],
      place: json['place'],
      note: json['note'],
      story: json['story'],
      colors: colors,
      sizes: json['sizes'].cast<String>(),
      variants: variants,
      mainImage: json['main_image'],
      images: json['images'].cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['texture'] = texture;
    data['wash'] = wash;
    data['place'] = place;
    data['note'] = note;
    data['story'] = story;
    data['colors'] = colors.map((e) => e.toJson()).toList();
    data['sizes'] = sizes;
    data['variants'] = variants.map((e) => e.toJson()).toList();
    data['main_image'] = mainImage;
    data['images'] = images;
    return data;
  }
}

class Color {
  final String code;
  final String name;

  Color(this.code, this.name);

  Color.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
      };
}

class Variant {
  final String colorCode;
  final String size;
  final int stock;

  Variant(this.colorCode, this.size, this.stock);

  Variant.fromJson(Map<String, dynamic> json)
      : colorCode = json['color_code'],
        size = json['size'],
        stock = json['stock'];

  Map<String, dynamic> toJson() => {
        'color_code': colorCode,
        'size': size,
        'stock': stock,
      };
}
