import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'HttpService.dart';
import 'Coin.dart';
import 'package:flutter_html/flutter_html.dart';

class CoinInfoPage extends StatelessWidget {
  final Coin coin;
  final CoinInfoService coinInfoService;

  const CoinInfoPage(
      {Key key, @required this.coin, @required this.coinInfoService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff222222),
      appBar: AppBar(
        title: Text(coin.name),
      ),
      body: buildInfo(),
    );
  }

  Widget infoDataWidget(CoinInfo info) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Html(
            data: info.description,
          ),
        ),
      ),
    );
  }

  Widget buildInfo() {
    return Container(
      child: FutureBuilder(
        future: coinInfoService.getInfo(),
        builder: (BuildContext context, AsyncSnapshot<CoinInfo> snapshot) {
          if (snapshot.hasData) {
            CoinInfo info = snapshot.data;
            return infoDataWidget(info);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
