import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_night/models/event.dart';
import 'package:the_night/models/restaurant.dart';
import 'package:the_night/screens/Client/home/eventcard.dart';
import 'package:the_night/shared/textStyle.dart';

class MyEvents extends StatefulWidget {

  @override
  _MyEventsState createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  @override
  Widget build(BuildContext context) {
    
    final restaurant = Provider.of<Restaurant>(context)  ;
    final events = Provider.of<List<Event>>(context) ?? []  ;


    if (events == [] || restaurant == null) {
      return  Loading(color: 'blue',);
    }
    else {

    return Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          
                          children:<Widget>[
                            for(final event in events.where((event)=> event.location == restaurant.name)) 
                            Container(color: Colors.lightBlue[50],
                              child: Padding( padding: const EdgeInsets.symmetric(vertical: 5 ,horizontal: 20 ),
                                child: EventCard(event: event) ,
                              ),
                            ) , 
                           ] 
                         )
                       ),
     );
   }
  /*  return Container(
      
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount:events.length ,
        itemBuilder: (BuildContext context, int index) {
         
         
           
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5 ,horizontal: 20 ),
            child: EventCard(event: events[index]) ,
          ); 

        }
        
        ),
      
    ); */
  }
}