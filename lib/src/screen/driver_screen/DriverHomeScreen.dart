part of trucker;
class DriverHomeScreen extends StatefulWidget{
  //TODO change this to Driver
  final Driver currentDriver;
  DriverHomeScreen({@required this.currentDriver});
  @override
  State<StatefulWidget> createState() {
    return DriverHomeScreenState();
  }

}class DriverHomeScreenState extends State<DriverHomeScreen> {
  List<Shipment> _orderedShipments = new List<Shipment>();
  List<Shipment> _acceptedShipments= new List<Shipment>();
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
    clientName:"Client 2")
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            _toProfileScreen(context);
          },
        ),
        actions: <Widget>[
          BadgeIconButton(
              itemCount: _acceptedShipments.length, // required
              icon: Icon(Icons.local_shipping), // required
              badgeColor: Colors.grey[800], // default: Colors.red
              badgeTextColor: Colors.white, // default: Colors.white
              hideZeroCount: true, // default: true
              onPressed:  (){_toAcceptedShipments(context);}),
        ],
        title: Text("Shipment Orders"),
      ),
      body: _orderedShipments.length==0? Center(child:Text("You have no orders")):ListView.builder(
          itemCount: _orderedShipments.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildRow(_orderedShipments[index]);
          }),
    );
  }

  Widget _buildRow(Shipment currentShipment) {
    return Slidable(
      child: Container(
          height: 200,
          child: Card(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left:24.0, right:24.0, bottom: 12.0,top: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 18.0),
                          child:  Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.grey[800],
                                child:Text(currentShipment.clientName[0],style:TextStyle(color: Colors.white, fontSize: 14.0),) ,
                              ),
                              Container(
                                  margin:EdgeInsets.only(left: 12.0),
                                  child:Text(
                                      currentShipment.clientName,
                                      style: Theme.of(context).textTheme.subhead
                                  )
                              )

                            ],
                          ),
                        ),

                        Container(
                          child: Row(
                            children: <Widget>[
                              Text(currentShipment.productName,
                                  style: Theme.of(context).textTheme.subtitle),
                              Text(currentShipment.weightClass,
                                  style: Theme.of(context).textTheme.caption)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 30.0),
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
                                Row(
                                  children: <Widget>[
                                    Text("To be shipped on ",
                                        style: Theme.of(context).textTheme.body1),
                                    Text(currentShipment.arrivalDate,
                                        style: Theme.of(context).textTheme.body2),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(currentShipment.postedOn,
                                        style:TextStyle(color: Colors.grey[800],fontSize: 12.0)),
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
          )),
      key: Key(currentShipment.productName),
      delegate: new SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        new IconSlideAction(
          caption: 'Call',
          color: Colors.green,
          icon: Icons.call,
          onTap: (){_makeCall();}
        ),
        new IconSlideAction(
          caption: 'Accept',
          color: Colors.grey[800],
          icon: Icons.check,
          onTap: (){_acceptRequest(currentShipment);},
        ),
      ],
      secondaryActions: <Widget>[
        new IconSlideAction(
          caption: 'Reject',
          color: Colors.red,
          icon: Icons.delete,
          onTap:(){_removeRequest(currentShipment);},
        ),
      ],
    ) ;

  }

   _toProfileScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder:(context)=> new ProfileScreen(isDriver:true, user: widget.currentDriver,)));
  }

  _makeCall() async {
    const url="tel:+251941232484";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Can't call right now")));
    }
  }
  _acceptRequest(Shipment currentShipment) {
    setState(() {
      _acceptedShipments.add(currentShipment);
      _orderedShipments.remove(currentShipment);
    });

  }

   _removeRequest(Shipment currentShipment) {
     setState(() {
       _orderedShipments.remove(currentShipment);
     });
  }

  _toAcceptedShipments(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context)=>AcceptedShipmentScreen(_acceptedShipments)));
  }
}
