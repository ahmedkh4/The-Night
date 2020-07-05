import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_night/Services/database.dart';
import 'package:the_night/models/client.dart';
import 'package:the_night/shared/textStyle.dart';
import 'package:the_night/models/restaurant.dart';
import 'package:the_night/models/event.dart';




class Comments extends StatelessWidget {
   String id ;
   String type ; 
  Comments({this.id , this.type}) ;
  @override
  Widget build(BuildContext context) {

    final client = Provider.of<Client>(context) ;
   
   if (type =='restaurant') {
return StreamProvider<ClientData>.value(
   value: DatabaseService(uid: client.clientid).clientData, 
   child :StreamProvider<List<Restaurant>>.value(
   value: DatabaseService(uid: client.clientid ).restaurants,
   child:Coments(id: id,type: 'restaurant',) ));
   }

   else if (type =='event') {
return StreamProvider<ClientData>.value(
   value: DatabaseService(uid: client.clientid).clientData, 
   child :StreamProvider<List<Event>>.value(
   value: DatabaseService(uid: client.clientid ).events,
   child:Coments(id: id,type: 'event',) ));
   }

  }
}


class Coments extends StatefulWidget {
  String id ;
  String type ;
  
  Coments({this.id ,this.type}) ;
  @override
  _ComentsState createState() => _ComentsState();
}

class _ComentsState extends State<Coments> {
  @override
  Widget build(BuildContext context) {

    
    



     

 if ( widget.type == 'restaurant' ) {

  final restaurants = Provider.of<List<Restaurant>>(context) ?? [] ;
  final  itrestaurant = restaurants.where((restaurant)=> restaurant.restauID == widget.id) ;
  
  final restaurant = itrestaurant.last;
  
    return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
                
                child: Column(
            children: <Widget>[
              for (final comment in restaurant.comments )
             
              Column(
                children: <Widget>[
                   

                  Padding(
                    padding: const EdgeInsets.only(bottom:  8.0),
                    child: Comment(comment: comment ),
                  ),
                ],
              ),
            ],
          ),
       
        
      ),
    ); }

    else if ( widget.type == 'event') {
      final events = Provider.of<List<Event>>(context) ?? [] ;
       final  itevent = events.where((event)=> event.eventID == widget.id) ;
  
  final event = itevent.last;

    return Container(color: Colors.grey[100],
      child: SingleChildScrollView(
             scrollDirection: Axis.vertical,
              child: Column(
          children: <Widget>[
            for (final comment in event.comments )
            Comment(comment: comment,),
          ],
        ),
      ),
      
    ); }else {return  Loading(color : 'purple') ;}


  }
}



class Comment extends StatelessWidget {
  Commentaire comment ; 
  Comment({this.comment}) ;
  @override
  Widget build(BuildContext context) {
    return  Container(color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('${comment.name} :' , style: TextStyle(fontWeight: FontWeight.w700),),
             Text(' ${comment.body}'  ),
          ],
        )
        
      
    );
  }
}




class CommentTextfield extends StatefulWidget {
  String name ; 
  dynamic eventorrestau ;
  String type ;

  CommentTextfield({this.name, this.eventorrestau , this.type}) ;
  @override
  _CommentTextfieldState createState() => _CommentTextfieldState();
}
final _formKey = GlobalKey<FormState>() ;

class _CommentTextfieldState extends State<CommentTextfield> {

  String _textbody ; 
  @override
  Widget build(BuildContext context) {
final client = Provider.of<Client>(context) ;
    

    
     
    return   
             Container (
            
          child: Form(key:_formKey ,
                      child: Row(
                             children: <Widget>[

                                Expanded(
                                  
                                  child: TextFormField(
                        
                          decoration: textInputDecoration.copyWith(hintText: 'Comment ...', focusColor: Colors.deepPurple[400] ),
                          validator: (val) =>val.isEmpty ? 'Please pe a comment'  : null,
                          onChanged: (val) => setState(() => _textbody = val ),
                        ),
                                ),
                               Container(width: 70,height: 58,
                                 child: RaisedButton(color: Colors.white,
                                    child: Icon(Icons.send , color: Colors.deepPurple[400]),
                                    onPressed:() { 
                                      if ( _formKey.currentState.validate() )
                                     { if ( widget.type == 'restaurant')
                                      { DatabaseService(uid: client.clientid).addrestauComment(_textbody, widget.name, widget.eventorrestau);}
                                      else { DatabaseService(uid: client.clientid).addeventComment(_textbody, widget.name, widget.eventorrestau);}
                                      }} 
                                    ),
                               ),
                            //    SizedBox( height: MediaQuery.of(context).viewInsets.bottom, ),
                             ],
                           ),
          )
                      
                      
      
    ) ;
  }
}