import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_night/Services/auth.dart';
import 'package:the_night/screens/Client/appbar/appbar.dart';
import 'package:the_night/screens/authentication/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService() ;
    return  
       Container(
            decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/backgroud.jpg'),
                fit: BoxFit.cover
              )
            ),
      
            child : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
               Padding(
                 padding: const EdgeInsets.only(top:40 , left: 220 ),
                 child: Row(
                   
                  crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                    Row(
                      children: <Widget>[
                        RaisedButton( color: Colors.transparent,
                          onPressed: ()async { dynamic result = await _auth.signInAnon() ;
                          if (result == null) { print('eror') ;}
                            }
                         ,  
                          child: Text('skip this' ,style:TextStyle( fontSize: 20.0 ,color: Colors.deepPurple), ),
                         
                        ),Icon( Icons.arrow_forward ,color:Colors.deepPurple ) ,
                      ],
                    ),

                   ],
                 ),
               ) , 

                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 500),
                      child : Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
           
                        RaisedButton.icon(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)
                          ),
                          color: Colors.deepPurple,
                          onPressed: () { _auth.fblogin() ;} , 
                          icon:Icon( FontAwesomeIcons.facebook ,color:Colors.black ) ,
                           label: Text('Facebook' ,style:TextStyle( fontSize: 20.0 ,color: Colors.black), )
                        ),

                        SizedBox(width: 50,) ,

                        RaisedButton.icon(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)
                          ),
                          color: Colors.deepPurple ,
                          onPressed: () { _auth.fblogin() ;}  , 
                          icon:Icon( FontAwesomeIcons.google ,color:Colors.black ), 
                           label: Text('google' ,style:TextStyle( fontSize: 20.0 ,color: Colors.black) , )
                        ),

                           ],
                             )
                      ),

                      SizedBox(height: 20,) ,

                      Container(
                        child:Center(
                          child:RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)
                          ),
                          color: Colors.lightBlue[900] ,
                          onPressed:() {
                             Navigator.pushNamed( context ,'singin')  ;
                            }, 
                           child: Text('The Night Manager' ,style:TextStyle( fontSize: 20.0 ,color: Colors.black) , )
                        ), 
                        ) ,
                      ),


                  ],
                ),
              ],
            ),

       
         

     

    );
  }
}