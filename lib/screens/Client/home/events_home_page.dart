import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_night/models/categories.dart';
import 'package:the_night/models/event.dart';
import 'package:the_night/screens/Client/RestauCollection/backgroud.dart';
import 'package:the_night/screens/Client/eventDetails/event_page.dart';
import 'package:the_night/screens/Client/home/category.dart';
import 'package:the_night/screens/Client/home/eventcard.dart';



class EventsHomePage extends StatefulWidget {
  @override
  _EventsHomePageState createState() => _EventsHomePageState();
}
// selected category list
 List<String> selected = <String> ['All'] ;

class _EventsHomePageState extends State<EventsHomePage> {


List<String> selected1 = selected ;


  String categoryID  ; 
  @override
  Widget build(BuildContext context) {
    
    final events = Provider.of<List<Event>>(context) ?? []  ;
   


    return ChangeNotifierProvider<AppState>(
      create: (_) => AppState(),
          child: Stack(
            children: <Widget>[

              Background(),

             SingleChildScrollView(
              child: Column(
            children: <Widget>[
              CategoryScroll()  ,
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Consumer<AppState>( 
                  builder:(context, appState,__) =>
                     Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                   for (final event in events.where((event) => event.eventCategories.contains( appState.selectedCategory ) ) )

                      GestureDetector(
                       child: EventCard(event: event),
                       onTap: () {
                      Navigator.of(context).push(
                            MaterialPageRoute(
                            builder: (context) => EventDetailsPage(id: event.eventID,)   ,
                           ),
                         );
                                      
                         },
                     ),
                  
                    ],
                  ),
                ),
                
              ),
           ) ,
            ],
            
          ),
             ),
            ]
        
      ),
    );
  }
}




