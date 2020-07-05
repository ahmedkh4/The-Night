import'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_night/models/client.dart';
import 'package:the_night/models/restaurant.dart';
import 'package:the_night/models/user.dart';
import 'package:the_night/Services/database.dart';


class ListTileRest extends StatefulWidget {

 
  const ListTileRest({Key key, this.restaurant , }) : super(key: key);
  final Restaurant restaurant ; 
  @override
  _ListTileRestState createState() => _ListTileRestState();
}

class _ListTileRestState extends State<ListTileRest> {

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }


  


   
  @override
  Widget build(BuildContext context) {

    final client = Provider.of<Client>(context) ;
     final clientdata =client != null ? Provider.of<ClientData>(context) : null ;

     ///  like button function
       void _pressLike(bool exist, Restaurant restaurant , ClientData clientData) {

       setState( () {
          if (exist== false) { DatabaseService(uid: client.clientid).restaurantLike(restaurant, clientData) ; }
         else {DatabaseService(uid: client.clientid).restaurantdisLike(restaurant, clientData) ; }
         });
  }

     //    
final exist =clientdata != null ?  clientdata.restaurantLikes.contains(widget.restaurant.restauID) : false ;
     
    return Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                      height: 170.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[300],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 120.0,
                                  child: Text(
                                    widget.restaurant.name,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[

                                    GestureDetector( onTap: (){ if ( client != null) {_pressLike( exist, widget.restaurant ,clientdata) ;} },
                                      child: Icon(FontAwesomeIcons.thumbsUp,  color: exist == false ? Colors.black : Colors.blue ,)) , 
                                    SizedBox(height:5 ,),
                                    Text('${widget.restaurant.numLikes} Likes',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,),
                                    ),
                                    
                                  ],
                                ),
                              ],
                            ),

                            Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.mapMarkerAlt , size: 20, ) ,
                                SizedBox(width: 5.0),
                                Text(
                                  widget.restaurant.adress ,
                                  style: TextStyle(   color: Colors.white,  fontSize: 14,  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),

                            _buildRatingStars(widget.restaurant.rating),

                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  width: 70.0,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'time',
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  width: 70.0,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50] ,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'start ',
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20.0,
                      top: 15.0,
                      bottom: 15.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network( widget.restaurant.imagepath, fit: BoxFit.cover,width: 110,),
                      ),
                    ),
                  ],
                );
  }
}




