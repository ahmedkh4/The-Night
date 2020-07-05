import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_night/Services/auth.dart';
import 'package:the_night/Services/database.dart';
import 'package:the_night/models/event.dart';
import 'package:the_night/models/user.dart';
import 'package:the_night/models/client.dart';
import 'package:the_night/shared/textStyle.dart';


class Favorite extends StatefulWidget {
 
 
  @override
  _FavoriteState createState() => _FavoriteState();
}
 

class _FavoriteState extends State<Favorite> {

  
  @override
  Widget build(BuildContext context) {
  final events = Provider.of<List<Event>>(context) ;
  final client = Provider.of<Client>(context) ;
  final clientdata = client != null ? Provider.of<ClientData>(context) : null ;

  

  ///  like button function
     void _pressLike(bool exist, Event event , ClientData clientData) {

       setState( () {
          if (exist== false) { DatabaseService(uid: client.clientid).eventLike(event, clientData) ; }
         else {DatabaseService(uid: client.clientid).eventdisLike(event, clientData) ; }
         });
  }

  final AuthService _auth = AuthService() ;
if (client != null )  { 
  return Column(
      children: <Widget>[
       
       
       Container(
               child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(

            children: <Widget>[   
               for ( final event in events.where( (event) => clientdata.eventLikes.contains(event.eventID)) )
             
              
               Padding(
                padding: const EdgeInsets.only(top: 15 , bottom: 15 , left:10 , right: 0 ),
                child: ListTile(
                  leading: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image(
                              width: 110.0,
                              image: NetworkImage( event.photo ),
                              fit: BoxFit.cover,
                            ),
                          ),
                  title: Text(event.name ,style: categoryTextStyle.copyWith(color: Colors.black) ),
                  trailing: GestureDetector(onTap: () {
                    final  exist = clientdata != null ?  clientdata.eventLikes.contains(event.eventID) : false ;
                    _pressLike(exist , event , clientdata) ;
                    },
                            child: Icon(FontAwesomeIcons.thumbsUp , color: Colors.blue  )) ,
                )
              ) ,
             ], 
             ),
             ),),
          

           
         
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: FloatingActionButton(onPressed:(){ _auth.signOut(); _auth.fblogOut();} ,child: Icon(Icons.exit_to_app),backgroundColor : Colors.deepPurple  ),
          ) ,

      ],
    );
} else {
  return  Column(mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text('Login' ,style: TextStyle(color : Colors.deepPurple , fontSize: 30 , fontWeight: FontWeight.w700),) ,
      SizedBox(height:50 ,) ,
      Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
               
                            RaisedButton.icon(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)
                              ),
                              color: Colors.deepPurple,
                              onPressed: () { _auth.fblogin() ; _auth.signOut() ;} , 
                              icon:Icon( FontAwesomeIcons.facebook ,color:Colors.black ) ,
                               label: Text('Facebook' ,style:TextStyle( fontSize: 20.0 ,color: Colors.black), )
                            ),

                            SizedBox(width: 50,) ,

                            RaisedButton.icon(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)
                              ),
                              color: Colors.deepPurple ,
                              onPressed: () { _auth.fblogin() ; _auth.signOut() ;}  , 
                              icon:Icon( FontAwesomeIcons.google ,color:Colors.black ), 
                               label: Text('google' ,style:TextStyle( fontSize: 20.0 ,color: Colors.black) , )
                            ),

                               ],
                                 ),
    ],
  );
}
    
  }
}