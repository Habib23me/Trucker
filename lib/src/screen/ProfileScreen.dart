part of trucker;

class ProfileScreen extends StatefulWidget {
  final isDriver;
  final user;

  ProfileScreen({@required this.isDriver,@required this.user});

  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  User currentUser;

  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController plateNoController;

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    nameController.dispose();
    phoneController.dispose();
    plateNoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
   currentUser = widget.user;
    nameController=new TextEditingController();
    phoneController=new TextEditingController();
    plateNoController=new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Padding(
        padding: EdgeInsets.all(36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 24.0),
              child: CircleAvatar(
                  backgroundColor: Colors.grey[800],
                  minRadius: 40,
                  child: Center(
                    //TODO find a way to solve this blindfold
                    child: Text(currentUser.name[0],
                        style: TextStyle(color: Colors.white, fontSize: 24.0)),
                  )),
            ),
            Text(currentUser.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline),
            Container(
              margin: EdgeInsets.symmetric(vertical: 36.0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 18.0),
                    child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.info, color: Colors.grey),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          labelText: "Full Name",
                        )),
                  ),
                  TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        labelText: "Phone Number",
                      )),
                  widget.isDriver
                      ? Container(
                          margin: EdgeInsets.only(top: 18.0),
                          child: TextFormField(
                            controller: plateNoController,
                              decoration: InputDecoration(
                            prefixIcon: Icon(Icons.info, color: Colors.grey),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            labelText: "Vehicle Model Number",
                          )),
                        )
                      : Container(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: InkWell(
                  onTap: null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      Text("Log Out")
                    ],
                  )),
            ),
            ButtonTheme(
              minWidth: 350.0,
              height: 50.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36.0)),
                onPressed: () {
                  _saveChanges(context);
                },
                color: Colors.grey[900],
                child: Text("Save Changes",
                    style: TextStyle(color: Colors.grey[100])),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveChanges(BuildContext context) {
  /*  if (nameController != null && nameController.text.isNotEmpty) {
      setState(() {
        currentUser.updateName(nameController.text);
      });
    }
    if (phoneController != null && phoneController.text.isNotEmpty) {
      setState(() {
        currentUser.updatePhone(phoneController.text);
      });
    }

    if(widget.isDriver==true && plateNoController != null && plateNoController.text.isNotEmpty) {
      setState(() {
        //TODO fix this

        Driver currentDriverHandler= currentUser;
        currentDriverHandler.updatePlateNo(plateNoController.text);
        currentUser=currentDriverHandler;
      });


    }
    else{
      print("empty");
    }*/
    }

}
