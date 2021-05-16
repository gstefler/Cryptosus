import './Coin.dart';
import './HttpService.dart';
import 'package:flutter/material.dart';
import './CoinInfo.dart';
import 'package:provider/provider.dart';
import 'favouritesProvider.dart';

//The listview containing the coins
class CoinList extends StatefulWidget {
  @override
  _CoinListState createState() => _CoinListState();
}

class _CoinListState extends State<CoinList> {
  final coinListService = CoinListService();
  final nameStyle = TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold);
  final symbolStyle = TextStyle(fontSize: 12, color: Colors.grey);
  final priceStyle = TextStyle(fontSize: 18, color: Colors.white70, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final favourites = Provider.of<FavouritesProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xff222222),
      appBar: AppBar(
        title: Text("Crypto"),
        actions: [
          IconButton(icon: Icon(Icons.favorite), onPressed: pushSaved)
        ],
      ),
      body: buildCoinList(favourites),
    );
  }

  //Storing the saved coins
  List<Coin> coins = <Coin>[];
  

  //I build two time once for the coinlist, and once for the favourites list
  Widget coinListTileLayout(Coin coin){
    return Container(
      height: 82,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0)), color: const Color(0xFF111111),),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.network(
              coin.url.toString(),
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
                  coin.name,
                  style: nameStyle,
                ),
                Text(
                  coin.symbol.toUpperCase(),
                  style: symbolStyle,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "\$${coin.price}",
                  style: priceStyle,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void pushSaved(){
    final favourites = Provider.of<FavouritesProvider>(context, listen: false);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final savedCoinTiles = favourites.favourites.map(
                (String coinId) {
                  final Coin tmp = coins.firstWhere((Coin coin) => coin.id == coinId);
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CoinInfoPage(
                                coin: tmp,
                                coinInfoService: CoinInfoService(coinID: tmp.id),
                              )
                          )
                      );
                    },
                    child: coinListTileLayout(tmp),
                );
            },
          );
          final divided = savedCoinTiles.isNotEmpty ? ListTile.divideTiles(context: context, tiles: savedCoinTiles).toList() : <Widget>[];
          return Scaffold(
            backgroundColor: const Color(0xff222222),
            appBar: AppBar(
              title: Text('Saved Coins'),
            ),
            body: ListView(children: divided),
          );
        }
      )
    );
  }

  Widget buildCoinList(FavouritesProvider fav) {
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
                  coins = snapshot.data;
                  return ListView.builder(
                      itemCount: coins.length,
                      physics: ClampingScrollPhysics(),
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
                          onLongPress: (){
                            setState(() {
                                fav.handleFavourites(coins[index], context);
                            });
                          },
                          child: coinListTileLayout(coins[index]),
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
}
