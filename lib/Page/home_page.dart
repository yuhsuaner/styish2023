import 'package:flutter/material.dart';
import 'package:stylish2023/Constants/colors.dart';
import 'package:stylish2023/Page/product_detail_page.dart';
import 'package:stylish2023/Data/product_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> allProducts = [];
  List<Product> _womenItems = [];
  List<Product> _menItems = [];
  List<Product> _accessoriesItems = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      Dio dio = Dio();

      List<String> endpoints = [
        'https://api.appworks-school.tw/api/1.0/products/women',
        'https://api.appworks-school.tw/api/1.0/products/men',
        'https://api.appworks-school.tw/api/1.0/products/accessories',
      ];

      for (String endpoint in endpoints) {
        Response response = await dio.get(endpoint);
        List<Product> products = List<Product>.from(
            response.data['data'].map((product) => Product.fromJson(product)));
        allProducts.addAll(products);
      }

      _womenItems = allProducts
          .where((product) => product.category == 'women')
          .map((product) => _productToCatalogItem(product))
          .toList();

      _menItems = allProducts
          .where((product) => product.category == 'men')
          .map((product) => _productToCatalogItem(product))
          .toList();

      _accessoriesItems = allProducts
          .where((product) => product.category == 'accessories')
          .map((product) => _productToCatalogItem(product))
          .toList();
    } catch (e) {
      print(e);
    }
  }

  Product _productToCatalogItem(Product product) {
    return Product(
        id: product.id,
        category: product.category,
        title: product.title,
        description: product.description,
        price: product.price,
        texture: product.texture,
        wash: product.wash,
        place: product.place,
        note: product.note,
        story: product.story,
        mainImage: product.mainImage,
        images: product.images,
        variants: product.variants,
        colors: product.colors,
        sizes: product.sizes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: icBackgroundColor,
        title: Image.asset('images/STYLiSH_Logo.png',
            fit: BoxFit.cover, height: 20),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // pressed shopping cart
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: allProducts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: CachedNetworkImage(
                    imageUrl: allProducts[index].images[index],
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          // Catalog Items for women, men and accessories
          ..._buildCatalogSection('女裝', _womenItems),
          ..._buildCatalogSection('男裝', _menItems),
          ..._buildCatalogSection('配件', _accessoriesItems),
        ],
      ),
    );
  }

  List<Widget> _buildCatalogSection(String title, List<Product> items) {
    return [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      SizedBox(height: 10),
      Column(
        children: items.map((item) => _buildCatalogItem(item)).toList(),
      ),
    ];
  }

  Widget _buildCatalogItem(Product item) {
    return InkWell(
      onTap: () {
        // pressed DetailPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(catalogItem: item),
          ),
        );
      },
      child: Container(
        height: 110,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: item.mainImage,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'NT\$ ${item.price}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
