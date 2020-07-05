
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:the_night/Services/auth.dart';
import 'package:the_night/models/categories.dart';
import 'package:the_night/models/restaurant.dart';
import 'package:the_night/shared/textStyle.dart';
import 'package:the_night/Services/database.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

// form key
final _formKey = GlobalKey<FormState>() ; 
// profile image ; 
File _image ; 
// liste des images 
List<Asset> images = List<Asset>(); 
// message d'erreur 
String _error = 'No Error Dectected';
// liste des categories 
List<String> selectedcategories = ['All'] ;

class _ProfileState extends State<Profile> {

  String _currentName ;
  String _currentLocation ; 
  String msg ='' ; 




Widget buildGridView() {
    return Container(
      height: images.length == 0 ? 0 : 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: ( context , index ) {
          Asset asset = images[index] ;
          print(asset.identifier) ;

          return Container(
            padding: const EdgeInsets.symmetric( horizontal: 10),
            child: AssetThumb(
              asset: asset,
              width: 90, 
              height: 150
              ),
          ) ;
        }
        
         
         
          ),
    ) ;
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
     if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }    

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
  
  // single image picker
  Future  getImage( ) async{
var image =  await ImagePicker.pickImage(source: ImageSource.gallery) ;
setState(() {
   _image = image  ; 
});
}
//////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////// Context //////////////////////////////////////////

  @override
  Widget build(BuildContext context) {

    final manager = Provider.of<RestauManager>(context) ;

    final screenHeight = MediaQuery.of(context).size.height ;
    final screenWidth = MediaQuery.of(context).size.width ;

    return StreamBuilder<Restaurant>(
      stream: DatabaseService(uid:manager.restauID ).restaurant ,
      builder: (context, snapshot) {

        if (snapshot.hasData) {
          Restaurant restaurant = snapshot.data ;
        //  selectedcategories = restaurant.restauCategories ;
        List <Commentaire> comm = restaurant.comments ;
         return  Form(
            key:_formKey,
            child: SingleChildScrollView(
            scrollDirection:Axis.vertical,
            child: Column(
              children: <Widget>[
                 Stack(
                    children: <Widget>[
                      if (_image == null && restaurant.imagepath == null || restaurant.imagepath.isEmpty  ) 
                        Container(
                        height:screenHeight*0.35,
                         
                        child: Image.asset('assets/backgroud.jpg' ,fit: BoxFit.cover ,width:screenWidth ,) 
                       
                        ) ,
                      
                       if (restaurant.imagepath != null ) 
                        Container(
                        height:screenHeight*0.35,
                         
                        child: Image.network(restaurant.imagepath,fit: BoxFit.cover ,width:screenWidth ,) 
                       
                        ),
                        if (_image != null ) 
                        Container(
                        height:screenHeight*0.35,
                         
                        child: Image.file( _image,fit: BoxFit.cover ,width:screenWidth ,) 
                       
                        ),
                       
                      
                      
                        

                        Row(mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            FloatingActionButton(
                              elevation: 0.3,
                              child: Icon(Icons.camera_alt),
                              onPressed: () {getImage( );} ,
                              ),
                          ],
                        )
                    ]
                  ),

               Container(
                 padding: EdgeInsets.symmetric(vertical: 20 ,  horizontal: 20),
                 child: Column(
                   children: <Widget>[

                  SizedBox(height: 5,) ,

                   TextFormField(
                     initialValue: restaurant.name ?? 'Restaurant Name',
                          decoration: textInputDecoration.copyWith(hintText: 'Restaurant Name'),
                          validator: (val) =>val.isEmpty ? 'Please enter a name'  : null,
                          onChanged: (val) => setState(() => _currentName = val ),
                        ),

                   SizedBox(height: 25,) ,

                   TextFormField(
                     initialValue: restaurant.adress ?? 'Location',
                          decoration: textInputDecoration.copyWith(hintText: 'Location'),
                          validator: (val) =>val.isEmpty ? 'Please enter a location'  : null,
                          onChanged: (val) => setState(() => _currentLocation = val ),
                        ), 

                  SizedBox(height: 25,) , 

                  Center(child: Text('Menu Gallery' , style:TextStyle(fontSize: 18.0 , color: Colors.lightBlue[800]) , )) ,

                  SizedBox(height: 25,) ,  

                   RaisedButton(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)
                             ),
                            color: Colors.lightBlue[700] ,
                            onPressed: loadAssets , 
                                  
                                   
                            child: Text( 'Image Gallery'   )
                         ), 

                  SizedBox(height: 25,) , 
                  // show picked images
                  Container(child: buildGridView())  , 

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
                      ),
                  ) ,

                  SizedBox(height: 35,) , 

                  RaisedButton.icon(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)
                             ),
                            color: Colors.lightBlue[900] ,
                            onPressed: () async{
                              if (_formKey.currentState.validate()) {
                                Restaurant restaurant1 = Restaurant(adress:_currentLocation ?? restaurant.adress ,name:_currentName ?? restaurant.name , numLikes: restaurant.numLikes ,numrating: 0 ,
                              rating: restaurant.rating   , restauCategories: selectedcategories , comments: comm, ) ;
                              print(restaurant) ;
                            //await uploadGallery() ; 
                            await DatabaseService(uid: manager.restauID).editRestauAndImage(restaurant1 , _image ) ;
                            setState(() {
                                msg = 'sucessul edit' ;
                            });
                           
                              }
                              
                            } , 
                                  
                            icon:Icon(Icons.check) ,       
                            label: Text( 'Submit'   ) ,
                         ),    

                         SizedBox(height: 10,) , 

                         Text(msg , style:TextStyle(color: Colors.green, fontSize: 16) , )  ,



                   ],
                 ),
               )
                
                  


              ],
              
                
              ),
            )
        ); 
        } else { return Loading(color : "blue") ;}
      }
    );
  }
}




