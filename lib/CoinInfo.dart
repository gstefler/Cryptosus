import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'HttpService.dart';
import 'Coin.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom_parsing.dart';
import 'package:html/dom.dart' as dom;

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

    return Center(
      child: Container(
        width: 800.0,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        alignment: Alignment.center,
        //Main column, everything is inside this
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // First row of the main column, here is the coins image and name
            Container(
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Coin image
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: const Color(0xFF111111)),
                      padding: const EdgeInsets.all(16),
                      child: Image.network(
                        coin.url.toString(),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: const Color(0xFF111111)),
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.topLeft,
                        // Coin name and symbol
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    coin.name,
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                                  ),
                                  Text(
                                    coin.symbol.toUpperCase(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 30,
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "\$${coin.price}",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: const Color(0xFF111111)),
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Hashing algorithm: " + info.algorithm,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      "Launch date: " + info.date,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Html(
                    data: "<p style=\"color:#eeeeee;\">" + info.description + "</p>",
                  ),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: const Color(0xFF111111)),
                  padding: EdgeInsets.all(10.0),
                ),
              ),
            ),
          ],
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
