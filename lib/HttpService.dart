import 'dart:convert';

import 'Coin.dart';
import 'package:http/http.dart';

class HttpService{
  static final int coinsPerPage = 30;

  final Uri marketinfoUrl = Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=$coinsPerPage&page=1&sparkline=false');


  Future<List<Coin>> getCoins() async {
    Response res = await get(marketinfoUrl);

    if(res.statusCode == 200){
      List<dynamic> body = jsonDecode(res.body);

      List<Coin> coins= body.map((dynamic item) => Coin.fromJson(item)).toList();
      return coins;
    }
    else{
      throw "Can't get coins";
    }
  }
}