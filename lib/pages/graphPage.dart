import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../model/order.dart';

class MyChartPage extends StatelessWidget {
  final List<CookieOrder> orders;

  const MyChartPage(this.orders, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    orders.forEach((element) {
      element.isSweet ? element.cookieSweet += 1 : element.cookieSalty += 1;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('My Chart Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: screenHeight * 0.8,
              width: screenWidth,
              child: charts.LineChart(
                [
                  charts.Series<CookieOrder, int>(
                    id: 'Ingredient 1',
                    colorFn: (_, __) =>
                        charts.MaterialPalette.blue.shadeDefault,
                    domainFn: (order, index) => index ?? 0,
                    measureFn: (order, _) => order.ingredient1,
                    data: orders.toList(),
                  ),
                  charts.Series<CookieOrder, int>(
                    id: 'Ingredient 2',
                    colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
                    domainFn: (order, index) => index ?? 0,
                    measureFn: (order, _) => order.ingredient2,
                    data: orders.toList(),
                  ),
                  charts.Series<CookieOrder, int>(
                    id: 'Ingredient 3',
                    colorFn: (_, __) =>
                        charts.MaterialPalette.green.shadeDefault,
                    domainFn: (order, index) => index ?? 0,
                    measureFn: (order, _) => order.ingredient3,
                    data: orders.toList(),
                  ),
                ],
                animate: true,
                defaultRenderer: charts.LineRendererConfig(includePoints: true),
                behaviors: [
                  charts.ChartTitle('Ingredients Trend',
                      behaviorPosition: charts.BehaviorPosition.top,
                      titleOutsideJustification:
                          charts.OutsideJustification.middle),
                  charts.SeriesLegend(position: charts.BehaviorPosition.bottom),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: screenHeight * 0.8,
              width: screenWidth,
              child: charts.LineChart(
                [
                  charts.Series<CookieOrder, int>(
                    id: 'Salty',
                    colorFn: (_, __) =>
                        charts.MaterialPalette.blue.shadeDefault,
                    domainFn: (order, index) => index ?? 0,
                    measureFn: (order, _) => order.cookieSalty,
                    data: orders.toList(),
                  ),
                  charts.Series<CookieOrder, int>(
                    id: 'Sweet',
                    colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
                    domainFn: (order, index) => index ?? 0,
                    measureFn: (order, _) => order.cookieSweet,
                    data: orders.toList(),
                  ),
                ],
                animate: true,
                defaultRenderer: charts.LineRendererConfig(includePoints: true),
                behaviors: [
                  charts.ChartTitle('Cookies Type Trend',
                      behaviorPosition: charts.BehaviorPosition.top,
                      titleOutsideJustification:
                          charts.OutsideJustification.middle),
                  charts.SeriesLegend(position: charts.BehaviorPosition.bottom),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  charts.Series<CookieOrder, int> _createSeries(
    Iterable<CookieOrder> orders,
    String lineName,
    String ingredient,
  ) {
    return charts.Series<CookieOrder, int>(
      id: lineName,
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (order, index) => index ?? 0,
      measureFn: (order, index) =>
          _getIngredientMeasureFn(order, index, ingredient),
      data: orders.toList(),
    );
  }

  num? _getIngredientMeasureFn(
      CookieOrder order, int? index, String ingredient) {
    switch (ingredient) {
      case 'ingredient1':
        return order.ingredient1;
      case 'ingredient2':
        return order.ingredient2;
      case 'ingredient3':
        return order.ingredient3;
      case 'sweet':
        return order.cookieSweet;
      case 'salty':
        return order.cookieSalty;
      default:
        return null;
    }
  }
}
