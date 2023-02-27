import 'package:flutter/material.dart';

import '../model/order.dart';

class OrderSummaryPage extends StatelessWidget {
  final List<CookieOrder> orders;

  const OrderSummaryPage({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate total number of ingredients
    double totalIngredient1 = 0;
    double totalIngredient2 = 0;
    double totalIngredient3 = 0;

    // Count sweet and salty cookies
    int sweetCount = 0;
    int saltyCount = 0;

    for (final order in orders) {
      totalIngredient1 += order.ingredient1;
      totalIngredient2 += order.ingredient2;
      totalIngredient3 += order.ingredient3;

      if (order.isSweet) {
        sweetCount++;
      } else {
        saltyCount++;
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Resumo de pedidos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total de ingredientes',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    Text('Ingredient 1: $totalIngredient1 kg'),
                    Text('Ingredient 2: $totalIngredient2 kg'),
                    Text('Ingredient 3: $totalIngredient3 kg'),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total de biscoitos',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    Text('Recheado: $sweetCount'),
                    Text('Salgado: $saltyCount'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
