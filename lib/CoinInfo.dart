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
    return Container(
      width: 500.0,
      // The whole page, is made out of columns
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          // The first row contains the image and the name
          children: <Widget>[
            Container(
              child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: Image.network(
                          coin.url.toString(),
                          width: 80,
                        ),
                      ),
                      //decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0)), color: const Color(0xFF111111)),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                  ]
                ),

              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.center,
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Html(
                    data: "<p style=\"color:#eeeeee;\">" + info.description + "</p>",
                  ),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0)), color: const Color(0xFF111111)),
                  padding: EdgeInsets.all(15.0),
                ),
              ),
            ),
          ]
        ),
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      alignment: Alignment.center,
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
