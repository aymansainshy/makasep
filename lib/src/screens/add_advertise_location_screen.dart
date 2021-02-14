import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';

import '../providers/categories_provider.dart';
import '../providers/modifid_real_estate_provider.dart';
import '../screens/add_advertise_detailes_screen.dart';
import '../utils/app_constant.dart';

class AddAdvertiseLocationScreen extends StatefulWidget {
  static const routeName = "/add-advertise-location-screen";

  final isSelecting;

  const AddAdvertiseLocationScreen({
    Key key,
    this.isSelecting = true,
  }) : super(key: key);

  @override
  _AddAdvertiseLocationScreenState createState() =>
      _AddAdvertiseLocationScreenState();
}

class _AddAdvertiseLocationScreenState
    extends State<AddAdvertiseLocationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  LatLng selectedLocation;

  final Map<String, dynamic> address = {
    "lan": 4442432.334,
    "lat": 223.3341414,
  };

  Future<void> _getCurrentUserLocation() async {
    final locationData = await Location().getLocation();
    final _currentLocation = LatLng(
      locationData.latitude,
      locationData.longitude,
    );
    setState(() {
      selectedLocation = _currentLocation;
    });
    print(locationData.latitude);
    print(locationData.longitude);
  }

  @override
  void initState() {
    _getCurrentUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    ScreenUtil screenUtil = ScreenUtil();
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final _modifiedRealEstat =
        Provider.of<ModifiedRealEstat>(context, listen: false);

    return Scaffold(
      key: _scaffoldKey,
      // drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          _modifiedRealEstat.setAdderess(
            latitude: selectedLocation.latitude,
            longitude: selectedLocation.longitude,
          );
          print(_modifiedRealEstat.reatEstate.address.lat.toString() +
              " ppppppppppppp");
          print(_modifiedRealEstat.reatEstate.address.lan.toString() +
              " ppppppppppppp");
          Navigator.of(context).pushNamed(AddAdvertiseDetaileScreen.routeName);
        },
        child: Text("استمرار"),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "3 اضافة اعلان",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Container(
        color: Colors.blueAccent,
        child: Center(
          child: GoogleMap(
            onTap: (LatLng latLng) {
              setState(() {
                selectedLocation = LatLng(
                  latLng.latitude,
                  latLng.longitude,
                );
              });

              print(selectedLocation.latitude.toString() +
                  "--------------------------");
              print(selectedLocation.longitude.toString() +
                  "--------------------------");
            },
            initialCameraPosition: CameraPosition(
              target: selectedLocation == null
                  ? LatLng(
                      47.6255,
                      -122.3365,
                    )
                  : LatLng(
                      selectedLocation.latitude,
                      selectedLocation.longitude,
                    ),
              zoom: 16,
            ),
          ),
        ),
      ),
    );
  }
}
