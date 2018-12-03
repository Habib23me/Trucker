part of trucker;
abstract class ListItem {}

class ClientHomeScreen extends StatefulWidget {
  final Client currentClient;
  ClientHomeScreen({@required this.currentClient});

  @override
  State<StatefulWidget> createState() {
    return ClientHomeScreenState();
  }
}

class ClientHomeScreenState extends State<ClientHomeScreen> {
  final dateFormat = DateFormat("MMMM d, yyyy 'at' h:mma");
  List<String> _values = new List<String>();
  String _value;
  String arrivalDate;
  TextEditingController productName;
  TextEditingController from;
  TextEditingController to;

  @override
  void initState() {
    super.initState();
    productName=new TextEditingController();
    from=new TextEditingController();
    to=new TextEditingController();
    _values
        .addAll(["100-200", "200-500", "500-1000", "1000-5000", "5000-10000"]);
    _value = _values.elementAt(0);
  }
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    productName.dispose();
    from.dispose();
    to.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text("Place Shipment"),
          leading: IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () {_toProfileScreen(context);},),
            actions: <Widget>[
            IconButton(
              onPressed: () {_toShipmentOrdersScreen(context);},
              icon: Icon(Icons.notifications),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
          child: Center(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0)),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 36.0),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: from,
                              decoration: InputDecoration(
                                icon: Icon(Icons.swap_vert, size: 36.0),
                                labelStyle: Theme.of(context).textTheme.caption,
                                labelText: "From",
                              ),
                            ),
                            TextField(
                              controller: to,
                              decoration: InputDecoration(
                                icon: Opacity(
                                  opacity: 0.0,
                                  child: Icon(Icons.swap_vert, size: 36.0),
                                ),
                                labelStyle: Theme.of(context).textTheme.caption,
                                labelText: "To",
                              ),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(bottom: 24.0),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            DateTimePickerFormField(
                              dateOnly: true,
                              onChanged: (DateTime date){arrivalDate=date.toString();},
                              format: dateFormat,
                              decoration: InputDecoration(
                                icon: Icon(Icons.event, size: 36.0),
                                labelStyle: Theme.of(context).textTheme.caption,
                                labelText: "To be Shipped On",
                              ),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(bottom: 24.0),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: productName,
                              decoration: InputDecoration(
                                icon: Icon(Icons.local_offer, size: 36.0),
                                labelStyle: Theme.of(context).textTheme.caption,
                                labelText: "Product Name",
                              ),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(bottom: 24.0),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 16.0),
                            child: Icon(
                              Icons.business_center,
                              size: 36.0,
                              color: Colors.grey[500],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Weight Class (Kg)",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                DropdownButton(
                                  isExpanded: true,
                                  value: _value,
                                  items: _values.map((String value) {
                                    return new DropdownMenuItem(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    _onChanged(value);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 40.0),
                          child: ButtonTheme(
                            minWidth: 350.0,
                            height: 50.0,
                            child: RaisedButton(
                              color: Colors.grey[500],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(36.0)),
                              onPressed: () {_placeShipment(context);},
                              child: Text(
                                "Place Shipment",
                                style: TextStyle(color: Colors.grey[100]),
                              ),
                            ),
                          ))
                    ],
                  ),
                )),
          ),
        ));
  }

  void _onChanged(value) {
    setState(() {
      _value = value;
    });
  }

   _toProfileScreen(context) {
    Navigator.push(context, MaterialPageRoute(builder:(context)=> new ProfileScreen(isDriver:false, user: widget.currentClient,)));
  }

   _toShipmentOrdersScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> new ShipmentOrderScreen()));
  }

  void _placeShipment(BuildContext context){
    ShipmentStorage storage=ShipmentStorage.forUser(client: widget.currentClient);
    storage.create(productName: productName.text, from: from.text, to: to.text, postedOn: "Dummy time", weightClass: _value, arrivalDate: arrivalDate);

  }
}
