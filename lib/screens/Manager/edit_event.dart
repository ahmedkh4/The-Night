

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:the_night/Services/database.dart';
import 'package:the_night/models/categories.dart';
import 'package:the_night/models/event.dart';
import 'package:the_night/models/restaurant.dart';
import 'package:the_night/shared/textStyle.dart';


class Edit extends StatefulWidget {

 
 final Event event ;
 Edit({ this.event}) ;
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {

 // liste des categories 
List<String> selectedcategories = ['All'] ;

// convert from 'TimeOfDay' to 'String'
  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.Hm();  
    return format.format(dt);
}

Future  getImage( ) async{
var image =  await ImagePicker.pickImage(source: ImageSource.gallery) ;
setState(() {
   _image = image  ; 
});
}

final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
// final DateFormat timeFormat = DateFormat.Hm();
final _formKey = GlobalKey<FormState>() ; 
String _currentName ; 
String _currentDesc ; 
String _currentBand ; 
DateTime _date;
TimeOfDay _time ; 
File _image ; 
String msg ='' ;

// add and remove categories funcion

   void _onCategorySelected(bool selected,String category_name) {
    if (selected == true) {
      setState(() {
        selectedcategories.add(category_name);
      });
    } else {
      setState(() {
        selectedcategories.remove(category_name);
      });
    }
  }
  


  @override
  Widget build(BuildContext context) {

    final manager = Provider.of<RestauManager>(context) ;
    final restaurant = Provider.of<Restaurant>(context) ;
   

          int numlikes =  widget.event.numLikes ;
          double rating =  widget.event.rating ;
        return Scaffold(
              body: Container(
            padding: EdgeInsets.symmetric(horizontal:20  , vertical:20 ),
            child: Form(
              key:_formKey ,
              child: SingleChildScrollView(
                scrollDirection:Axis.vertical,
                        child: Column(
                  
                  children: <Widget>[
                    SizedBox(height: 20,),
                    Row(
                      children: <Widget>[GestureDetector(onTap: () { Navigator.pop(context) ; },
                        child: Icon(Icons.arrow_back_ios, color: Colors.lightBlue[800]))],
                    ),
                    SizedBox(height: 20,),

                    Center(child: Text('Edit Event' , style:TextStyle(fontSize: 20.0 , color: Colors.lightBlue[800]) , )) ,

                    SizedBox(height: 35,) ,

                     TextFormField(
                       initialValue: widget.event.name ,
                            decoration: textInputDecoration ,
                            validator: (val) =>val.isEmpty ? 'Please enter a name'  : null,
                            onChanged: (val) => setState(()  {if (val == null ) {  _currentName =widget.event.name ; } else {_currentName =val ; }}
                            ),
                          ),

                    SizedBox(height: 25,) ,

                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[

                           RaisedButton(
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)
                               ),
                              color: Colors.lightBlue[700] ,
                              onPressed:  () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: _date == null ? DateTime.now() : _date,
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime(2022)
                                        ).then((date) {
                                          setState(() {
                                            _date = date;
                                          });
                                        });
                                      }, 
                              child: Text(_date == null ? 'Pick up a date' : dateFormat.format(_date), )
                           ),

                           RaisedButton(
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)
                               ),
                              color: Colors.lightBlue[700] ,
                              onPressed:  () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: _time == null ? TimeOfDay.now() : _time ,
                                        ).then((time) {
                                          setState(() {
                                            _time = time;
                                          });
                                        });

                                      }, 
                              child: Text(_time == null ? 'Pick up a time' : formatTimeOfDay(_time)   )
                           ), 



                        ],
                      ),

                    SizedBox(height: 35,) ,

                    //  imagePicker ( raisedbutton / ClipRRect )
                    Container (
                      child:  _image == null ? RaisedButton(
                      shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)
                               ),
                              color:_image==null ? Colors.lightBlue[700] : Colors.transparent ,
                              child: Text(_image==null ? 'pick Image' : '' ),
                      onPressed:() {
                        getImage() ;} 
                      ) : ClipRRect( 
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.file( _image , height: 170, fit: BoxFit.fill, ),
                      )  ,
                   
                    
                       ),

                     SizedBox(height: 35,) ,

                     TextFormField(
                       initialValue: widget.event.band ,
                            decoration: textInputDecoration.copyWith(hintText: 'Event Band'),
                            validator: (val) =>val.isEmpty ? 'Please enter a Ban name'  : null,
                            onChanged: (val) => setState(()  {if (val == null ) {  _currentBand =widget.event.band ; } else {_currentBand =val ; }}
                            ),
                          ),

                  SizedBox(height: 35,) ,

                     TextFormField(
                       initialValue: widget.event.description1 ,
                            decoration: textInputDecoration,
                            validator: (val) =>val.isEmpty ? 'Please enter a Description'  : null,
                            onChanged: (val) => setState(()  {if (val == null ) {  _currentDesc =widget.event.description1 ; } else {_currentDesc =val ; }}
                              ),
                          ),

                      SizedBox(height: 25,) , 

                  Center(child: Text('Categories' , style:TextStyle(fontSize: 18.0 , color: Colors.lightBlue[800]) , )) ,

                  SizedBox(height: 25,) , 

                  Container(
                    height: 270,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: categories.length,
                      itemBuilder: (context , index ) {
                        Category category = categories[index] ;
                        return Container(
                          child: CheckboxListTile(
                            title: Text(category.name)  ,
                            value:selectedcategories.contains(category.name), 
                            onChanged: (bool value ) {
                              _onCategorySelected(value,category.name );
                            } ,
                            ),
                        ) ;   
                      }
                    ), ) ,        

                  SizedBox(height: 35,) ,  

                     


                   RaisedButton.icon(
                     shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14) ),
                              color: Colors.lightBlue[900] ,
                      icon: Icon(Icons.add , color: Colors.white ) , 
                      label: Text( 'Edit ' , style:TextStyle(color:Colors.white , fontSize: 20 , fontWeight: FontWeight.w500) ,),
                      
                      onPressed: () async{
                        if (_formKey.currentState.validate() && _image != null ) {
                        
                         Event event1 = Event( name: _currentName ?? widget.event.name , description1: _currentDesc ?? widget.event.description1 , band: _currentBand ?? widget.event.band,  eventID: widget.event.eventID, eventCategories: selectedcategories, comments: widget.event.comments,
                         time: formatTimeOfDay(_time) , date: dateFormat.format(_date) ,rating: rating ,numLikes: numlikes , location: restaurant.name )  ; 
                   
                         await DatabaseService(uid : manager.restauID).editeventAndImage(event1 ,_image) ;
                         setState(() {
                           msg =  'successfull edit' ;
                         });
                        }

                      },
                      ) , 
                      SizedBox(height: 10,) ,

                      Text(msg , style:TextStyle(color: Colors.green, fontSize: 16) , )  ,





                  ],


                  

                ),
              ) ,
             ),
            
          ),
        );
       
  }
} 