// ignore_for_file: deprecated_member_use

import './transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatelessWidget {
  //creating an empty list of type Transaction

  final List<Transaction> transactions = [
    Transaction(
      id: 'r1',
      title: 'New Shirt',
      amount: 799.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'r2',
      title: 'New Shoes',
      amount: 4999.90,
      date: DateTime.now(),
    ),
    /*Transaction(
      id: 'r3',
      title: 'New Jeans',
      amount: 1099.00,
      date: DateTime.now(),
    ),*/
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter App'),
        ),
        body: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                width: double.infinity,
                child: const Card(
                  color: Colors.blue,
                  child: Text('Chart'),
                  elevation: 8,
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const TextField(
                        decoration: InputDecoration(labelText: 'Title'),
                      ),
                      const TextField(
                        decoration: InputDecoration(labelText: 'Amount'),
                      ),
                      FlatButton(
                          onPressed: () {},
                          child: const Text(
                            'Add Transaction',
                            style: TextStyle(color: Colors.blue),
                          ))
                    ],
                  ),
                ),
              ),
              Column(
                children: transactions.map((tx) {
                  return Card(
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.red,
                            width: 2,
                          )),
                          padding: const EdgeInsets.all(10),
                          child: Text('\u{20B9}${tx.amount}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.red)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tx.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              DateFormat.yMMMd().format(tx.date),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }).toList(),
              )
            ]));
  }
}
