part of trucker;

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Image(image: new AssetImage("Logo.png")),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  height: 60,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          border: new Border.all(color: Colors.grey[500])),
                      child: FlatButton(
                        child: new Text("Driver",
                            style: TextStyle(color: Colors.grey[500])),
                        onPressed: (){_toAuthScreen(context,true);},
                      )),
                )),
                Expanded(
                    child: Container(
                        height: 60,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              border: new Border.all(color: Colors.grey[500])),
                          child: FlatButton(
                              child: new Text("Client",
                                  style: TextStyle(color: Colors.grey[500])),
                              onPressed: (){_toAuthScreen(context,false);},
                          ),
                        )))
              ],
            ),
          ],
        ));
  }


   _toAuthScreen(context,isDriver) {
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new AuthScreen(isDriver: isDriver)),
      );
    }

}
