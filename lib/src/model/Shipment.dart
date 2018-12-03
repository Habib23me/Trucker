part of trucker;

class Shipment{
  String productName,arrivalDate,status,clientName,clientPhone,driverName,driverPhone,from,to,weightClass,postedOn;

  Shipment({
    @required this.productName,
    @required  this.from,
    @required this.to,
    @required this.postedOn,
    @required this.weightClass,
    @required this.clientName,
    @required this.clientPhone,
    @required this.arrivalDate,
  }):
  assert (productName!=null && productName.isNotEmpty),
  assert(from!=null && from.isNotEmpty),
  assert(to!=null && to.isNotEmpty),
  assert(postedOn!=null && postedOn.isNotEmpty),
  assert(weightClass!=null && weightClass.isNotEmpty),
  assert(clientName!=null && clientName.isNotEmpty),
  assert(clientPhone!=null && clientPhone.isNotEmpty),
  assert(arrivalDate!=null && arrivalDate.isNotEmpty);

  Shipment.fromMap(Map<String,dynamic> data)
  :this(
  productName:data["product_name"],
  from:data["from"],
  to:data["to"],
  postedOn:data["posted_on"],
  weightClass:data["weight_class"],
  clientName:data["client_name"],
  clientPhone:data["client_phone"],
  arrivalDate:data["arrival_date"],
  );



  Shipment.fromSnapshot(DocumentSnapshot snapshot): this.fromMap(snapshot.data);

  Map<String,dynamic> toMap()=>{
    "product_name":this.productName,
    "from":this.from,
    "to":this.to,
    "posted_on":this.postedOn,
    "weight_class":this.weightClass,
    "client_name":this.clientName,
    "client_phone":this.clientPhone,
    "arrival_date":this.arrivalDate,
  };

}

