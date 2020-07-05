

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_night/Services/database.dart';
import 'package:the_night/models/event.dart';
import 'package:the_night/models/user.dart';
import 'package:the_night/models/client.dart';
import 'package:the_night/models/restaurant.dart';
import 'package:the_night/screens/Manager/edit_event.dart';
import 'package:the_night/screens/Manager/edit_event_page.dart';
import 'package:the_night/screens/Manager/new_event.dart';
import 'package:the_night/shared/textStyle.dart';
import 'package:provider/provider.dart';

class EventCard extends StatefulWidget {

const EventCard({Key key, this.event}) : super(key: key);
 final Event event;

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {

   

  
  @override
  Widget build(BuildContext context) {
    

    // manager login provider 
    final manager = Provider.of<RestauManager>(context) ;
    final client = Provider.of<Client>(context) ;
    final user = Provider.of<User>(context) ;
    final clientdata = client != null  ? Provider.of<ClientData>(context)  : null  ;

///  like button function
     void _pressLike(bool exist, Event event , ClientData clientData) {

       setState( () {
          if (exist== false) { DatabaseService(uid: client.clientid).eventLike(event, clientData) ; }
         else {DatabaseService(uid: client.clientid).eventdisLike(event, clientData) ; }
         });
  }
   
    

    final  exist = clientdata != null ?  clientdata.eventLikes.contains(widget.event.eventID) : false ;

    return Card(
      margin: const EdgeInsets.symmetric(vertical :20),
      elevation :4 ,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24))
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
         // crossAxisAlignment: CrossAxisAlignment. ,
          children :<Widget> [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Image.network(widget.event.photo, height : 160 ,width: 290, fit : BoxFit.cover )
            ),
           
            Padding(
              padding: const EdgeInsets.only(top : 8.0 , left :8.0),
              child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text(widget.event.name,
                        style: eventTitleTextStyle,
                        ),

                      SizedBox(height : 10),

                      FittedBox(
                          child: Row(
                          children: <Widget>[
                            Icon(Icons.location_on),

                            SizedBox(width : 10),

                            Text(widget.event.location ,
                            style: eventLocationTextStyle,
                              ),
                          ],
                        ),
                      ),

                       SizedBox(height : 10),

                        FittedBox(
                          child: Row(
                          children: <Widget>[
                            Icon(FontAwesomeIcons.calendar),

                            SizedBox(width : 10),

                            Text(widget.event.date ,style: eventLocationTextStyle,),
                          ],
                        ),
                      ),

                       SizedBox(height : 10),

                        FittedBox(
                          child: Row(
                          children: <Widget>[
                            Icon(FontAwesomeIcons.clock , size: 20,),

                            SizedBox(width : 10),

                            Text(widget.event.time ,
                            style: eventLocationTextStyle,
                              ),
                              
                          ],
                        ),
                      ),


                      ],),
                  ),

                 // SizedBox(width: 100,) ,
                  //  users screen
                  if( user != null && client == null )
                   Column(
                    children: <Widget>[
                     
                         GestureDetector(onTap: () {  },
                        child: Icon(FontAwesomeIcons.thumbsUp , color: Colors.black )) ,
                      SizedBox(height: 10,),
                      Text('${widget.event.numLikes}' ) ,
                     ],
                     ),
                  if ( user == null && client !=null)
                
                  Column(
                    children: <Widget>[
                     
                         GestureDetector(onTap: () { _pressLike(exist , widget.event , clientdata) ;  },
                        child: Icon(FontAwesomeIcons.thumbsUp , color:exist == false ? Colors.black : Colors.blue ,)) ,
                      SizedBox(height: 10,),
                      Text('${widget.event.numLikes}' ) ,
                     ],
                     ),
                  // manager screen
                  if(user == null && client == null)
                        Row(
                          children: <Widget>[
                             GestureDetector(onTap: () { Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => EditEvent(event: widget.event,) ),
                               );  print(widget.event.eventID) ; print(widget.event.name) ;},
                            child: Padding(padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.edit ,color:Colors.lightBlue[600] , size: 30,),
                            )),
                            
                            GestureDetector(onTap: () {setState(() async{await DatabaseService(uid : manager.restauID).deleteFood(widget.event);}); },
                            child: Padding(padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.close ,color:Colors.red , size: 30,),
                            )),
                           
                          ],
                        ) ,
                ],
              ),
            )
          ]
        ),
      ),
      
    );
  }
}