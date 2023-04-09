import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deltx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deltx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color bg_Color;
  @override
  void initState() {
    const avail_Colors = [
      Colors.blue,
      Colors.brown,
      Colors.green,
      Colors.deepOrange,
      Colors.purple
    ];
    bg_Color = avail_Colors[Random().nextInt(5)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.purple, width: 1)),
      elevation: 10,
      shadowColor: Colors.brown,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: bg_Color,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(child: Text('₹ ${widget.transaction.amount}')),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: const TextStyle(
              fontFamily: 'QuickSand',
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width > 360
            ? TextButton.icon(
                onPressed: () => widget.deltx(widget.transaction.id),
                icon: const Icon(Icons.delete_rounded),
                label: Text(
                  'Delete',
                  style: TextStyle(color: Theme.of(context).errorColor),
                ))
            : IconButton(
                onPressed: () => widget.deltx(widget.transaction.id),
                color: Theme.of(context).errorColor,
                icon: const Icon(Icons.delete_rounded),
              ),
      ),
    );
  }
}
