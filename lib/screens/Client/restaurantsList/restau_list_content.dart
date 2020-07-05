import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_night/Services/database.dart';
import 'package:the_night/models/categories.dart';
import 'package:the_night/models/restaurant.dart';
import 'package:the_night/models/user.dart';
import 'package:the_night/screens/Client/restaurantDetails/restau_details_page.dart';
import 'package:the_night/screens/Client/restaurantsList/background.dart';
import 'package:the_night/screens/Client/restaurantsList/list_tile.dart';


class DestinationScreen extends StatelessWidget {
  
   DestinationScreen({Key key, this.category }) : super(key: key);
  final Category category ;
  
 

  
  @override
  Widget build(BuildContext context) {
    
    final restaurants =Provider.of<List<Restaurant>>(context) ?? [] ;

         
           return SingleChildScrollView(
             scrollDirection: Axis.vertical,
                    child: Container(
               
                      child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10 , bottom: 15),
                      child: Container(
                        height: 70,
                       child : Row(crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[

                          SizedBox(width:25 , ),

                          GestureDetector(
                            onTap:() {
                          Navigator.of(context).pop(true) ;
                             }, 
                            child: Icon(Icons.arrow_back , color: Colors.white,size: 40,)) ,

                          SizedBox(width:20 , ), 

                          Text( category.name , style: TextStyle(color : Colors.white , fontSize: 35),)

                          ],
                          )
                      ),
                    ),
                    ///  List view builder 
                    Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          
                          children:<Widget>[
                            for( final restau in restaurants.where( (restau)=>  restau.restauCategories.contains(category.name)) ) 
                            Padding(
                              padding: EdgeInsets.only(top:10 , bottom: 15 ),
                              child: GestureDetector(
                                onTap:  () {
                                 Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => RestauDetailedPage(id:restau.restauID ,), ),
                               );
                               }, 
                                child: ListTileRest(restaurant: restau)) ,
                              ) ,

                          ], 
                           
                        ),
                      ),
                    ),



      
                  ],
                ),
     
    ),
    

           );
        
      
  
  }
}

