part of trucker;

class User{
  String _name, _phone;

  List<Shipment>_linkedShipments=new List<Shipment>();

  //factory Constructors for both types
  factory User.fromData({@required var type, Map<String,dynamic> data}){
    switch(type){
      case Users.client:
        return Client.fromMap(data);
        break;
      case Users.driver:
        return Driver.fromMap(data);
        break;
      default:
        return null;
    }
  }
  factory User.raw({@required var type,@required String name, @required String phone, String plateNo}){
    switch(type){
      case Users.client:
        return Client(name: name, phone: phone);
        break;
      case Users.driver:
        return Driver(name: name, phone: phone, plateNo: plateNo);
        break;
      default:
        return null;
    }
  }

  // Constructors
  User({@required name, @required phone}):this._name=name, this._phone = phone;

  User.fromMap(Map<String, dynamic> data){
    //TODO Error handling discard null values and throw errors
    this._name = data["name"];
    this._phone = data["phone"];
  }

  User.map(dynamic data) {
    this._name = data["name"];
    this._phone = data["phone"];
  }


  // Helper Methods
  Map<String,dynamic> toMap()=>{
    'name':this._name,
    'phone':this._phone,
  };

  String get name => _name;
  String get phone => _phone;


}