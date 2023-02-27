import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  final String report;

  const ReportPage({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rows = report.split('\n').map((row) {
      final cells = row.split(';');
      return DataRow(cells: [
        DataCell(cells.length > 0
            ? Text(cells[0],
                style: TextStyle(fontSize: 10, color: Colors.white))
            : Text('')),
        DataCell(cells.length > 1
            ? Text(cells[1],
                style: TextStyle(fontSize: 10, color: Colors.white))
            : Text('')),
        DataCell(cells.length > 2
            ? Text(cells[2],
                style: TextStyle(fontSize: 10, color: Colors.white))
            : Text('')),
        DataCell(cells.length > 3
            ? Text(cells[3],
                style: TextStyle(fontSize: 10, color: Colors.white))
            : Text('')),
        DataCell(cells.length > 4
            ? Text(cells[4],
                style: TextStyle(fontSize: 10, color: Colors.white))
            : Text('')),
        DataCell(cells.length > 5
            ? Text(cells[5],
                style: TextStyle(fontSize: 10, color: Colors.white))
            : Text('')),
        DataCell(cells.length > 6
            ? Text(cells[6],
                style: TextStyle(fontSize: 10, color: Colors.white))
            : Text('')),
      ]);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Relatório de pedidos'),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            border: TableBorder.all(color: Colors.white),
            headingRowColor: MaterialStateProperty.all(Colors.grey.shade800),
            columns: const [
              DataColumn(
                  label: Text(
                'Pedido',
                style: TextStyle(fontSize: 10, color: Colors.white),
              )),
              DataColumn(
                  label: Text('Tipo de pedido',
                      style: TextStyle(fontSize: 10, color: Colors.white))),
              DataColumn(
                  label: Text('Qtde Ingrediente 1',
                      style: TextStyle(fontSize: 10, color: Colors.white))),
              DataColumn(
                  label: Text('Qtde Ingrediente 2',
                      style: TextStyle(fontSize: 10, color: Colors.white))),
              DataColumn(
                  label: Text('Qtde Ingrediente 3',
                      style: TextStyle(fontSize: 10, color: Colors.white))),
              DataColumn(
                  label: Text('Tempo do pedido',
                      style: TextStyle(fontSize: 10, color: Colors.white))),
              DataColumn(
                  label: Text('Usuário',
                      style: TextStyle(fontSize: 10, color: Colors.white))),
            ],
            rows: rows,
          ),
        ),
      ),
    );
  }
}
