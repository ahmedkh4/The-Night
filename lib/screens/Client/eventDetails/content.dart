import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_night/Services/database.dart';
import 'package:the_night/models/event.dart';
import 'package:the_night/models/user.dart';
import 'package:the_night/models/client.dart';
import 'package:the_night/shared/comments.dart';
import 'package:the_night/shared/rating.dart';
import 'package:the_night/shared/textStyle.dart';



class EventDetailsContent extends StatefulWidget {

  final String id ;
  EventDetailsContent({Key key, this.id}) : super(key: key); 

  @override
  _EventDetailsContentState createState() => _EventDetailsContentState();
}

class _EventDetailsContentState extends State<EventDetailsContent> {

  
  @override
  Widget build(BuildContext context) {

     final events = Provider.of<List<Event>>(context) ?? [] ;
     final client = Provider.of<Client>(context) ;
    final user = Provider.of<User>(context) ;
    final clientdata = client != null  ? Provider.of<ClientData>(context)  : null  ;

    if(events == [] || events.isEmpty ) { return  Loading(color: 'purple',) ;} else { 

  final  itevent = events.where((event)=> event.eventID == widget.id) ;
  
  final event = itevent.last;
 ///
    final  exist = clientdata != null ?  clientdata.eventLikes.contains(event.eventID) : false ;

    
   ///  like button function
     void _pressLike(bool exist, Event event , ClientData clientData) {

       setState( () {
          if (exist== false) { DatabaseService(uid: client.clientid).eventLike(event, clientData) ; }
         else {DatabaseService(uid: client.clientid).eventdisLike(event, clientData) ; }
         });
  }
  
  void _showComments(){
        showModalBottomSheet(isScrollControlled:true , shape :RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                          ),  
        context: context , builder: (context) {
         
          return 
                 Container(height:  MediaQuery.of(context).size.height *0.77,
                color: Colors.grey[300],
                padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 30),
              
                child:  SingleChildScrollView(scrollDirection: Axis.vertical ,
                  child: Column(
                     children: <Widget>[
                          Text('Comments' , style:TextStyle(color: Colors.deepPurple[400] , fontWeight: FontWeight.w500,fontSize:25 ),  ),
                          SizedBox(height: 20,) ,
                         Container(height: 200,
                           child: Comments(id: widget.id, type: 'event',)),
                          
                            CommentTextfield(name: clientdata.name,eventorrestau:event ,type: 'event',),
                          
                          SizedBox( height: MediaQuery.of(context).viewInsets.bottom, )
                        
                        ], )
                      ),
             
          
                 );
        });
      } 



    //final event = Provider.of<Event>(context);
    final screenWidth = MediaQuery.of(context).size.width;

     return  SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          SizedBox( height: 100,),
         
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
            child: Text(event.name, style: eventWhiteTitleTextStyle,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.24),
            child: FittedBox(
              child: Row(
                children: <Widget>[
                  Text(
                    "-",
                   style: eventLocationTextStyle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ), 
                  ),
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    event.location,
                    style: eventLocationTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w700)
                  ),
                ],
              ),
            ),
          ),
          SizedBox( height: 120, ),
           Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.calendar , color: Colors.deepPurple[400],) ,
                SizedBox( width: 10.0,),
                Text("On the ${event.date}", style: guestTextStyle
                ),
              ],
            ),
          ),

          SizedBox( height: 20, ),


          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.clock , color: Colors.deepPurple[400],) ,
                SizedBox( width: 10.0,),
                Text("Starting From ${event.time}", style: guestTextStyle
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: event.description1 ,style: punchLine1TextStyle, ),
                  
                ]
              ),
            ),
          ),
        //  if (event.band.isNotEmpty) 
         Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                 Text('Band :',  style: eventLocationTextStyle.copyWith(fontSize:25 ,fontWeight: FontWeight.w600 ,color: Colors.deepPurple[400]) ),
                 SizedBox( width: 10.0,),
                Text( event.band,  style: eventLocationTextStyle, ),
              ],
            ),
          ),
          
         
         SingleChildScrollView(
           scrollDirection: Axis.horizontal,
           child:Row(mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             SizedBox(width:15 ,) ,
              Text('Categories :',  style: eventLocationTextStyle.copyWith(fontSize:25 ,fontWeight: FontWeight.w600 ,color: Colors.deepPurple[400]) ),
             for (final x in event.eventCategories.where((x) => x != 'All'))
              Container(
                  margin: const EdgeInsets.symmetric(horizontal : 8),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border:Border.all(color :Colors.deepPurple[400]),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color : Colors.transparent ,
                  ),
                  child: Center(child :Text(x , style: TextStyle(color:Colors.deepPurple[400] ),)),
                  ),

           ],

           )
         ) ,
         // evaluation  // 
         Container(
                          
                          child:Row(crossAxisAlignment: CrossAxisAlignment.center , mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            
                            GestureDetector(
                            
                            onTap:() {if( user == null && client != null)  {_pressLike(exist ,event , clientdata) ;}} ,

                             child: Card(margin :EdgeInsets.all(20.0), 
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(children: <Widget>[
                                  Icon(FontAwesomeIcons.thumbsUp, color: exist == false ? Colors.black : Colors.blue ,),
                                  Text('Like',style:categoryTextStyle.copyWith(color:Colors.black54 ,fontSize: 12.0) ,) ,
                                  Text('${event.numLikes} likes',style:categoryTextStyle.copyWith(color:Colors.black54 ,fontSize: 12.0) ,)
                                ],),
                              )
                              ,),
                            ) ,

                             GestureDetector(onTap: () { if (client != null) { _showComments();}},
                               child: Card(margin :EdgeInsets.all(20.0), 
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(children: <Widget>[
                                  Icon(FontAwesomeIcons.commentDots),
                                  Text('comment',style:categoryTextStyle.copyWith(color:Colors.black54 ,fontSize: 12.0) ,)
                                ],),
                            )
                            ,),
                             ) ,

                             GestureDetector(
                               onTap: () {  },
                            
                            child: Card(margin :EdgeInsets.all(20.0),
                               
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(children: <Widget>[
                                  Icon(FontAwesomeIcons.star),
                                  Text('rate',style:categoryTextStyle.copyWith(color:Colors.black54 ,fontSize: 12.0) ,)
                                ],),
                            )
                            ,),
                             ) ,

                          ],
                          )
                        )

          


        ],
      ),
    ); }
  }
}