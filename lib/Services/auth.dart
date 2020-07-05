import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_night/Services/database.dart';
import 'package:the_night/models/client.dart';
import 'package:the_night/models/restaurant.dart';
import 'package:the_night/models/user.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;


class AuthService {   

  


 final FirebaseAuth _auth = FirebaseAuth.instance ;

 

  

 

 // create manager user obj based on firebase user   (  for  Manager ) 

   RestauManager _managerFromFirebaseuser(FirebaseUser manager ) {
       if (manager != null ) {
  return RestauManager(restauID: manager.uid) ; 
    }else {return null ;}
   //  return manager != null && manager.isEmailVerified   ? RestauManager(restauID: manager.uid) : null ;
  }

 // create manager user obj based on firebase user   (  for  Manager ) 


  
 


  // create  user obj based on firebase user   (  for  user ) 

  User _userFromFirebaseuser(FirebaseUser user ) {

    if (user != null && user.isAnonymous) {
  return User(userID: user.uid ) ; 
    }else {return null ;}
    
   // return user != null  ? User(userID: user.uid ) : null ;
  }

 ////////////////////////////////////////////////////////// Streams  ///////// 

  
  //auth change Manager user stream   (  for  Manager)

    Stream <RestauManager> get manager   {
    
    return _auth.onAuthStateChanged
    
     .map(_managerFromFirebaseuser ) ;
   
   
  }

  



   //auth change user user stream   (  for  user)

  Stream<User> get user {
   
    return  _auth.onAuthStateChanged
   // oR .map((FirebaseUser user) => _userFromFirebaseuser (user)
   .map(_userFromFirebaseuser) ;
  }


  //////////////////////////////////////////////////////////////



// Restau Manager  sign in with email & password (  for  Manager)

  Future signInWithEmailAndPassword(String email , String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email : email , password : password) ;
      FirebaseUser user = result.user ;
    
    
      return _managerFromFirebaseuser(user  ) ;
    } catch (e) {
      print(e.toString() ) ;
      return null ; 
    }
  }



///////////////////////////////////// anonym /////////////////////// 

  // sign in anonym 
  Future signInAnon() async {
    try { 
     AuthResult result = await _auth.signInAnonymously();
     FirebaseUser user = result.user ; 
    
     return _userFromFirebaseuser(user) ;

    } catch (e) {
      print(e.toString()) ;
      return null ;
    }
  }



/////////////////////////////////////////////////////////////
 // sign in using google 

/*GoogleSignIn googleAuth = GoogleSignIn() ;

Future _singInWithGoogle () async {

  await googleAuth.signIn().then( (result) {
    result.authentication.then((googleKey)  {
      FirebaseAuth.instance.SingInWithGoogle {
        idToken : googleKey

      }
    })
  })
}**/

 //////////////////////////////////////////////////// facebook login /////// 
 
 Client _fromfbusertoclient( FirebaseUser client ) {
   if (client != null && client.displayName.isNotEmpty) {
     
     return  Client( clientid: client.uid) ;
   }else { return null ;}
   
 }


 
///facebook login function 

FacebookLogin facebookSignIn = FacebookLogin() ;

 Future  fblogin() async {
    final FacebookLoginResult result =
        await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
      final  token = result.accessToken.token;
      AuthCredential credential= FacebookAuthProvider.getCredential(accessToken: token);
       AuthResult userresult = await _auth.signInWithCredential(credential);
      FirebaseUser client = userresult.user ;
      // print(client.toString()) ;

       
      //  final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
      //  final profile = JSON.jsonDecode(graphResponse.body);
        print('Login successfully.');
        ClientData clientData = ClientData(clientid: client.uid , name: client.displayName , eventLikes: [] , restaurantLikes: []) ;
        DatabaseService(uid:client.uid ).firstloginfb(clientData) ;
      //  print(profile.toString());
       return _fromfbusertoclient(  client) ;
        break;

      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        return null ;
        break;

      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        return null ;    
        break;
    }
  }

  Future fblogOut() async {
    await facebookSignIn.logOut();
    print('Logged out.');
  }



      


   //auth change user clientuser stream   (  for  client)

  Stream<Client> get client {
   
    return  _auth.onAuthStateChanged
   // oR .map((FirebaseUser user) => _userFromFirebaseuser (user)
   .map(_fromfbusertoclient) ;
  }



  // sign out 

    Future signOut() async {

      try {
        return await _auth.signOut() ; 
        
      } catch (e) {
        print(e.toString() ) ; 
        return null ; 
      }
    }









}






















     
