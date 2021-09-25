import 'package:backdrop/backdrop.dart';
import 'package:ecommerce/screens/addmovie.dart';
import 'package:ecommerce/screens/seats_screen.dart';

import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  static const String route='/home';
  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Hello Boss"),

          //الاشعارات الي بتيجي من ان الزبون يحجز كرسي

          FlatButton.icon(
            textColor: Colors.white,
            onPressed: () {
              // Respond to button press
            },
            icon: Icon(Icons.notifications, size: 18),
            label: Text(""),
          ),
        ],
      ),
      backpanel: Center(
        child: Column(
          children: [
            //بيوديني لصفحة الاد موفي

            RaisedButton.icon(
              textColor: Colors.white,
              color: Color(0xFF6200EE),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddMovie()),
                );
                // Respond to button press
              },
              icon: Icon(Icons.add, size: 18),
              label: Text("Add Movie"),
            ),

            //بتوديني علي صفحة السيتس او الكراسي

            RaisedButton.icon(
              textColor: Colors.white,
              color: Color(0xFF6200EE),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomepage()),
                );
                // Respond to button press
              },
              icon: Icon(Icons.pageview, size: 18),
              label: Text("View Booked Seats"),
            ),
          ],
        ),
      ),

      // الافلام الي بتتعرض للزبون + زرار الحذف

      body: Container(
        padding: EdgeInsets.fromLTRB(39, 2, 39, 0),
        child: Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('assets/images/download.jpg'),

                        // زرار حذف هتلاقي جوا الفانكشن بتعتو عدلها عشان تناسب كلاس الافلام بقا

                        RaisedButton.icon(
                          textColor: Colors.white,
                          color: Color(0xFF6200EE),
                          onPressed: () {}
                          /*

                            =>deletemovie(movienotifier.currentmovie, _onmoviedeleted)

                            */

                          ,
                          icon: Icon(Icons.delete, size: 18),
                          label: Text("Delete Movie"),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('assets/images/download.jpg'),
                        RaisedButton.icon(
                          textColor: Colors.white,
                          color: Color(0xFF6200EE),
                          onPressed: () {
                            // Respond to button press
                          },
                          icon: Icon(Icons.delete, size: 18),
                          label: Text("Delete Movie"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('assets/images/download.jpg'),
                        RaisedButton.icon(
                          textColor: Colors.white,
                          color: Color(0xFF6200EE),
                          onPressed: () {
                            // Respond to button press
                          },
                          icon: Icon(Icons.delete, size: 18),
                          label: Text("Delete Movie"),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('assets/images/download.jpg'),
                        RaisedButton.icon(
                          textColor: Colors.white,
                          color: Color(0xFF6200EE),
                          onPressed: () {
                            // Respond to button press
                          },
                          icon: Icon(Icons.delete, size: 18),
                          label: Text("Delete Movie"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//delete method
/*
deletemovie(Movie movie, Function moviedeleted) async {
  if (movie.image != null) {
    storageReferance storageReferance =
        await firebasestorage.instance.getreferancefromurl(movie.image);


        await storageReferance.delete()
        print("image deleted");
  }

  await firestore.instance.collection('Movies').document(movie.id).delete();
  moviedeleted(movie);
}



//puted in movienotifier page
deletemovie(Movie movie){
_movielist.removewhare((_movie) => _movie.id == movie.id);
 notifyListener();
}


//calling notifier 
MovieNotifier movieNotifier = provider.of<MvieNotifier>(context);
_onmoviedeleted(Movie movie){
  Navigator.pop(context);
  movieNotifier.deletemovie(movie);
} 
*/
