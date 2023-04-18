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
    required this.category,
    required this.title,
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
    List<Color> colorsList = (json['colors'] as List<dynamic>)
        .map((e) => Color.fromJson(e))
        .toList();

    List<Variant> variantsList = (json['variants'] as List<dynamic>)
        .map((e) => Variant.fromJson(e))
        .toList();

    return Product(
      id: json['id'] as int,
      category: json['category'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      texture: json['texture'] as String,
      wash: json['wash'] as String,
      place: json['place'] as String,
      note: json['note'] as String,
      story: json['story'] as String,
      colors: colorsList,
      sizes: (json['sizes'] as List<dynamic>).map((e) => e as String).toList(),
      variants: variantsList,
      mainImage: json['main_image'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }
}

class Color {
  final String code;
  final String name;

  Color({required this.code, required this.name});

  factory Color.fromJson(Map<String, dynamic> json) {
    return Color(
      code: json['code'] as String,
      name: json['name'] as String,
    );
  }
}

class Variant {
  final String colorCode;
  final String size;
  final int stock;

  Variant({required this.colorCode, required this.size, required this.stock});

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      colorCode: json['color_code'] as String,
      size: json['size'] as String,
      stock: json['stock'] as int,
    );
  }
}
