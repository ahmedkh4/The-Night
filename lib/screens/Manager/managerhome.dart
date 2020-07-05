import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_night/Services/auth.dart';
import 'package:the_night/Services/database.dart';
import 'package:the_night/models/restaurant.dart';
import 'package:the_night/screens/Manager/myevents.dart';
import 'package:the_night/screens/Manager/new_event.dart';
import 'package:the_night/screens/Manager/profile.dart';




class ManagerHomePage extends StatefulWidget {
  @override
  _ManagerHomePageState createState() => _ManagerHomePageState();
}
final AuthService _auth = AuthService() ;

class _ManagerHomePageState extends State<ManagerHomePage> {

  
  
  @override
  Widget build(BuildContext context) {

    final manager = Provider.of<RestauManager>(context) ;
    void onlogin() async {
    
    Restaurant restaurant0 = Restaurant(adress:'' ,name:'' , numLikes: 0 , rating: 0   , restauCategories:['all']  ) ;
                              
    await DatabaseService(uid: manager.restauID).firstlogin(restaurant0) ;
    print('senpaaai !!! ') ;
  }

    return  DefaultTabController(
            length: 3,
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
                            Colors.lightBlue[900],
                            Colors.blue[500],
                      ],
                    ),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TabBar(
                            isScrollable: true,
                            tabs:  [ 
                              Tab(
                                text: 'Home',
                                icon: Icon(Icons.home),
                              ),
                              Tab(
                                text: 'Add Event',
                                icon: Icon(Icons.plus_one),
                              ),
                              Tab(
                                text: 'Profile',
                                icon: Icon(Icons.view_agenda),
                              ),
                            ] ,
                             
                          
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () { _auth.signOut();},
                        child:Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Icon(Icons.exit_to_app , size: 30, color: Colors.lightBlue[50],),
                        ),
                          
                            ),
                    
                    ],
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
    return TabBarView(

      children: <Widget>[
        MyEvents() , 
        NewEvent() , 
        Profile() , 

        
      ],
           
            );
  }
}



      

      
