import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart'; 
import 'package:the_night/models/categories.dart';


class Quiz extends StatefulWidget {
   int step  ;
    int score  ;
    Quiz({this.step , this.score}) ;
  @override
  _QuizState createState() => _QuizState();
}

TextStyle style1 =  TextStyle(color:Colors.black, fontSize: 20 , fontWeight: FontWeight.w700,) ;
TextStyle style2 = TextStyle(color:Colors.lightBlue[400], fontSize: 20 , fontWeight: FontWeight.w700,) ;
TextStyle style3 =  TextStyle(color:Colors.deepPurple[400], fontSize: 20 , fontWeight: FontWeight.w700,);

   

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    
  final appState = Provider.of<AppState>(context);
    

print('selected in quiz = ${appState.selectedCategory}');

return  Column( children: <Widget>[



    if (widget.step == 0) 
      Padding(
        padding: const EdgeInsets.only(top :100),
        child: Container( child :Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          
          children: <Widget>[
            GestureDetector(onTap: () {setState(() {
            widget.score=  widget.score+=1 ;widget.step = widget.step+=1 ; 
            }); },
              child: Container(child : Column( children: <Widget>[Image.network( 'https://firebasestorage.googleapis.com/v0/b/the-night-7eb38.appspot.com/o/quiz%2Fperson.png?alt=media&token=a5c035ff-184d-4fcb-aad8-1a0b50271dbc',width: 90, height: 90, ),
            SizedBox(height: 15), Text('Single', style: style1,),] ), )),

            GestureDetector(onTap: () { setState(() {
             widget.score= widget.score+=3 ;widget.step= widget.step+=1 ; 
            }); },
              child: Container(child : Column( children: <Widget>[ Image.network('https://firebasestorage.googleapis.com/v0/b/the-night-7eb38.appspot.com/o/quiz%2Flove.png?alt=media&token=51c81a93-eda9-4399-b282-5ff8c0bffd09' ,width: 90, height: 90, ),
             SizedBox(height: 15),Text('Couple', style: style2,),] ) )),

            GestureDetector(onTap: () { setState(() {
             widget.score= widget.score+=5 ;widget.step= widget.step+=1 ; 
            }); },
              child: Container(child : Column( children: <Widget>[ Image.network('https://firebasestorage.googleapis.com/v0/b/the-night-7eb38.appspot.com/o/quiz%2Ffriends.png?alt=media&token=803e188d-6bb1-442d-ae16-83c128dae98d',width: 90, height: 90, ), 
            SizedBox(height: 15),Text('Friends', style: style3,),] ) )),
           ],
        ),
        
    ),
      )
    else if ( widget.step == 1) 
       Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Container(child :Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[ 
            GestureDetector(onTap: () {setState(() {
            widget.score=  widget.score+=1 ;widget.step = widget.step+=1 ; 
            }); },
              child: Container(child : Column( children: <Widget>[ Image.network('https://firebasestorage.googleapis.com/v0/b/the-night-7eb38.appspot.com/o/quiz%2Fheart.png?alt=media&token=f78e7a63-7ac9-453a-8ec1-1e97407392df',width: 90, height: 90,),
            SizedBox(height: 15), Text('Cofe', style: style1)] ) )),

            GestureDetector(onTap: () { setState(() {
             widget.score= widget.score+=3 ;widget.step= widget.step+=1 ; 
            }); },
              child: Container(child : Column( children: <Widget>[ Image.network('https://firebasestorage.googleapis.com/v0/b/the-night-7eb38.appspot.com/o/quiz%2Fpizza.png?alt=media&token=9d976640-86c4-4b54-ba71-5bbaad661267',width: 90, height: 90,),
             SizedBox(height: 15),Text('Food', style: style2,),] ) )),

            GestureDetector(onTap: () { setState(() {
             widget.score= widget.score+=5 ;widget.step= widget.step+=1 ; 
            }); },
              child: Container(child : Column( children: <Widget>[ Image.network('https://firebasestorage.googleapis.com/v0/b/the-night-7eb38.appspot.com/o/quiz%2Fdrink.png?alt=media&token=3b542fae-56b5-4e9e-9d9a-22e022816bdd',width: 90, height: 90,),
            SizedBox(height: 15), Text('Drinks', style: style3,),] ) )),
          ],
        ),
        
    ),
      )
    
    else if (widget.step == 2) 
       Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Container(child :Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(onTap: () {setState(() {
            widget.score=  widget.score+=1 ;widget.step = widget.step+=1 ; 
            }); },
              child: Container(child : Column( children: <Widget>[ Image.network('https://firebasestorage.googleapis.com/v0/b/the-night-7eb38.appspot.com/o/quiz%2Felectric-guitar.png?alt=media&token=bb6bea7d-1090-4007-9f1a-d2b008726afa' ,width: 90, height: 90,),
            SizedBox(height: 15), Text('Band', style: style1,),] ) )),

            GestureDetector(onTap: () { setState(() {
             widget.score= widget.score+=3 ;widget.step= widget.step+=1 ; 
            }); },
              child: Container(child : Column( children: <Widget>[ Image.network('https://firebasestorage.googleapis.com/v0/b/the-night-7eb38.appspot.com/o/quiz%2Fpodcast.png?alt=media&token=af787c2c-0753-4efe-a96f-e08c7c6843f6' ,width: 90, height: 90,), 
            SizedBox(height: 15),Text('Karaoke', style: style2),] ) )),

            GestureDetector(onTap: () { setState(() {
             widget.score= widget.score+=5 ;widget.step= widget.step+=1 ; 
            }); },
              child: Container(child : Column( children: <Widget>[ Image.network('https://firebasestorage.googleapis.com/v0/b/the-night-7eb38.appspot.com/o/quiz%2Fparty.png?alt=media&token=f5235df9-2a9b-4eb6-b9d5-26263ff9ddc3' ,width: 90, height: 90,), 
           SizedBox(height: 15), Text('DJ', style: style3,),] ) )),
           ],
        ),
        
    ),
      )
    
    else 
       Padding(
         padding: const EdgeInsets.only(  top: 100.0),
         child: Container( child: Column( children: <Widget>[
          if ( widget.score > 0 && widget.score <= 6 )
          Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[ Text('Quiz Result' ,style:style1) ,SizedBox(height:20 ,),
               Padding( padding:  EdgeInsets.all(15) ,child: Text('you are into a calm night we suggest the LOUNGE category' ,style:style1 , textAlign: TextAlign.center,)) , SizedBox(height:20 ,) ,
              RaisedButton(onPressed:(){ setState(() { appState.updateCategory('lounge') ; Navigator.pop(context); });} ,
             color: Colors.white ,
              shape : RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(14)
                     ),
             child: Text('Check Quiz Result', style: style1,),
              )
            ],
          ),

           if ( widget.score >= 7 && widget.score <= 12 )
           Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[ Text('Quiz Result' ,style:style2) ,SizedBox(height:20 ,),
               Padding( padding: const EdgeInsets.all(15),child: Text('you are into a fun night we suggest the TECHNO category' ,style:style2, textAlign: TextAlign.center,),
               ) , SizedBox(height:20 ,) ,
              RaisedButton(onPressed:(){ setState(() { appState.updateCategory('techno') ; Navigator.pop(context); });} ,
             color: Colors.white ,
              shape : RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)
                          ),
             child: Text('Check Quiz Result', style: style2,),
              )
            ],
          ),

          if ( widget.score >= 13 && widget.score <=15 )
          Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Text('Quiz Result' ,style:style3) ,SizedBox(height:20 ,),
               Padding(padding: const EdgeInsets.all(15), child: Text('you are into a Wild night we suggest the DISCO category' ,style:style3, textAlign: TextAlign.center,),
               ) , SizedBox(height:20 ,) ,
              RaisedButton(onPressed:(){ setState(() { appState.updateCategory('disco') ; Navigator.pop(context); });} ,
             color: Colors.white ,
            shape : RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)
                          ),
             child: Text('Check Quiz Result', style: style3,),
              )
            ],
          ),

      ],),
      
    ),
       )
    
] );
  }
}