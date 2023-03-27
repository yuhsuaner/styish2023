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
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(241, 244, 248, 1),
          title: Image.asset('images/STYLiSH_Logo.png',
              fit: BoxFit.contain, height: 20),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 220,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            'https://picsum.photos/250?random=$index',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 2),
                      ],
                    ),
                  );
                },
              ),
            ),
            Text(
              '女裝',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
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
