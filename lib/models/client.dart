
class Client {
String clientid ; 

Client({this.clientid}) ; 

}




class ClientData {

  String clientid ; 
  String name  ;
  List eventLikes ; 
  List restaurantLikes ;

  
ClientData ({this.clientid , this.name , this.eventLikes , this.restaurantLikes}) ;



Map<String , dynamic>toMap() {
  return {
    'id': clientid , 
    'name': name , 
    'eventLikes' : eventLikes , 
    'restaurantLikes' : restaurantLikes ,
  } ;
}
 

}