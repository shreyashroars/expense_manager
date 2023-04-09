import 'dart:convert';

import 'package:expense_manager/providers/trnsactionprovider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'models/transactionModel.dart';

class GetTransaction {
  List<TransactionModel> tx = [];
  Future<List<TransactionModel>> gettx() async {
    try {
      var Url = Uri.parse(
          'https://backend-for-expense-manager-9cr1efa81-shreyashroars.vercel.app/transaction/gettx');
      var response = await http.get(Url);
      //  print(response.body);
      List<dynamic> jsonData = jsonDecode(response.body);
      //debugPrint(jsonData);
      //  print(jsonData);
      jsonData.forEach((element) {
        TransactionModel txModel = TransactionModel(
            id: element['id'],
            title: element['title'],
            amount: element['amount'],
            date: DateTime.parse(element['date']));
        tx.add(txModel);
        //  print(tx);
      });
      tx.sort(mySortComparison);
      return tx;
    } catch (e) {
      // print('hello');
      debugPrint(e.toString());
    }
  }

  int mySortComparison(TransactionModel a, TransactionModel b) {
    DateTime propertyA = a.date;
    DateTime propertyB = b.date;
    if (propertyA.isAfter(propertyB)) {
      return -1;
    } else if (propertyA.isBefore(propertyB)) {
      return 1;
    } else {
      return 0;
    }
  }
}
