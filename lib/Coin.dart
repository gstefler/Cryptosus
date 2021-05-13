import 'dart:convert';

// Stores the relevant data of a Cryptocurrency
class Coin{
  // Short name of the crypto
  final String symbol;
  // Long name of the crypto
  final String name;
  // Price in USD
  var price;
  // Url that contains the image of the crypto
  final Uri url;

  Coin({this.symbol, this.name, this.price, this.url});

  // Creates a Coin object from a JSON file
  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      symbol: json['symbol'],
      name: json['name'],
      price: json['current_price'],
      url: Uri.parse(json['image']),
    );
  }
}