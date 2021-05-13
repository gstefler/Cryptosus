import 'package:flutter/material.dart';
import 'HttpService.dart';
import 'Coin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final CategoriesScroller categoriesScroller = CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final HttpService httpService = HttpService();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff222222),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF181818),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.0)
              ),
          ),
          title: Text(
            "Cryptosus",
            style: TextStyle(
              color: const Color(0xffeeeeee),
              fontSize: 23,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.white70),
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.white70),
              onPressed: (){},
            ),
          ],
        ),
        body:
        Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              /*SizedBox(
                height: 3,
              ),*/
              Expanded(
                child: FutureBuilder(
                  future: httpService.getCoins(),
                  builder: (BuildContext context, AsyncSnapshot<List<Coin>> snapshot) {
                    if (snapshot.hasData) {
                      List<Coin> coins = snapshot.data;
                      return ListView.builder(
                          itemCount: coins.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              height: 80,
                              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0)), color: const Color(0xFF111111), boxShadow: [
                                //BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 10.0),
                              ]),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Image.network(
                                      coins[index].url.toString(),
                                      height: 50,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                          Text(
                                            coins[index].name,
                                            style: const TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            coins[index].symbol.toUpperCase(),
                                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            "\$${coins[index].price}",
                                            style: const TextStyle(fontSize: 18, color: Colors.white70, fontWeight: FontWeight.bold),
                                          )
                                        ],
                                    ),
                                  ],
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
        ),
      ),
    );
  }
}