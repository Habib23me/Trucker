part of trucker;



class Driver extends User{
  String _plateNo;

  // Constructors
  Driver({@required name,@required phone, @required plateNo}):this._plateNo=plateNo,super(name:name,phone:phone);

  Driver.fromMap(Map<String, dynamic> data) :
        this._plateNo=data["plate_no"],
        super.fromMap(data);
  Driver.map(dynamic data):  this._plateNo=data["plate_no"],super.map(data);


  //helper methods
  @override
  Map<String, dynamic> toMap() => {
        'name': this._name,
        'phone': this._phone,
        'plate_no': this._plateNo,
      };



}
