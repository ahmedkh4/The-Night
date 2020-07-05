import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_night/Services/auth.dart';
import 'package:the_night/Services/database.dart';
import 'package:the_night/models/restaurant.dart';
import 'package:the_night/screens/Manager/managerhome.dart';


class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _toggleVisibility = true;

    //text field state 
  String email = '' ; 
  String password = '' ;
  String error ='' ;

//  authentification obj and form key
   final AuthService _auth = AuthService() ;
  final _formKey = GlobalKey<FormState>() ;

  Widget _buildEmailTextField() {
    return TextFormField(style :TextStyle ( color : Colors.lightBlue[700]) ,
      decoration: InputDecoration(hintText: "E-mail",
        hintStyle: TextStyle( color: Colors.lightBlue[900], fontSize: 20.0,),
      ),
      validator: (val) => val.isEmpty ? 'enter an Email' : null,
      onChanged: (val) {
                  setState(() => email = val );
                }
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField( style :TextStyle ( color : Colors.lightBlue[700]) ,
      decoration: InputDecoration( hintText: "Password",
        hintStyle: TextStyle(color: Colors.lightBlue[900],fontSize: 20.0,),
        suffixIcon: IconButton( 
          color: Colors.lightBlue[900],
          onPressed: () {
            setState(() {
              _toggleVisibility = !_toggleVisibility;
            });
          },
          icon: _toggleVisibility
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
        ),
      ),
      obscureText: _toggleVisibility,
      validator: (val) => val.isEmpty ? 'enter a Password' : null,
       onChanged: (val) {
                  setState(() => password = val );
                }
    );
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
          image :  AssetImage('assets/signinback.jpg'),
           fit: BoxFit.cover ,)
        ),

        child: Form(
          key: _formKey ,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("The Night Manager",
                  style: TextStyle( fontSize: 30.0,fontWeight: FontWeight.bold, color: Colors.lightBlue[900] , ),
                ),

                SizedBox( height: 100.0, ),
               

                

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    
                    child: Padding(
                      padding: EdgeInsets.symmetric(  horizontal: 45),
                      child: Column(
                        children: <Widget>[

                          _buildEmailTextField(),
                          SizedBox(height: 20.0,),
                          _buildPasswordTextField(),

                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox( height: 30.0, ),

                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)
                    ),
                  child: Text('sing in'),
                  color: Colors.lightBlue[900] ,
                   onPressed: () async {
                    if( _formKey.currentState.validate() ){
                     dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                     
                      if (result == null ) {
                       setState(() {  
                         error = 'could Not sign IN'; 
                         print(error) ;
                         });
                      }else  { Navigator.pop(context) ; 
                     
                       }
                    } 
                  } ,
                  ),
                  SizedBox( height: 10.0, ),

                  Text(error , style: TextStyle(color: Colors.red ,) ) , 
                
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}