

import'package:flutter/material.dart';
import 'package:the_night/models/event.dart';
import 'package:the_night/models/menu.dart';
import 'package:the_night/screens/Client/RestauCollection/restau_collection_page.dart';
import 'package:the_night/screens/Client/favorites/favorite_page.dart';
import 'package:the_night/screens/Client/home/events_home_page.dart';






const List<Choice> choices = <Choice>[
  Choice(title: 'Home', icon: Icons.home),
  Choice(title: 'Collection', icon: Icons.assignment_returned),
  Choice(title: 'Favorite', icon: Icons.favorite_border,) ,
  
];

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: choices.length,
        child: Scaffold(
            appBar:  PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                        Colors.purple[500],
                        Colors.deepPurple,
                  ],
                ),
              ),
              child: TabBar(
                isScrollable: true,
                tabs: choices.map<Widget>((Choice choice) {
                  return Tab(
                    text: choice.title,
                    icon: Icon(choice.icon),
                  );
                }).toList(),
              ),
            ),
           ),
          body: TabView(),
    ),
    );
          
  }
}

class TabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   Event event ; 
    return TabBarView(

      children: <Widget>[
        EventsHomePage() ,
        RestaurantCollectionPage() ,
        Favorite(),
        
        
        
      ],
           
            );
  }
}