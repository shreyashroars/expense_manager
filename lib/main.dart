import 'dart:io';
import 'package:expense_manager/models/transactionModel.dart';
import 'package:expense_manager/providers/trnsactionprovider.dart';
import 'package:expense_manager/widgets/chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Personal Expenses',
        theme: ThemeData(
          fontFamily: 'QuickSand',
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          primarySwatch: Colors.green,
          // ignore: deprecated_member_use
          accentColor: Colors.amber,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<TransactionModel> _recentTransactions(BuildContext context) {
    return context
        .watch<TransactionProvider>()
        .tx
        .where((element) => element.date
            .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void delTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (ctx) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    ).whenComplete(() {
      setState(() {
        debugPrint('setState called');
      });
    });
  }

  List<Widget> _buildLandscapeView(
    MediaQueryData mediaquery,
    AppBar appBar,
    Widget txListWidget,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch.adaptive(
              activeColor: Theme.of(context).primaryColor,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              height: (mediaquery.size.height -
                      appBar.preferredSize.height -
                      mediaquery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions(context)))
          : txListWidget
    ];
  }

  List<Widget> _buildPortraitView(
      MediaQueryData mediaquery, AppBar appBar, Widget txListWidget) {
    return [
      Container(
        height: (mediaquery.size.height -
                appBar.preferredSize.height -
                mediaquery.padding.top) *
            0.3,
        child: Chart(_recentTransactions(context)),
      ),
      txListWidget
    ];
  }

  Widget whatPlatFormAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Expense Manager'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _startAddNewTransaction(context),
                  child: const Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Expense Manager',
              style: GoogleFonts.poppins(),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    //MediaQuery.of(context) replaced with mediaquery Variable
    final isLandscape = mediaquery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = whatPlatFormAppBar();

    // ignore: sized_box_for_whitespace
    final Widget txListWidget = Container(
      height: (mediaquery.size.height -
              appBar.preferredSize.height -
              mediaquery.padding.top) *
          0.7,
      child: TransactionList(),
    );

    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (isLandscape)
            ..._buildLandscapeView(mediaquery, appBar, txListWidget),
          if (!isLandscape)
            ..._buildPortraitView(mediaquery, appBar, txListWidget),
        ],
      ),
    ));
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
