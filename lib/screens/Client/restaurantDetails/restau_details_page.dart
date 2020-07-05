import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_night/Services/auth.dart';
import 'package:the_night/Services/database.dart';
import 'package:the_night/models/categories.dart';
import 'package:the_night/models/client.dart';
import 'package:the_night/models/restaurant.dart';
import 'package:the_night/models/user.dart';
import 'package:the_night/shared/comments.dart';
import 'package:the_night/shared/rating.dart';
import 'package:the_night/shared/textStyle.dart';




class RestauDetailedPage extends StatelessWidget {
 final String id ; 

RestauDetailedPage({this.id}) ;
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Client>.value(
        value: AuthService().client ,
         child :  StreamProvider<User>.value(
        value: AuthService().user ,
         child :MiniWrapper(id: id,) ,)) ;
  }
}


class MiniWrapper extends StatelessWidget {
 final String id ;  

MiniWrapper({this.id}) ;
  @override
  Widget build(BuildContext context) {
    final client = Provider.of<Client>(context) ;
    final user = Provider.of<User>(context) ;

    if( client != null )  {
      return  StreamProvider<ClientData>.value(
   value: DatabaseService(uid: client.clientid).clientData, 
   child :StreamProvider<List<Restaurant>>.value(
   value: DatabaseService(uid: client.clientid ).restaurants,
   child:RestauDetails(id: id,) 
       ) );

    }else if ( user != null) {
      return StreamProvider<List<Restaurant>>.value(
   value: DatabaseService(uid:user.userID).restaurants,
   child:RestauDetails(id: id,) );
    }
    else { return Center(child: Text('No Data'),) ;}
   
  }
}


///////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
///
//



class RestauDetails extends StatefulWidget {
 final String id ; 

RestauDetails({this.id}) ;
   
  @override
  _RestauDetailsState createState() => _RestauDetailsState();
}


class _RestauDetailsState extends State<RestauDetails> {
  @override
  Widget build(BuildContext context) {
     

final restaurants = Provider.of<List<Restaurant>>(context) ?? [] ;
    final client = Provider.of<Client>(context) ;
     final clientdata =client != null ? Provider.of<ClientData>(context) : null ;

     if(restaurants == [] || restaurants.isEmpty ) { return  Loading(color : 'purple') ;} else { 

  final  itrestaurant = restaurants.where((restaurant)=> restaurant.restauID == widget.id) ;
  
  final restaurant = itrestaurant.last;


 
// rating pannel 
    void  _showSettingsPanel( ) {
        showModalBottomSheet(context: context , builder: (context){
          return Container (
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10.0 ,horizontal: 30.0),
            child:StarFeedback(restaurant: restaurant,) ,
          );
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
                           child: Comments(id: widget.id, type: 'restaurant',)),
                          
                            CommentTextfield(name: clientdata.name,eventorrestau:restaurant ,type: 'restaurant',),
                          
                          SizedBox( height: MediaQuery.of(context).viewInsets.bottom, )
                        
                        ], )
                      ),
             
          
                 );
        });
      }    

     //    
