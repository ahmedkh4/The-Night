import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;
import 'package:the_night/models/client.dart';
import 'package:the_night/models/event.dart';
import 'package:the_night/models/restaurant.dart';
import 'package:uuid/uuid.dart';

class DatabaseService with ChangeNotifier  {

  final String uid ;
DatabaseService({ this.uid}) ;


// collection reference 
//final CollectionReference restauCollection = Firestore.instance.collection('Restaurants') ;
CollectionReference restauRef = Firestore.instance.collection('restaurants');

CollectionReference eventRef = Firestore.instance.collection('events');

CollectionReference clientRef = Firestore.instance.collection('clients');

 


//////////////////////////////////////  first log in ///////////////////// 

firstlogin(Restaurant restaurant) async{
DocumentSnapshot document = await restauRef.document(uid).get() ; 
  if (!document.exists) {
   await restauRef.document(uid).setData(restaurant.toMap() ) ;
   
  }

}


firstloginfb(ClientData clientData) async{
DocumentSnapshot document = await clientRef.document(uid).get() ; 
  if (!document.exists) {
   await clientRef.document(uid).setData(clientData.toMap() ) ;
 
  }

}


////////////////////////////////////////// edit profile /////////////////////////////

editRestauAndImage(Restaurant restaurant, File localFile ,  /*List urlGallery**/) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('restaurants/images/$uuid$fileExtension');

    await firebaseStorageRef.putFile(localFile).onComplete.catchError((onError) {
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");
    _editprofile(restaurant ,/*List urlGallery**/ imageUrl: url  );
  } else {
    print('...skipping image upload');
    _editprofile(restaurant, /*List urlGallery**/);
  }
}

///////// edit profile 

_editprofile(Restaurant restaurant , /*List urlGallery**/  {String imageUrl} ) async {
  

  if (imageUrl != null) {
    restaurant.imagepath = imageUrl;
  }
  restaurant.restauID = uid ;
 // restaurant.gallery = urlGallery ;

  await restauRef.document(uid).updateData(restaurant.toMap() ,);

    
    print('updated profle with id: ${restaurant.restauID}');
  
}


