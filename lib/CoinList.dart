import './Coin.dart';
import './HttpService.dart';
import 'package:flutter/material.dart';
import './CoinInfo.dart';

//The listview where the coins live

class CoinList extends StatefulWidget {
  const CoinList({Key key}) : super(key: key);

  @override
  _CoinListState createState() => _CoinListState();
}

class _CoinListState extends State<CoinList> {
  final coinListService = CoinListService();
  final nameStyle = TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold);
  final symbolStyle = TextStyle(fontSize: 12, color: Colors.grey);
  final priceStyle = TextStyle(fontSize: 18, color: Colors.white70, fontWeight: FontWeight.bold);

  void pushSaved(){

  }

  Widget buildCoinList() {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      child: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: coinListService.getCoins(),
              builder: (BuildContext context, AsyncSnapshot<List<Coin>> snapshot) {
                if (snapshot.hasData) {
                  List<Coin> coins = snapshot.data;
                  return ListView.builder(
                      itemCount: coins.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CoinInfoPage(
                                      coin: coins[index],
                                      coinInfoService: CoinInfoService(coinID: coins[index].id),
                                    )
                                )
                            );
                          },
                          child: Container(
                            height: 80,
                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0)), color: const Color(0xFF111111), boxShadow: [
                              //BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 10.0),
                            ]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 9),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Image.network(
                                    coins[index].url.toString(),
                                    height: 50,
                                    width: 50,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        coins[index].name,
                                        style: nameStyle,
                                      ),
                                      Text(
                                        coins[index].symbol.toUpperCase(),
                                        style: symbolStyle,
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "\$${coins[index].price}",
                                        style: priceStyle,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff222222),
      appBar: AppBar(
        title: Text("Crypto"),
        actions: [
          IconButton(icon: Icon(Icons.menu), onPressed: pushSaved)
        ],
      ),
      body: buildCoinList(),
    );
  }
}
