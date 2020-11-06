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
      body: FutureBuilder(
        future: favProvider.getFavMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            itemCount: favProvider.myFavourites.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                 Text(favProvider.myFavourites[index][1])],
              );
            },
          );
        },
      ),
    );
  }
}
