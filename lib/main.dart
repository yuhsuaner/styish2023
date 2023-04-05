import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Color.fromRGBO(255, 255, 255, 1),
              )),
      title: 'Flutter App',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(241, 244, 248, 1),
        title: Image.asset('images/STYLiSH_Logo.png',
            fit: BoxFit.cover, height: 20),
        elevation: 2,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    width: 300,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://picsum.photos/250?random=$index',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '女裝',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DetailPage()),
                      );
                    },
                    child: Container(
                      height: 100,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.network(
                              'https://loremflickr.com/320/240/dog?random=${index * 2}',
                              height: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('  UNIQLO 特級極輕羽絨外套'),
                                Text('  NT\$ ${index * 80 + 1}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(241, 244, 248, 1),
        title: Image.asset('images/STYLiSH_Logo.png',
            fit: BoxFit.cover, height: 20),
        elevation: 2,
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                width: 360,
                height: 500,
                child: Image.network(
                  'https://loremflickr.com/320/240/dog?random=${index * 2}',
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              ProductDetailInfo()
            ],
          );
        },
      ),
    );
  }
}

class ProductDetailInfo extends StatelessWidget {
  const ProductDetailInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      width: 360,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(' UNIQLO 特級極輕羽絨外套',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(' 2023032101',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
        SizedBox(
          height: 18,
        ),
        Text(' NT\$ 1500',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(children: [
              Text('顏色', style: TextStyle(fontSize: 14)),
              SizedBox(
                width: 20,
              ),
              Container(width: 1, height: 16, color: Colors.grey),
              SizedBox(
                width: 12,
              ),
              Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(color: Colors.black, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 1,
                        offset: Offset(0.5, 0.5))
                  ])),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(color: Colors.deepPurple, boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 1,
                      offset: Offset(0.5, 0.5))
                ]),
              )
            ]),
            Row(children: [
              Text('尺寸', style: TextStyle(fontSize: 14)),
              SizedBox(
                width: 20,
              ),
              Container(width: 1, height: 16, color: Colors.grey),
              SizedBox(
                width: 12,
              ),
              Container(
                  width: 30,
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:
                      const Text('S', style: TextStyle(color: Colors.white))),
              Container(
                  width: 30,
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:
                      const Text('M', style: TextStyle(color: Colors.white))),
              Container(
                  width: 30,
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:
                      const Text('L', style: TextStyle(color: Colors.white))),
            ]),
          ],
        ),
        Row(children: [
          Text('數量', style: TextStyle(fontSize: 14)),
          SizedBox(
            width: 20,
          ),
          Container(width: 1, height: 16, color: Colors.grey),
          SizedBox(
            width: 12,
          ),
          Expanded(
              child: Row(children: [
            InkWell(
                onTap: () {},
                child: Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                    child: const Icon(Icons.remove, color: Colors.white))),
            SizedBox(
              width: 50,
            ),
            const Text('1', textAlign: TextAlign.center),
            SizedBox(
              width: 50,
            ),
            InkWell(
                onTap: () {},
                child: Container(
                    alignment: Alignment.center,
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                    child: const Icon(Icons.add, color: Colors.white)))
          ]))
        ]),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: ElevatedButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.brown,
            ),
            onPressed: () {},
            child: const Text(
              '請選擇尺寸',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        Text('實品顏色依單品照為主', style: TextStyle(fontSize: 14)),
        Text('棉 100%', style: TextStyle(fontSize: 14)),
        Text('厚薄：薄', style: TextStyle(fontSize: 14)),
        Text('素材產地 / 日本', style: TextStyle(fontSize: 14)),
        Text('加工產地 / 中國', style: TextStyle(fontSize: 14)),
      ]),
    );
  }
}
