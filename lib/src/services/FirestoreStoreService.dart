part of trucker;
class FirestoreUserService{

  CollectionReference getCollectionRef(var type){
    switch(type){
      case Users.client:
         return Firestore.instance.collection("client");
        break;
      case Users.driver:
        return Firestore.instance.collection("driver");
        break;
      default:
        return null;
        break;
  }

  }

  //Factory Constructor
  static final FirestoreUserService _instance = new FirestoreUserService.internal();

  factory FirestoreUserService() => _instance;

  FirestoreUserService.internal();


  Future<User> createUser({@required var type,@required String name, @required String phone, String plateNo}) async{

    TransactionHandler createUserTransaction = (Transaction transaction)async{
      DocumentSnapshot newDoc= await transaction.get(getCollectionRef(type).document());
      User newUser= User.raw(type: type, name: name, phone: phone,plateNo: plateNo);
      final Map<String, dynamic> data = newUser.toMap();
      await transaction.set(newDoc.reference, data);
      return data;
    };
    return  Firestore.instance.runTransaction(createUserTransaction).then((Map<String,dynamic> data)=> User.fromData(type: type,data: data)).catchError((error){
        print('error: $error');
        return null;
    });
  }

/*  Stream<QuerySnapshot> getUser({@required var type}){
     return  getCollectionRef(type).snapshots();
  }*/

  Future<User> attemptLogin({@required var type, @required phone}){
      return getCollectionRef(type).document(phone).get().then((DocumentSnapshot snapshot)=> User.fromData(type: type, data:snapshot.data ));
        }

  Future<bool> updateUser({@required var type, @required user}){
    TransactionHandler updateUserTransaction= (Transaction transaction)async{
      DocumentSnapshot doc= await transaction.get(getCollectionRef(type).document(user.phone));
      await transaction.update(doc.reference, user.toMap());
      return {"updated":true};
    };
    return Firestore.instance.runTransaction(updateUserTransaction).then((result) => result['updated']).catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<bool> deleteUser({@required var type, @required user})async{
    TransactionHandler updateUserTransaction= (Transaction transaction)async{
      DocumentSnapshot doc= await transaction.get(getCollectionRef(type).document(user.id));
      await transaction.delete(doc.reference);
      return {"deleted":true};
    };
    return Firestore.instance.runTransaction(updateUserTransaction).then((result) => result['deleted']).catchError((error) {
      print('error: $error');
      return false;
    });
  }


}