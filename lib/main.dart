// ignore_for_file: deprecated_member_use

//import './models/transaction.dart';
import 'package:expense_manager/widgets/new_transaction.dart';
import 'package:expense_manager/widgets/transaction_list.dart';

import 'package:flutter/material.dart';

import 'models/transaction.dart';

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
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
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
  void _addNewTransaction(String txtitle, double txamount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txtitle,
        amount: txamount,
        date: DateTime.now());

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: Icon(Icons.add_sharp))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
              TransactionList(_userTransaction),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
