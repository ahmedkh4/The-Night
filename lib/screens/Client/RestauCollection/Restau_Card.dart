import 'package:flutter/material.dart';
import 'package:the_night/models/categories.dart';

class RestauCard extends StatelessWidget {
  const RestauCard({Key key, this.category}) : super(key: key);
  final Category category ; 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(
        Radius.circular(10.0), ),

            child: Stack(
              children: <Widget>[
                Container(
                  height: 200.0,
                  width: 130.0,
                  child: Image.asset(category.imagepath, fit: BoxFit.cover,),
                ),
               
                Positioned(
                  left: 10.0,
                  bottom: 15.0,
                  right: 10.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            category.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16.0),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            ' ${category.count} Place',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 12.0),
                          ),
                        ],
                      ),
                     
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
            
        
          
      
        
        
  }
}