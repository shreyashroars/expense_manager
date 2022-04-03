import 'package:expense_manager/models/transaction.dart';
import 'package:flutter/material.dart';

import './new_transaction.dart';
import './transaction_list.dart';

// ignore: use_key_in_widget_constructors
class UserTransaction extends StatefulWidget {
  //const UserTransaction({ Key? key }) : super(key: key);

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //New Transaction contains the textField i.e the new Transaction to be added
        NewTransaction(_addNewTransaction),
        //TransactionList contains the list of transactions
        TransactionList(_userTransaction),
      ],
    );
  }
}
