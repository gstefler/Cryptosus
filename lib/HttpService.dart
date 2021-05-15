import 'dart:convert';

import 'Coin.dart';
import 'package:http/http.dart';

import 'package:flutter/foundation.dart';

class CoinListService{
  static final int coinsPerPage = 50;

  final apiURL = Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=$coinsPerPage&page=1&sparkline=false');

  Future<List<Coin>> getCoins() async {
    Response res = await get(apiURL);

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

class CoinInfoService{
  final String coinID;
  Uri url;
  CoinInfoService({@required this.coinID}){
    url = Uri.parse('https://api.coingecko.com/api/v3/coins/$coinID?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false');
  }

  Future<CoinInfo> getInfo() async {
    Response res = await get(url);
    if (res.statusCode == 200){
      dynamic body = jsonDecode(res.body);
      CoinInfo info = CoinInfo.fromJson(body);
      return info;
    }
    else{
      throw "Can't get coin info!";
    }
  }
}