import 'package:flutter/material.dart';
import 'package:the_night/models/categories.dart';
import 'package:the_night/screens/Client/RestauCollection/Restau_Card.dart';
import 'package:the_night/screens/Client/RestauCollection/backgroud.dart';
import 'package:the_night/screens/Client/restaurantsList/restau_list_content.dart';
import 'package:the_night/screens/Client/restaurantsList/restau_list_page.dart';




class RestaurantCollectionPage extends StatelessWidget {
 
 

 

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(),
      CustomScrollView(
  primary: false,
  slivers: <Widget>[
    SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 30 , horizontal: 5),
      sliver: SliverGrid.count(
        crossAxisSpacing: 0,
        mainAxisSpacing: 40,
        crossAxisCount: 2,
        children :<Widget>[ 
                
                
                for(final category in categories) 
                 GestureDetector(
                   child: RestauCard(category : category),
                   onTap: () {
                  Navigator.of(context).push(
                        MaterialPageRoute(
                           builder: (context) => RestauListPage(category: category,),
                       ),
                     );
                                  
                     },
                 ),
              
                
 ],
      ),
    ),
    ],
    ),
      ],
      );
      
    
  }
}
