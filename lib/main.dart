import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookie_orders_service/pages/order_summary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'model/order.dart';

import 'pages/graphPage.dart';
import 'pages/login_page.dart';
import 'pages/report_page.dart';
import 'widgets/my_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    home: LoginPage(),
  ));
}

class MyApp extends StatefulWidget {
  final UserCredential userCredential;

  const MyApp({
    Key? key,
    required this.userCredential,
  }) : super(key: key);

  static const String _title = 'Cookie Factory Client';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String report = '';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int lastId = 0;
  final List<CookieOrder> _orders = [];
  @override
  void initState() {
    //quando é iniciado o App
    super.initState();
    getOrders();
    //count();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp._title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade600,
        appBar: AppBar(
          title: const Text(MyApp._title),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('orders').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Problemas de conexão com firestore!');
                  }

                  //getOrders();

                  return const SizedBox(
                    width: 0,
                    height: 0,
                  );
                },
              ),
              Expanded(
                  flex: 4,
                  child: MyForm(
                    userCredentialEmail:
                        widget.userCredential.user?.email ?? '',
                    onOrderAdded: _handleNewOrder,
                  )),
              SizedBox(
                width: 308,
                height: 30,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Text('Relatório'),
                  onPressed: () async {
                    getOrders();
                    await printReport(context);
                    // showAlertDialog(context);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 150,
                      height: 30,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        child: const Text('Sumário Produção'),
                        onPressed: () async {
                          getOrders();
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderSummaryPage(orders: _orders),
                            ),
                          );
                          // showAlertDialog(context);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 30,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: const Text('Gráficos'),
                      onPressed: () async {
                        getOrders();
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyChartPage(_orders),
                          ),
                        );
                        // showAlertDialog(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleNewOrder(CookieOrder order) async {
    addOrUpdateOrder(order);
    sendOrderToServer(order);
    setState(() {});
  }

  Future<void> printReport(BuildContext context) async {
    getOrders();
    num orderTime = 0.0;
    num totalTimeForAllOrders = 0.0;
    num totalIngredient1 = 0.0;
    num totalIngredient2 = 0.0;
    num totalIngredient3 = 0.0;
    String orderName = '';
    String user = '';
    _orders.forEach((element) {
      orderName = 'Pedido ${element.id}';
      orderTime = element.totalTime;
      totalTimeForAllOrders += element.totalTime;
      totalIngredient1 = element.ingredient1;
      totalIngredient2 = element.ingredient2;
      totalIngredient3 = element.ingredient3;
      user = element.userEmail;
      report +=
          "${orderName}; ${element.isSweet ? 'Recheado' : 'Salgado'};  ${totalIngredient1} kg ;  ${totalIngredient2} kg ; ${totalIngredient3} kg ; ${orderTime} s ; ${user}; \n";
    });

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportPage(report: report),
      ),
    );
  }

  Future<void> getOrders() async {
    await firestore.collection("orders").get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        final orderData = doc.data();
        final order = CookieOrder.fromJson(orderData);
        addOrUpdateOrder(order);
      });
    });
  }

  void addOrUpdateOrder(CookieOrder order) {
    int index = _orders.indexWhere((o) => o.id == order.id);
    if (index == -1) {
      // If order with same id does not exist, add to list
      _orders.add(order);
    } else {
      // If order with same id exists, update existing order
      _orders[index] = order;
    }
  }

  Future<void> sendOrderToServer(CookieOrder order) async {
    await firestore
        .collection('orders')
        .doc(order.id.toString())
        .set(order.toJson());
  }

  showGraphs(BuildContext context) {}
}
