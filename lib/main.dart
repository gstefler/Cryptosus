import 'package:flutter/material.dart';
import './CoinList.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'favouritesProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: MyApp(),
    )
  );
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<FavouritesProvider>(create: (_) => FavouritesProvider()),
];


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: CoinList(),
    );
  }
}
