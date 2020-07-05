import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_night/models/categories.dart';
import 'package:the_night/screens/Client/home/events_home_page.dart';
import 'package:the_night/shared/quiz.dart';

class Categories extends StatefulWidget {

const Categories({Key key, this.category , }) : super(key: key);
 final Category category;

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  
 

  @override
  Widget build(BuildContext context) {

    
    
    return 
    
    GestureDetector(
      
          child: Container(
        margin: const EdgeInsets.symmetric(horizontal : 8),
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          border:Border.all(color :Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(40)),
          color : Colors.transparent ,
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              widget.category.icon , 
              color:Colors.white ,
              size:30 , 
            ),

            SizedBox(height: 5,),

            Text(
              widget.category.name ,
              style: TextStyle(fontSize: 12 ,color: Colors.white),
              
              
            )
          ],
        ),
        
      ),
    );
  }
}

class CategoryScroll extends StatefulWidget {

   
  @override
  _CategoryScrollState createState() => _CategoryScrollState();
}

class _CategoryScrollState extends State<CategoryScroll> {
  @override
  Widget build(BuildContext context) {

void _quizdialog() {
  showModalBottomSheet(
    context: context,
    builder: ( context) { 
        return ChangeNotifierProvider<AppState>(
      create: (_) => AppState(),
    //  child: Consumer<AppState>(
    //              builder:(context, appState,__) =>
   child:  Quiz(score: 0,step: 0,) );
        
        
}); }

    final appState = Provider.of<AppState>(context);

    print('selected in category = ${appState.selectedCategory}');

    return Container(
           padding: EdgeInsets.symmetric(horizontal:8.0 , vertical: 10.0 ),
          decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                        Colors.purple[500],
                        Colors.deepPurple,
                      ],
                ),
        ),

          child: SingleChildScrollView(
        scrollDirection: Axis.horizontal ,
        child: Row(
          children: <Widget>[
            for(final x in categories) GestureDetector(
             onTap: () { setState(() {
               appState.updateCategory(x.name) ;
             });},
              child: Categories(category:x ,)) ,

              GestureDetector( onTap: (){ _quizdialog();},
              child: Container(
        margin: const EdgeInsets.symmetric(horizontal : 8),
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          border:Border.all(color :Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(40)),
          color : Colors.transparent ,
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.help_outline, 
              color:Colors.white ,
              size:30 , 
            ),

            SizedBox(height: 5,),

            Text(
              'Quiz' ,
              style: TextStyle(fontSize: 12 ,color: Colors.white),
              
              
            )
          ],
        ),
        
      ),
              ),
          ],
        ),
        
      ),
        
    );
  }
}