 _uploadPic( File localFile ) async {

 if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    //print(fileExtension);

    var uuid = Uuid().v4();

    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('restaurants/images/$uuid$fileExtension');

    await firebaseStorageRef.putFile(localFile).onComplete.catchError((onError) {
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();
    return url ; 

}
}


 uploadGallery( List gallery  ) async {  
List urlGallery ; 
for( final pic in gallery ) {
String url = await _uploadPic( pic) ;
urlGallery.add(url) ;
}
return urlGallery ; 



}
///////////////////////////// ADD EVENT ///////////////////////////////
//////////////////////////////////////////////////////////////////////

addEventAndImage(Event event, File localFile ,  /*List urlGallery**/) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('events/images/$uuid$fileExtension');

    await firebaseStorageRef.putFile(localFile).onComplete.catchError((onError) {
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");
    _addevent(event ,imageUrl: url  );
  } 
  
}

_addevent(Event event ,   {String imageUrl} ) async {
  

  if (imageUrl != null) {
    
    event.photo = imageUrl;
  }

 
  
  DocumentReference documentRef = await eventRef.add(event.toMap());

  event.eventID= documentRef.documentID ;
  
  
    await documentRef.setData(event.toMap() ,merge: true);
  
 
}



//////////////////////////////// edit event ////////////////////////////////// 
///
editeventAndImage(Event event, File localFile ,  /*List urlGallery**/) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('events/images/$uuid$fileExtension');

    await firebaseStorageRef.putFile(localFile).onComplete.catchError((onError) {
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");
    _editevent(event ,imageUrl: url  );
  } 
  
}

_editevent(Event event ,   {String imageUrl} ) async {
  

  if (imageUrl != null) {
    
    event.photo = imageUrl;
  }

 
  await eventRef.document(event.eventID).updateData(event.toMap());


////
  
 
    
    print('updated event with id: ${event.eventID}');
  
}







//////////////// strams 
///

/////// restaurant stream 

// Restaurant from snapshot (snapshot --> Restaurant)

Restaurant  _restaurantFromSnapShot(DocumentSnapshot snapshot) {
  if(snapshot.documentID == uid)
  
return Restaurant(
    restauID : snapshot.data['id'] ,
    name : snapshot.data['name'] ,
    adress : snapshot.data['adress'] ,
    imagepath : snapshot.data['image'],
    //gallery : snapshot.data['gallery'],
    numLikes : snapshot.data['numLikes'],
    rating : snapshot.data['rating'],
    numrating : snapshot.data['numrating'] ,
    restauCategories : snapshot.data['restauCategories'] ,
    
);
}

// get restaurant List doc stream 
Stream<Restaurant> get restaurant {
  return restauRef.document(uid).snapshots()
  .map(_restaurantFromSnapShot) ;
}

List<Restaurant>  _restaurantListFromSnapShot(QuerySnapshot snapshot) {
return snapshot.documents.map( (doc) {
  if (doc.data.isNotEmpty ) {
   
 return Restaurant(
    restauID : doc.data['id'] ,
    name : doc.data['name'] ,
    adress : doc.data['adress'],
    imagepath : doc.data['image'],
    //gallery : doc.data['gallery'],
    numLikes : doc.data['numLikes'],
    rating : doc.data['rating'] ,
    numrating : doc.data['numrating'] ,
    restauCategories : doc.data['restauCategories']  ,
    comments :  List<Commentaire>.from(doc.data["comments"].map((item) {
           //  if (item.data.isNotEmpty && item.data != null) {
            return  Commentaire(
                name: item["name"],
                body: item["body"],
                  ); } ) )
); }
}).toList();
}

// get restaurant doc stream 
Stream<List<Restaurant>> get restaurants {
  return restauRef.snapshots()
  .map(_restaurantListFromSnapShot) ;
}




// event from snapshot (snapshot --> event)

Event _eventFromSnapShot(DocumentSnapshot snapshot) {
return Event(
    eventID : snapshot.data['id'],
    name : snapshot.data['name'],
    location : snapshot.data['location'],
    photo : snapshot.data['photo'],
    numLikes : snapshot.data['numLikes'],
    rating : snapshot.data['rating'],
    date: snapshot.data['date'],
    time: snapshot.data['time'],
    band: snapshot.data['band'],
    description1: snapshot.data['description1'],
    eventCategories: snapshot.data['eventCategories'],
);
}

// get user doc stream 
Stream<Event> get event {
  return eventRef.document(uid).snapshots()
  .map(_eventFromSnapShot) ;
}



// event list from snapshot ( snapshot --> event list )
List<Event> _eventListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.documents.map( (doc) {
    return Event(
      eventID : doc.data['id'],
    name : doc.data['name'],
    location : doc.data['location'],
    photo : doc.data['photo'],
    numLikes : doc.data['numLikes'],
    rating : doc.data['rating'],
    date: doc.data['date'],
    time: doc.data['time'],
    band: doc.data['band'],
    description1: doc.data['description1'],
    eventCategories: doc.data['eventCategories'],
    comments :  List<Commentaire>.from(doc.data["comments"].map((item) {
         //   if (item.data.isNotEmpty && item.data != null) {
            return  Commentaire(
                name: item["name"],
                body: item["body"],
                  ); } ) )
    );
  }).toList();
}



// get event stream ( watch the database changes )
Stream<List<Event>> get events {
  return eventRef.snapshots() 
  .map(_eventListFromSnapshot) ;
}

///  clientdata from snapshot

ClientData _clientdatafromsnapshot( DocumentSnapshot snapshot) {
  return ClientData(
    clientid: snapshot.data['id'] ,
    name : snapshot.data['name'] ,
    restaurantLikes : snapshot.data['restaurantLikes'] ,
    eventLikes : snapshot.data['eventLikes'] ,
    );
}

// get clientdata stream 
Stream <ClientData> get clientData {
  return clientRef.document(uid).snapshots()
  .map(_clientdatafromsnapshot) ;
}


/////////////////////////// delete event //////////////////////////
///

deleteFood(Event event,) async {
  if (event.photo != null) {
    StorageReference storageReference =
        await FirebaseStorage.instance.getReferenceFromUrl(event.photo);

    print(storageReference.path);

    await storageReference.delete();

    print('image deleted');
  }

  await Firestore.instance.collection('events').document(event.eventID).delete();
  
}

////////////////////////////////////// event likes // event dislike  /////////////////////

