import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_night/Services/database.dart';
import 'package:the_night/models/categories.dart';
import 'package:the_night/models/user.dart';
import 'package:the_night/models/client.dart';
import 'package:the_night/models/restaurant.dart';
import 'package:the_night/screens/Client/restaurantsList/background.dart';
import 'package:the_night/screens/Client/restaurantsList/restau_list_content.dart';



class RestauListPage extends StatelessWidget {
  
  final Category category ; 


  RestauListPage({ this.category}) ;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context) ;
    final client = Provider.of<Client>(context) ;

if ( user != null ) {
 return  StreamProvider<List<Restaurant>>.value(
         value: DatabaseService(uid: user.userID  ).restaurants, 
   child : Scaffold(
      
          body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          RestauListBackground( screenHeight: MediaQuery.of(context).size.height,),
          DestinationScreen(category: category,),
        ],
        
      ),
   )
    );
    
}
else if (client != null) {
 return  StreamProvider<List<Restaurant>>.value(
         value: DatabaseService(uid: client.clientid  ).restaurants, 
   child : StreamProvider<ClientData>.value(
   value: DatabaseService(uid: client.clientid).clientData, 
   child : Scaffold(
      
          body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          RestauListBackground( screenHeight: MediaQuery.of(context).size.height,),
          DestinationScreen(category: category,),
        ],
        
      ),
   ) ,)
    );
}
    
  
  }
}