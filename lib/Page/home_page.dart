import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish2023/Constants/colors.dart';
import 'package:stylish2023/Page/product_detail_page.dart';
import 'package:stylish2023/Data/product_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:stylish2023/bloc/product_data_bloc.dart';
import 'package:stylish2023/resources/api-repository.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required ApiRepository apiRepository})
      : _apiRepository = apiRepository,
        super(key: key);

  final ApiRepository _apiRepository;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ProductDataBloc(widget._apiRepository)..add(GetProductEvent()),
          ),
        ],
        child: Scaffold(
            appBar: buildAppBar(),
            body: BlocBuilder<ProductDataBloc, ProductDataState>(
              builder: (context, state) {
                if (state is ProductDataLoaded) {
                  List<Product> womenItems = state.women;
                  List<Product> menItems = state.men;
                  List<Product> accessoriesItems = state.accessories;
                  List<HotsProductData> marketingHotsItems =
                      state.marketingHots;
                  return ListView(
                    children: [
                      buildBannerSlider(marketingHotsItems),
                      ..._buildCatalogSection('女裝', womenItems),
                      ..._buildCatalogSection('男裝', menItems),
                      ..._buildCatalogSection('配件', accessoriesItems),
                    ],
                  );
                } else if (state is ProductDataLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductDataError) {
                  return Center(child: Text('Failed to load products'));
                } else {
                  return Container();
                }
              },
            )));
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: icBackgroundColor,
      title:
          Image.asset('images/STYLiSH_Logo.png', fit: BoxFit.cover, height: 20),
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            // pressed shopping cart
          },
        ),
      ],
    );
  }

  Widget buildBannerSlider(List<HotsProductData> items) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          HotsProductData hotsProductData = items[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: hotsProductData.products[index].mainImage,
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ],
            ),
          );
        },
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
        children: items.map((item) => CatalogItem(item: item)).toList(),
      ),
    ];
  }
}

class CatalogItem extends StatelessWidget {
  final Product item;

  const CatalogItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