  eventLike(Event event , ClientData clientData) async{
 clientData.eventLikes.add(event.eventID) ;
 await eventRef.document(event.eventID).updateData({'numLikes' : event.numLikes+1}) ;
ClientData clientdata1 = ClientData(clientid: clientData.clientid , name: clientData.name , eventLikes: clientData.eventLikes, restaurantLikes: clientData.restaurantLikes) ;
 await clientRef.document(clientData.clientid).updateData(clientdata1.toMap()) ;

 await eventRef.document(event.eventID).updateData({'numLikes' : event.numLikes+1}) ;
 
}


 eventdisLike(Event event , ClientData clientData) async{
 clientData.eventLikes.remove(event.eventID) ;
 await eventRef.document(event.eventID).updateData({'numLikes' : event.numLikes-1}) ;
ClientData clientdata1 = ClientData(clientid: clientData.clientid , name: clientData.name , eventLikes: clientData.eventLikes, restaurantLikes: clientData.restaurantLikes) ;
 await clientRef.document(clientData.clientid).updateData(clientdata1.toMap()) ;

 
 
}

////////////////////////////////////// restaurant likes // restaurant dislike  /////////////////////

  restaurantLike(Restaurant restaurant , ClientData clientData) async{
 clientData.restaurantLikes.add(restaurant.restauID) ;
 await restauRef.document(restaurant.restauID).updateData({'numLikes' : restaurant.numLikes+1}) ;
ClientData clientdata1 = ClientData(clientid: clientData.clientid , name: clientData.name , eventLikes: clientData.eventLikes, restaurantLikes: clientData.restaurantLikes) ;
 await clientRef.document(clientData.clientid).updateData(clientdata1.toMap()) ;

 
}


 restaurantdisLike(Restaurant restaurant , ClientData clientData) async{
 clientData.restaurantLikes.remove(restaurant.restauID) ;
 await restauRef.document(restaurant.restauID).updateData({'numLikes' : restaurant.numLikes-1}) ;
ClientData clientdata1 = ClientData(clientid: clientData.clientid , name: clientData.name , eventLikes: clientData.eventLikes, restaurantLikes: clientData.restaurantLikes) ;
 await clientRef.document(clientData.clientid).updateData(clientdata1.toMap()) ;

 
 
}



restaurantrating( Restaurant restaurant , int rating )async {
  double rate  = (restaurant.rating + rating ) / (restaurant.numrating+1) ;
  
  restaurant.rating = rate.truncate()   ;
  restaurant.numrating += 1 ; 
  

  await restauRef.document(restaurant.restauID).updateData({'rating' : restaurant.rating , 'numrating' : restaurant.numrating  }) ;


}


addrestauComment(String text , String name , Restaurant restaurant) async{
  Commentaire comm0 = Commentaire( name :name  , body : text) ;
  restaurant.comments.add(comm0)  ; 
  await restauRef.document(restaurant.restauID).updateData({'comments' : restaurant.comments.map((Commentaire comm)=> comm.toMap()).toList()}) ;
}

addeventComment(String text , String name , Event event) async{
  Commentaire comm0 = Commentaire( name :name  , body : text) ;
  event.comments.add(comm0)  ; 
  await eventRef.document(event.eventID).updateData({'comments' : event.comments.map((Commentaire comm)=> comm.toMap()).toList()}) ;

}






}


 