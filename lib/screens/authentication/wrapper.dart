import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_night/Services/database.dart';
import 'package:the_night/models/event.dart';
import 'package:the_night/screens/Client/appbar/appbar.dart';
import 'package:the_night/screens/Manager/managerhome.dart';
import 'package:the_night/screens/authentication/authenticate.dart';
import 'package:the_night/models/restaurant.dart';
import 'package:the_night/models/user.dart';
import 'package:the_night/models/client.dart';
import 'package:the_night/screens/authentication/sign_in.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

   

    final manager = Provider.of<RestauManager>(context) ;
      final user = Provider.of<User>(context) ;
      final client = Provider.of<Client>(context) ;



      _child() {
    if ( manager == null && user == null && client == null ) {
    print('case 1');
    print(manager) ;print(user) ; print(client) ; 
    return  Authenticate() ;

    }else if ( manager != null && user == null && client == null ) {
    print('case 2 ') ; 
    print(manager) ;print(user) ; print(client) ; 
    return  StreamProvider<Restaurant>.value(
   value: DatabaseService(uid: manager.restauID).restaurant, 
   child:StreamProvider<Event>.value(
   value: DatabaseService(uid: manager.restauID).event, 
   child:StreamProvider<List<Event>>.value(
   value: DatabaseService(uid: manager.restauID).events, 
   child:ManagerHomePage() ) 
   ,)
    );

    }else if (   user != null   ) {
      print('case 3 ') ; 
      print(manager) ;print(user.toString()) ;print(client.toString()) ;
    return StreamProvider<Restaurant>.value(
   value: DatabaseService(uid: user.userID).restaurant, 
   child:StreamProvider<List<Restaurant>>.value(
   value: DatabaseService(uid: user.userID).restaurants, 
   child :StreamProvider<List<Event>>.value(
   value: DatabaseService(uid: user.userID).events,
   child: StreamProvider<Event>.value(
   value: DatabaseService(uid: user.userID).event, 
   child : Menu()
 ),),)
   
    );
  }else if (client != null ) {
    print('case 4 ') ; 
      print(manager) ;print(user.toString()) ;print(client.toString()) ;
  return StreamProvider<Restaurant>.value(
   value: DatabaseService(uid: client.clientid).restaurant, 
   child:StreamProvider<List<Restaurant>>.value(
   value: DatabaseService(uid: client.clientid).restaurants, 
   child :StreamProvider<List<Event>>.value(
   value: DatabaseService(uid: client.clientid).events,
   child: StreamProvider<Event>.value(
   value: DatabaseService(uid: client.clientid).event, 
   child : StreamProvider<ClientData>.value(
   value: DatabaseService(uid: client.clientid).clientData, 
   child : Menu() ),)
   ),),);
  }
  
  else {print('else ') ; 
    return Authenticate() ;
  }
    }

    
  
  return  _child() ;
   
  







    // return either Home or Authentication Widget
/*  if (manager == null && user == null ) {
    return Authenticate() ;

  }else if ( user == null && manager != null  ) {
    return ManagerHomePage() ;
  }else if ( user != null && manager == null  ) {
    return Menu() ;
  } **/
      
    
  }
}