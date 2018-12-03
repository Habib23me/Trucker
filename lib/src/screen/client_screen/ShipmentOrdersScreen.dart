part of trucker;

class ShipmentOrderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ShipmentOrderScreenState();
  }
}

class ShipmentOrderScreenState extends State<ShipmentOrderScreen> {
  List<Shipment> _orderedShipments = new List<Shipment>();

  @override
  void initState() {
    super.initState();

    _orderedShipments.addAll([
      new Shipment(
          from: "Addis Ababa",
          to: "Dire Dawa",
          productName: "Product 1",
          postedOn: "2 hrs ago",
          arrivalDate: "November 29, 2018",
          weightClass: " (100-200 kg)",
          clientPhone: "251941232481",
          clientName:"Client 1"),
      new Shipment(
          from: "Bahir Dar",
          to: "Jimma",
          productName: "Product 2",
          postedOn: "6 hrs ago",
          arrivalDate: "October 20, 2018",
          weightClass: " (200-500 kg)",
          clientPhone: "251941232481",
          clientName:"Client 2"
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Shipment Orders"),
      ),
      body: ListView.builder(
          itemCount: _orderedShipments.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildRow(_orderedShipments[index]);
          }),
    );
  }

  Widget _buildRow(Shipment currentShipment) {
    return Container(
        height: 150,
        child: Card(
          child: Row(
            children: <Widget>[
              Container(
                width: 100,
                color: Colors.grey[800],
                child: Center(
                  child: Text(
                    currentShipment.status,
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(currentShipment.productName,
                                style: Theme.of(context).textTheme.subhead),
                            Text(currentShipment.weightClass,
                                style: Theme.of(context).textTheme.caption)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 36.0),
                        child: Row(
                          children: <Widget>[
                            Text("From ",
                                style:TextStyle(color: Colors.grey[600],fontSize: 12.0)),
                            Text(currentShipment.from,
                                style:TextStyle(color: Colors.grey[800],fontSize: 12.0,fontWeight:FontWeight.w500 )),
                            Text(" to ",
                                style:TextStyle(color: Colors.grey[600],fontSize: 12.0)),
                            Text(currentShipment.to,
                                style:TextStyle(color: Colors.grey[800],fontSize: 12.0,fontWeight:FontWeight.w700 )),
                          ],
                        ),
                      ),
                      Container(
                          child: Column(
                        children: <Widget>[
                          /*Row(
                            children: <Widget>[
                              Text("Shipped by ",
                                  style: Theme.of(context).textTheme.body1),
                              Text(currentShipment.withDriver,
                                  style: Theme.of(context).textTheme.body2),
                            ],
                          ),*/
                          Row(
                            children: <Widget>[
                              Text("To be Shipped on ",
                                  style:TextStyle(color: Colors.grey[800],fontSize: 14.0)),
                              Text(currentShipment.arrivalDate,
                                  style:TextStyle(color: Colors.grey[800],fontSize: 14.0,fontWeight:FontWeight.w500 )),
                            ],
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
