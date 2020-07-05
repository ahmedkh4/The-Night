import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_night/Services/database.dart';
import 'package:the_night/models/event.dart';
import 'package:the_night/models/client.dart';
import 'package:the_night/models/restaurant.dart';

class StarFeedback extends StatefulWidget {
   
   Restaurant restaurant ; 
  StarFeedback({this.restaurant , }) ;

  @override
  _StarFeedbackState createState() => _StarFeedbackState();
}

class _StarFeedbackState extends State<StarFeedback> {
   
  var myFeedbackText = "COULD BE BETTER";
  var sliderValue =  0.0 ;
  IconData myFeedback1= FontAwesomeIcons.star,myFeedback2= FontAwesomeIcons.star,myFeedback3= FontAwesomeIcons.star,
      myFeedback4= FontAwesomeIcons.star,myFeedback5 = FontAwesomeIcons.star;
  Color myFeedbackColor1 = Colors.grey,myFeedbackColor2 = Colors.grey,myFeedbackColor3 = Colors.grey,
      myFeedbackColor4 = Colors.grey,myFeedbackColor5 = Colors.grey;

  @override
  Widget build(BuildContext context) {

     final client = Provider.of<Client>(context) ;
     
    return  Scaffold(
      body:  Column(
              children: <Widget>[
              
                SizedBox(height:10.0),
                Container(
                  child: Align(
                    child: Material(
                      color: Colors.white,
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(24.0),
                      
                      child: Container(
                          width: 350.0,
                          height: 300.0,
                          child: Column(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: StarWidget(),
                                  ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(child: Slider(
                                min: 0.0,
                                max: 5.0,
                                divisions: 5,
                                value: sliderValue !=0 ? sliderValue : 0.0,
                                activeColor: Colors.deepPurple,
                                inactiveColor: Colors.blueGrey,
                                onChanged: (newValue) {
                                  setState(() {
                                    sliderValue = newValue;
                                    if (sliderValue == 1.0 ) {
                                      myFeedback1 = FontAwesomeIcons.solidStar;
                                      myFeedbackColor1 = Colors.yellow;
                                    }
                                    else if (sliderValue < 1.0 ){
                                      myFeedback1 = FontAwesomeIcons.star;
                                      myFeedbackColor1 = Colors.grey;

                                    }
                                    if (sliderValue == 2.0 ) {
                                      myFeedback2 = FontAwesomeIcons.solidStar;
                                      myFeedbackColor2= Colors.yellow;
                                    }
                                    else if (sliderValue < 2.0 ){
                                      myFeedback2 = FontAwesomeIcons.star;
                                      myFeedbackColor2 = Colors.grey;

                                    }
                                    if (sliderValue == 3.0 ) {
                                      myFeedback3 = FontAwesomeIcons.solidStar;
                                      myFeedbackColor3 = Colors.yellow;
                                    }
                                    else if (sliderValue < 3.0 ){
                                      myFeedback3 = FontAwesomeIcons.star;
                                      myFeedbackColor3 = Colors.grey;

                                    }
                                    if (sliderValue == 4.0 ) {
                                      myFeedback4 = FontAwesomeIcons.solidStar;
                                      myFeedbackColor4 = Colors.yellow;
                                    }
                                    else if (sliderValue < 4.0 ){
                                      myFeedback4 = FontAwesomeIcons.star;
                                      myFeedbackColor4 = Colors.grey;

                                    }
                                    if (sliderValue == 5.0 ) {
                                      myFeedback5 = FontAwesomeIcons.solidStar;
                                      myFeedbackColor5 = Colors.yellow;
                                    }
                                    else if (sliderValue < 5.0 ){
                                      myFeedback5 = FontAwesomeIcons.star;
                                      myFeedbackColor5 = Colors.grey;

                                    }

                                  });
                                },
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(child: Text("Your Rating : $sliderValue",
                                style: TextStyle(color: Colors.black, fontSize: 22.0,fontWeight:FontWeight.bold),)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(child: Align(
                                alignment: Alignment.bottomCenter,

                                child: RaisedButton(
                                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                  color: Colors.deepPurple , 
                                  child: Text('Submit', style: TextStyle(color: Color(0xffffffff)),),
                                  onPressed: () { print('helooo'); if ( client != null ) {
                                         DatabaseService(uid : client.clientid).restaurantrating( widget.restaurant ,sliderValue.truncate() )  ;  print(client.clientid) ;
                                         Navigator.pop(context);}
                                          },
                                ),
                              )),
                            ),
                          ],)
                      ),
                    ),
                  ),
                ),
              ],
            ),
       
    );
  }

  List<Widget> StarWidget(){
    List<Widget> myContainer = new List();
    myContainer.add(Container(child: Icon(
      myFeedback1, color: myFeedbackColor1, size: 50.0,)));
    myContainer.add(Container(child: Icon(
      myFeedback2, color: myFeedbackColor2, size: 50.0,)));
    myContainer.add(Container(child: Icon(
      myFeedback3, color: myFeedbackColor3, size: 50.0,)));
    myContainer.add(Container(child: Icon(
      myFeedback4, color: myFeedbackColor4, size: 50.0,)));
    myContainer.add(Container(child: Icon(
      myFeedback5, color: myFeedbackColor5, size: 50.0,)));
    return myContainer;

  }
 
}