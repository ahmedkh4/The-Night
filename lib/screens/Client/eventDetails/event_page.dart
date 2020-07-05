import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_night/Services/auth.dart';
import 'package:the_night/Services/database.dart';
import 'package:the_night/models/client.dart';
import 'package:the_night/models/event.dart';
import 'package:the_night/models/user.dart';
import 'package:the_night/screens/Client/eventDetails/backgroud.dart';
import 'package:the_night/screens/Client/eventDetails/content.dart';



//import 'package:provider/provider.dart';



class EventDetailsPage extends StatelessWidget {

  final  String id;

   EventDetailsPage({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  StreamProvider<Client>.value(
        value: AuthService().client ,
         child :StreamProvider<User>.value(
        value: AuthService().user ,
         child : DetailedPage(id: id,) ,),) ;
    
  }
}

class DetailedPage extends StatelessWidget {
  final  String id;

   DetailedPage({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {

   final client = Provider.of<Client>(context) ;
   final user = Provider.of<User>(context) ;

  if ( client != null )
{return  StreamProvider<ClientData>.value(
   value: DatabaseService(uid: client.clientid).clientData, 
   child :StreamProvider<List<Event>>.value(
   value: DatabaseService(uid: client.clientid).events,
   child: Scaffold(
     // body: Provider<Event>.value(
       // value: event,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            EventDetailsBackground(id: id,),
            EventDetailsContent(id: id,),
          ],
        ), ) ,)
      );}
      else  { return StreamProvider<List<Event>>.value(
   value: DatabaseService(uid:user.userID).events,
   child: Scaffold(
     // body: Provider<Event>.value(
       // value: event,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            EventDetailsBackground(id: id,),
            EventDetailsContent(id: id,),
          ],
        ),), ) ;}
   
  }
}