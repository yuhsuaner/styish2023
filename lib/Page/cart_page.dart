import 'package:flutter/material.dart';
import 'package:stylish2023/resources/tappay-repository.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Test'),
              ElevatedButton(
                onPressed: () => _getPrimeAndShowAlert(context),
                child: const Text('Get Prime'),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> _getPrimeAndShowAlert(BuildContext context) async {
    try {
      String prime = await Tappay.getPrime(
        cardNumber: "4111111111111111",
        dueMonth: "01",
        dueYear: "24",
        ccv: "123",
      );
      // ignore: use_build_context_synchronously
      showAlert(context, prime);
    } catch (e) {
      showAlert(context, e.toString());
    }
  }

  void showAlert(BuildContext context, String title) {
    AlertDialog dialog = AlertDialog(title: Text(title));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}
