import 'package:flutter/material.dart';



class Category {
  
  final String name; 
  final IconData icon ; 
  final String imagepath ; 
  String selected = 'All';
  final int count ; 

 Category({this.name, this.icon , this.imagepath , this.count});
  
}




 List<Category> categories = <Category>[
  Category(name : 'All' , icon : Icons.search , imagepath: 'assets/all.jpg' , count:48 ) ,
  Category(name : 'disco' , icon : Icons.disc_full ,imagepath:'assets/disco.jpg' ,count:25 ) ,
  Category(name : 'techno' , icon : Icons.offline_bolt,imagepath:'assets/Techno.png',count:12 ) , 
  Category(name : 'lounge' , icon : Icons.music_note,imagepath:'assets/lounge.jpg',count:9 ) , 
  Category(name : 'others' , icon : Icons.search,imagepath:'assets/others.jpg',count:2  ) ,
   
 ];




class AppState extends ChangeNotifier {

  String selectedCategory = 'All';

  

  void updateCategory(String selectedCategory) {
    this.selectedCategory  = selectedCategory;
    notifyListeners();
    print('selected in appstate itself  = ${selectedCategory}');
  }
}