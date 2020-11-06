import 'package:flutter/material.dart';
import 'package:movies_app/Services/Firebase.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:Provider.of<FirebaseServices>(context, listen: false)
                .getFavMovies() ,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: Provider.of<FirebaseServices>(context, listen: false)
                .myFavourites
                .length,
            itemBuilder: (context, index) {
              print(Provider.of<FirebaseServices>(context, listen: false)
                  .myFavourites[index]);
              return Column(
                children: [
                  Text(Provider.of<FirebaseServices>(context, listen: false)
                      .myFavourites[index])
                ],
              );
            },
          );
        },
      ),
    );
  }
}
