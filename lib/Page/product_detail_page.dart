import 'package:flutter/material.dart';
import 'package:stylish2023/Constants/colors.dart';

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
        backgroundColor: icBackgroundColor,
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