final exist =clientdata != null ?  clientdata.restaurantLikes.contains(restaurant.restauID) : false ;

     ///  like button function
       void _pressLike(bool exist, Restaurant restaurant , ClientData clientData) {

       setState( () {
          if (exist== false) { DatabaseService(uid: client.clientid).restaurantLike(restaurant, clientData) ; }
         else {DatabaseService(uid: client.clientid).restaurantdisLike(restaurant, clientData) ; }
         });
  }

    final screenWidth = MediaQuery.of(context).size.width ;
    final screenHeight = MediaQuery.of(context).size.height ;

    return  Scaffold(
     // resizeToAvoidBottomPadding: true,
      body: Container(
        child:SingleChildScrollView(
          scrollDirection:Axis.vertical,
          child: Column(
            children: <Widget>[

              Stack(
                children: <Widget>[

                 

                  Container( width:screenWidth , height: screenHeight*0.35,
                    
                    child: Image.network(restaurant.imagepath ,fit: BoxFit.cover, colorBlendMode: BlendMode.darken,color: Color(0x79000000),)
                    ),
                    Positioned(
                      bottom: 20.0,
                      left: 20.0,
                      child:Column(
                        children: <Widget>[
                          Text(restaurant.name, style:TextStyle(fontSize: 30.0 , color: Colors.white,fontWeight: FontWeight.bold) ,),
                          Text(restaurant.adress, style:TextStyle(fontSize: 15.0 , color: Colors.white) ,)
                          ],
                          ) 
                        ),
                        
                         Column(
                           children: <Widget>[ SizedBox(height: 25,) ,
                             Row(
                      children: <Widget>[SizedBox(width: 10,) ,   GestureDetector(onTap: () { Navigator.pop(context) ; },
                        child: Icon(Icons.arrow_back_ios, color: Colors.white))],
                    ),
                           ],
                         ),
                ]
                ),

                Padding(
                  padding: const EdgeInsets.symmetric( horizontal: 20.0 , vertical: 15.0,) , 
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: <Widget>[

                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                       Row(
                         children: <Widget>[
                           Icon(FontAwesomeIcons.mapMarkerAlt),
                           SizedBox( width: 25.0,),
                            Text(restaurant.adress , style:categoryTextStyle.copyWith(color:Colors.black) ,) ,
                         ],
                       ),
                      
                       Container(
                         decoration: BoxDecoration(color: Colors.green[900] , borderRadius: BorderRadius.all(Radius.circular(10))),
                         constraints: BoxConstraints(maxHeight:35 ,maxWidth:40.0 ),
                         
                         child:Center(child: Text('${restaurant.rating}', style :TextStyle(color: Colors.white,fontSize: 18.0))),
                         ),

                        ],
                      ),

                      SizedBox( height :10.0,),


                      Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.clock) ,
                          SizedBox( width: 25.0,),
                          Text('Horaire : 9:00 - 22:30', style:categoryTextStyle.copyWith(color:Colors.deepPurple[400]) ,)
                        ],
                      ),

                      SizedBox( height :23.0,),

                       Text('Menu', style:categoryTextStyle.copyWith(color:Colors.deepPurple[400],fontSize: 25.0) ,) ,

                       SizedBox( height :20.0,),

                      // galleries view 
                       SingleChildScrollView(
                         scrollDirection: Axis.horizontal ,
                          child: Row(children: <Widget>[
                           for (final x in categories)  
                           Container(
                             margin: EdgeInsets.all(10.0),
                             constraints: BoxConstraints(maxHeight:120 ,maxWidth:80.0 ),
                             child: Image.asset('assets/menu.jpg')),
                         ],),
                       ),


                        SizedBox( height :20.0,),

                         SingleChildScrollView(
           scrollDirection: Axis.horizontal,
           child:Row(mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
            // SizedBox(width:15 ,) ,
             // Text('Categories :',  style: eventLocationTextStyle.copyWith(fontSize:25 ,fontWeight: FontWeight.w600 ,color: Colors.deepPurple[400]) ),
             for (final x in restaurant.restauCategories.where((x) => x != 'All'))
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

              SizedBox( height :20.0,),

                        Text('Rating', style:categoryTextStyle.copyWith(color:Colors.deepPurple[400] ,fontSize: 25.0) ,) ,

                        Container(
                          
                          child:Row(crossAxisAlignment: CrossAxisAlignment.center , mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            
                            GestureDetector(
                            
                            onTap:() { if ( client != null) { _pressLike( exist, restaurant ,clientdata) ;} } ,

                             child: Card(margin :EdgeInsets.all(20.0), 
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(children: <Widget>[
                                  Icon(FontAwesomeIcons.thumbsUp, color: exist == false ? Colors.black : Colors.blue ,),
                                  Text('Like',style:categoryTextStyle.copyWith(color:Colors.black54 ,fontSize: 12.0) ,) ,
                                  Text('${restaurant.numLikes} likes',style:categoryTextStyle.copyWith(color:Colors.black54 ,fontSize: 12.0) ,)
                                ],),
                              )
                              ,),
                            ) ,

                             GestureDetector( onTap: (){ if ( client != null ){_showComments();}},
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
                               onTap: () { _showSettingsPanel() ;},
                            
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






                    ]
              ),
                  ),
                ),
            ],
          ),
        ) ),
    )  ; }
  }
}