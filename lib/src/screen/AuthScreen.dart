part of trucker;

class AuthScreen extends StatefulWidget {
  final isDriver;
  AuthScreen({this.isDriver});
  @override
  State<StatefulWidget> createState() {
    return new AuthScreenState();
  }
}

class AuthScreenState extends State<AuthScreen> {
  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController plateNoController;
  FirestoreUserService service;

  @override
  void initState() {
    nameController = new TextEditingController();
    phoneController = new TextEditingController();
    plateNoController = new TextEditingController();
    service = FirestoreUserService();

    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    nameController.dispose();
    phoneController.dispose();
    plateNoController.dispose();
    super.dispose();
  }

  bool isSignUp = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("login"),
        ),
        backgroundColor: Colors.grey[900],
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                margin: EdgeInsets.only(top: 64.0),
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 24.0),
                      child: Text(
                        isSignUp ? "Create An Account" : "Sign In to Account",
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    isSignUp
                        ? Container(
                            margin: EdgeInsets.only(bottom: 16.0),
                            child: TextField(
                              controller: nameController,
                              decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.teal)),
                                labelText: 'Full Name',
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                prefixText: ' ',
                              ),
                            ),
                          )
                        : Container(),
                    Container(
                      margin: EdgeInsets.only(bottom: 16.0),
                      child: TextField(
                        controller: phoneController,
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                          labelText: 'Phone Number',
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ),
                          prefixText: ' ',
                        ),
                      ),
                    ),
                    widget.isDriver && isSignUp
                        ? Container(
                            margin: EdgeInsets.only(bottom: 16.0),
                            child: TextField(
                              controller: plateNoController,
                              decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.teal)),
                                labelText: 'Vehicle Model Number',
                                prefixIcon: const Icon(
                                  Icons.info,
                                  color: Colors.grey,
                                ),
                                prefixText: ' ',
                              ),
                            ),
                          )
                        : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            isSignUp
                                ? "Already a member?"
                                : "Not a member yet?",
                            style: Theme.of(context).textTheme.body1),
                        FlatButton(
                            child: Text(
                              isSignUp ? "Sign in" : "Sign up",
                              style: Theme.of(context).textTheme.subhead,
                            ),
                            onPressed: () {
                              isSignUp
                                  ? _toSignIn(context)
                                  : _toSignUp(context);
                            })
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 24.0),
                        width: 250,
                        child: Text(
                          "By creating an account you agree to our Terms of Service and Privacy Policy",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ))
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: ButtonTheme(
                    minWidth: 350.0,
                    height: 50.0,
                    child: RaisedButton(
                      color: Colors.grey[500],
                      onPressed: () {
                        isSignUp
                            ? _attemptSignUp(context)
                            : _attemptLogin(context);
                      },
                      child: Text(
                        "Continue",
                        style: TextStyle(color: Colors.grey[100]),
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }

  _toSignUp(BuildContext context) {
    setState(() {
      isSignUp = true;
    });
  }

  _toSignIn(BuildContext context) {
    setState(() {
      isSignUp = false;
    });
  }


  _attemptSignUp(BuildContext context) async {
    User user;
    //Check if the controllers are empty
    if ((nameController.text != null && nameController.text.isNotEmpty) &&
        (phoneController.text != null && phoneController.text.isNotEmpty)) {
      if (widget.isDriver &&
          plateNoController.text != null &&
          plateNoController.text.isNotEmpty) {
        User user = await service.createUser(
            type: Users.driver,
            name: nameController.text,
            phone: phoneController.text,
            plateNo: plateNoController.text);
        _toDriverHomeScreen(context, user);
      } else {

        user = await service.createUser(
            type: Users.client,
            name: nameController.text,
            phone: phoneController.text);
        _toClientHomeScreen(context, user);
      }
    }
  }

  _attemptLogin(BuildContext context) async {
    //TODO make user a State variable
    User user;
    if ((phoneController.text != null && phoneController.text.isNotEmpty)) {
      if (widget.isDriver) {
        User user = await service.attemptLogin(
            type: Users.driver,
            phone: phoneController.text);
        _toDriverHomeScreen(context, user);
      } else {
        user = await service.attemptLogin(
            type: Users.client,
            phone: phoneController.text);
        _toClientHomeScreen(context, user);

      }
    }

  }

  _toDriverHomeScreen(BuildContext context, User user) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => DriverHomeScreen(
                  currentDriver: user,
                )));
  }

  _toClientHomeScreen(BuildContext context, User user) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => ClientHomeScreen(
                  currentClient: user,
                )));
  }
}
