// ignore_for_file: deprecated_member_use
import 'dart:convert';

import 'package:http/http.dart' as http;
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

  void deleteTrans(String id, BuildContext context) async {
    try {
      var url = Uri.parse(
          'https://backend-for-expense-manager-9cr1efa81-shreyashroars.vercel.app/transaction/$id');
      var response = await http.delete(url);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Transaction deleted')));
      debugPrint(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
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
                const SizedBox(height: 30),
                Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 251, 215, 107),
                      radius: 90,
                      child: Image.asset(
                        'assets/images/waitingg.gif',
                        fit: BoxFit.cover,
                      ),
                    )),
              ],
            )
          : ListView.builder(
              itemCount: provider.tx.length,
              itemBuilder: (context, index) {
                final trans = provider.tx[index];
                return Dismissible(
                  key: ValueKey(trans.id),
                  background: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.98,
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  onDismissed: (direction) {
                    deleteTrans(trans.id, context);
                    setState(() {
                      provider.tx.removeAt(index);
                    });
                  },
                  child: Center(
                    child: TransactionItem1(
                      amount: trans.amount,
                      date: trans.date,
                      title: trans.title,
                    ),
                  ),
                );
              });
    });
  }
}
