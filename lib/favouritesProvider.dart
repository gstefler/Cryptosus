import 'package:flutter/material.dart';
import 'Coin.dart';

class FavouritesProvider with ChangeNotifier {
  Set<String> favourites = <String>{};

  handleFavourites(Coin item, BuildContext context){
    if (favourites.contains(item.id)){
        favourites.remove(item.id);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Removed ${item.name} from favourites"), duration: Duration(seconds: 1),));
    } else {
      favourites.add(item.id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added ${item.name} to favourites"), duration: Duration(seconds: 1)));
    }
    notifyListeners();
  }
}