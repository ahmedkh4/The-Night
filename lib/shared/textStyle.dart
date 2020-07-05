import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:the_night/screens/Client/restaurantDetails/restau_details_page.dart';

final TextStyle fadedTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: Color(0x99FFFFFF),
);

final TextStyle whiteHeadingTextStyle = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
  color: Color(0xFFFFFFFF),
);

final TextStyle categoryTextStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  color: Color(0xFFFFFFFF),
);

final TextStyle selectedCategoryTextStyle = categoryTextStyle.copyWith(
  color: Color(0xFFFF4700),
);

final TextStyle eventTitleTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: Color(0xFF000000),
);

final TextStyle eventWhiteTitleTextStyle = TextStyle(
  fontSize: 38.0,
  fontWeight: FontWeight.bold,
  color: Color(0xFFFFFFFF),
);

final TextStyle eventLocationTextStyle = TextStyle(
  fontSize: 20.0,
  color: Color(0xFF000000),
);

final TextStyle guestTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w800,
  color: Color(0xFF000000),
);

final TextStyle punchLine1TextStyle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.w800,
  color: Colors.deepPurple[400],
);

final TextStyle punchLine2TextStyle = punchLine1TextStyle.copyWith(color: Color(0xFF000000));

const textInputDecoration =  InputDecoration(
        
        fillColor: Colors.white ,
        filled: true ,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 2.0)
        ),
        focusedBorder : OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue ,width: 2.0)
         ),
       );


class Loading extends StatelessWidget {
   String color ;
   Loading({this.color}) ;
  @override
  Widget build(BuildContext context) {
   
     return Scaffold(
          body: Container(
        child:Center(
          child: SpinKitChasingDots(color : color == "purple" ? Colors.deepPurple[400] : Colors.lightBlue[400] ),
          ) ,
        
      ),
    );
   
   
  }
}