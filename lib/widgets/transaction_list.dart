// ignore_for_file: deprecated_member_use

import 'package:expense_manager/providers/trnsactionprovider.dart';
import 'package:expense_manager/services.dart';
import 'package:expense_manager/widgets/transactionItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart';
import '../models/transactionModel.dart';

class TransactionList extends StatefulWidget {
  // final List<Transaction> transactions;
  // final Function deltx;
  // TransactionList(this.transactions, this.deltx);
  TransactionList();
  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  bool isloading = true;
  List<TransactionModel> transaction;
  @override
  void initState() {
    // getData();
    super.initState();
  }

  getData() async {
    GetTransaction gt = GetTransaction();
    await gt.gettx();
    transaction = gt.tx;
    Provider.of<TransactionProvider>(context, listen: false).addtx(gt.tx);
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Consumer<TransactionProvider>(builder: (context, provider, child) {
      return provider.tx == null || provider.tx.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions  added yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 10),
                Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemCount: provider.tx.length,
              itemBuilder: (context, index) => TransactionItem1(
                    amount: provider.tx[index].amount,
                    date: provider.tx[index].date,
                    title: provider.tx[index].title,
                  ));
    });
  }
}
