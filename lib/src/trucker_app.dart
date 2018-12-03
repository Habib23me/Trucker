library trucker;

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:badges/badges.dart';


part 'model/Client.dart';
part 'model/Driver.dart';
part 'model/Shipment.dart';
part 'screen/client_screen/ClientHomeScreen.dart';
part 'screen/client_screen/ShipmentOrdersScreen.dart';
part 'screen/driver_screen/AcceptedShipmentScreen.dart';
part 'screen/driver_screen/DriverHomeScreen.dart';
part 'screen/AuthScreen.dart';
part 'screen/SplashScreen.dart';
part 'screen/ProfileScreen.dart';
part 'services/ShipmentStorage.dart';
part 'model/user.dart';
part 'services/FirestoreStoreService.dart';

enum Users{
  client, driver
}
class TruckerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Trucker",
      theme: ThemeData(
          primaryColor: Colors.grey[900]
      ),
      home: SplashScreen(),
    );
  }
}
