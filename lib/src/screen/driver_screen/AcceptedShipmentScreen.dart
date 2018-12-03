part of trucker;

class AcceptedShipmentScreen extends StatefulWidget{
  final _shipmentList;


  AcceptedShipmentScreen(this._shipmentList);

  @override
  State<StatefulWidget> createState() {
    return AcceptedShipmentScreenState();
  }

}class AcceptedShipmentScreenState extends State<AcceptedShipmentScreen> {
  List<Shipment> _acceptedShipments= new List<Shipment>();
  @override
  void initState() {
    super.initState();
    _acceptedShipments=widget._shipmentList;

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
      body: _acceptedShipments.length==0? Center(child:Text("You have no orders")):ListView.builder(
          itemCount: _acceptedShipments.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildRow(_acceptedShipments[index]);
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
          onTap: (){_makeCall();},
        ),
        new IconSlideAction(
          caption: 'Done',
          color: Colors.grey[800],
          icon: Icons.done_all,
          onTap: (){_markAsDone(currentShipment);},
        ),
      ],
      secondaryActions: <Widget>[
        new IconSlideAction(
          caption: 'Remove',
          color: Colors.red,
          icon: Icons.cancel,
          onTap:(){_removeRequest(currentShipment);},
        ),
      ],
    ) ;

  }

  _markAsDone(Shipment currentShipment) {
    setState(() {
      _acceptedShipments.remove(currentShipment);
    });

  }
  _makeCall() async {
    const url="tel:+251941232484";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Can't call right now")));
    }
  }

  _removeRequest(Shipment currentShipment) {
    setState(() {
      _acceptedShipments.remove(currentShipment);
    });
  }
}
