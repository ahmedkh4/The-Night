import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_night/Services/database.dart';
import 'package:the_night/models/event.dart';
import 'package:the_night/models/restaurant.dart';
import 'package:the_night/screens/Manager/edit_event.dart';



class EditEvent extends StatelessWidget {
  final Event event ;
  EditEvent({this.event}) ;
  @override
  Widget build(BuildContext context) {

 final manager = Provider.of<RestauManager>(context) ;

    return  StreamProvider<Restaurant>.value(
   value: DatabaseService(uid: manager.restauID).restaurant,
   child: Edit(event: event,),
      
    );
  }
}