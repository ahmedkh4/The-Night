




class Commentaire {
  String name ;
  String body ;
   
  

  Commentaire({this.body , this.name });

   Commentaire.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    body = data['body'];
  
  }

   Map<String, dynamic> toMap() {
    return {
     
      'name': name,
      'body': body,
    }; }
}

class RestauManager {

   String restauID ; 
  

  RestauManager({this.restauID }) ;

}



class Restaurant {

  String restauID ; 
  String name ; 
  String adress ; 
  String imagepath ; 
  List gallery ;
  int numLikes ; 
  int rating ; 
  int numrating ; 
  List restauCategories ; 
  List <Commentaire> comments ;


Restaurant({ this.restauID  ,this.name  ,this.adress  ,this.numLikes  ,this.rating, this.numrating   ,this.restauCategories , this.imagepath , this.comments}) ; 



  Map<String, dynamic> toMap() {
    return {
      'id': restauID,
      'name': name,
      'adress': adress,
      'image': imagepath,
      'gallery': gallery,
      'numLikes': numLikes,
      'numrating': numrating,
      'rating': rating ,
      'restauCategories' : restauCategories ,
    };
  }



   Restaurant.fromMap(Map<String, dynamic> data) {
    restauID= data['id'];
    name = data['name'];
    adress = data['adress'];
    imagepath = data['image'];
    gallery = data['gallery'];
    numLikes = data['numLikes'];
    rating = data['rating'];
    restauCategories = data['restauCategories'];
  }



 }

 List <Restaurant> restaurants4 = <Restaurant>[
   Restaurant (restauID :"1" ,name:'Golf Brau'  , adress:'kantaoui' , numLikes:10 ,rating:4 , restauCategories:['all' ,'techno'] , imagepath:'assets/golf_brau.jpg'  ) ,

   Restaurant (restauID :"2" ,name:'Platinium'  , adress:'kantaoui' , numLikes:15 ,rating:3 , restauCategories:['all' ,'techno','disco'] , imagepath:'assets/platinium.jpg'  ) ,

   Restaurant (restauID :"3" ,name:'Jobi'  , adress:'blooming' , numLikes:2 ,rating:1 , restauCategories:['all' ,'techno','others'] , imagepath:'assets/jobi.png'  ) ,

   Restaurant (restauID :"4" ,name: 'Lotus' , adress:'dar chabeb sousse' , numLikes:1 ,rating:2 , restauCategories:['all' ,'techno', 'disco' , 'others'] , imagepath:'assets/golf_brau.jpg'  ) ,
   
   Restaurant (restauID :"5" ,name:'Hmiz'  , adress:'chera3 tawfi9' , numLikes:999 ,rating:5 , restauCategories:['all' ,'lounge','disco','others' ] ,imagepath:'assets/hmiz.jpg'  ) ,
  ] ;