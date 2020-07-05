import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_night/Services/auth.dart';
import 'package:the_night/models/client.dart';
import 'package:the_night/models/restaurant.dart';
import 'package:the_night/models/user.dart';
import 'package:the_night/screens/Client/appbar/appbar.dart';
import 'package:the_night/screens/Manager/new_event.dart';
import 'package:the_night/screens/authentication/authenticate.dart';
import 'package:the_night/screens/authentication/sign_in.dart';
import 'package:the_night/screens/authentication/wrapper.dart';





void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  StreamProvider<RestauManager>.value(
      value: AuthService().manager , 
      child : StreamProvider<User>.value(
        value: AuthService().user ,
        child : StreamProvider<Client>.value(
        value: AuthService().client ,
         child :MaterialApp(
          debugShowCheckedModeBanner: false,
          routes:{'singin' : (onctext) => SignInPage(), } , 
          home: Wrapper(),

      )
       
        ),
        
      ), 
      
     );
    
  
     
  }
}



      
      


      
