part of trucker;

final CollectionReference shipmentCollectionReference =
    Firestore.instance.collection("shipment");

class ShipmentStorage {
  final Client client;

  ShipmentStorage.forUser({
    @required this.client,
  }) : assert(client != null);

   static Shipment fromDocument(DocumentSnapshot document) => _fromMap(document.data);

  static Shipment _fromMap(Map<String, dynamic> data) => new Shipment.fromMap(data);

  Future<Shipment> create({
    @required productName,
    @required from,
    @required to,
    @required postedOn,
    @required weightClass,
    @required arrivalDate,
  }) async {
    //Create a transaction handler that returns a future shipment when run

    TransactionHandler createTransaction = (Transaction transaction) async {
      //Step 1 getting a new document snapshot
      // from the current transaction
      // using shipmentCollectionReference
      // by calling document with empty params
      final DocumentSnapshot newDoc =
          await transaction.get(shipmentCollectionReference.document());
      //Step 2 create an instance of a shipment
      final newShipment = new Shipment(
          productName: productName,
          from: from,
          to: to,
          postedOn: postedOn,
          weightClass: weightClass,
          clientName: client.name,
          clientPhone: client.phone,
          arrivalDate: arrivalDate);
      final Map<String, dynamic> data = newShipment.toMap();

      await transaction.set(newDoc.reference,data);

      return data;
    };

    //Step 3 run the transaction on a new FireStore instance
    return Firestore.instance.runTransaction(createTransaction).then(_fromMap).catchError((error){
      print('error: $error');
      return null;
    });

  }
}
