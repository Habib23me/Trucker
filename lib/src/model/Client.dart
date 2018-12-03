part of trucker;

class Client extends User {


  // Constructors
  Client({@required name, @required phone}) : super(name: name, phone:phone);

  Client.fromMap(Map<String, dynamic> data) : super.fromMap(data);
  Client.map(dynamic data): super.map(data);

  /* void orderShipment({
    @required String productName,
    @required String from,
    @required String to,
    @required String postedOn,
    @required String weightClass,
    @required String clientName,
    @required String clientPhone,
    @required String arrivalDate,
  }) {
    shipmentStorage=new ShipmentStorage.forUser(client: this);
    shipmentStorage.create(productName: productName, from: from, to: to, postedOn: postedOn, weightClass: weightClass, clientName: clientName, clientPhone: clientPhone, arrivalDate: arrivalDate);
  }*/

}
