import 'package:flutter/material.dart';

import 'package:movies_app/Services/Firebase.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatelessWidget {
  List<dynamic> movieList;
  FavouritesScreen(this.movieList);
  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FirebaseServices>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600].withOpacity(0.66),
        title: Text(
          "My watchlist",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: favProvider.getFavMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            itemCount: favProvider.myFavourites.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1)),
                child: GridTile(
                  footer: GridTileBar(
                    backgroundColor: Colors.yellow[600].withOpacity(0.58),
                    subtitle: Text(
                      favProvider.myFavourites[index][1],
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          fontSize: 17),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              favProvider.myFavourites[index][2],
                            ))),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
