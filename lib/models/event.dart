

import 'package:the_night/models/restaurant.dart';

class Event {

String eventID ; 
String name , location , band ; 
String date ,  time  ;
String description1 , description2 ;
String photo ; 
List eventCategories ; 
int numLikes ; 
double rating ; 
List<Commentaire> comments ; 


Event ({this.eventID , this.name , this.date , this.time , this.description1 , this.eventCategories ,// this.description2 , 
    this.comments   ,this.photo , this.numLikes , this.rating  , this.location , this.band});




  Map<String, dynamic> toMap() {
    return {
      'id': eventID,
      'name': name,
      'location': location,
      'date': date,
      'time': time,
      'description1': description1,
      'numLikes': numLikes,
      'rating': rating ,
      'photo' : photo ,
      'band' : band ,
      'eventCategories' : eventCategories ,
      'comments' : comments
    };
  }




}


List<Event> events4 = <Event> [
  Event(eventID: '1',name:'golf party' ,date:'today' ,time: 'now' , photo:'assets/others.jpg'  , rating:0  , numLikes:3  ,  ) ,
  Event(eventID: '2',name:'disco party' ,date:'tomorrow' ,time: 'later' , photo:'assets/Techno.png'  , rating:100  , numLikes:500  ,  ) ,
  Event(eventID: '3',name:'anime party' ,date:'4/4/2020' ,time: '00:00' , photo:'assets/hmiz.jpg'  , rating:999  , numLikes:999  ,  ) ,
];