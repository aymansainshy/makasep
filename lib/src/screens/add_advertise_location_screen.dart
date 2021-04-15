import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';

import '../providers/modifid_real_estate_provider.dart';
import '../screens/add_advertise_detailes_screen.dart';
import '../utils/app_constant.dart';

class AddAdvertiseLocationScreen extends StatefulWidget {
  static const routeName = "/add-advertise-location-screen";

  final bool isReadOnly;
  final LatLng target;

  const AddAdvertiseLocationScreen({
    Key key,
    this.target = const LatLng(24.758347052836406, 46.647991463541985),
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  _AddAdvertiseLocationScreenState createState() =>
      _AddAdvertiseLocationScreenState();
}

class _AddAdvertiseLocationScreenState
    extends State<AddAdvertiseLocationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  LatLng _selectedLocation;

  Future<void> _getCurrentUserLocation() async {
    final locationData = await Location().getLocation();
    LatLng _currentLocation = LatLng(
      locationData.latitude,
      locationData.longitude,
    );
    setState(() {
      _selectedLocation = _currentLocation;
    });
    print("Current Location Lat " + _selectedLocation.latitude.toString());
    print("Current Location Lon " + _selectedLocation.longitude.toString());
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    final _modifiedRealEstat =
        Provider.of<ModifiedRealEstat>(context, listen: false);

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: widget.isReadOnly
          ? Container()
          : FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                _modifiedRealEstat.setAdderess(
                  latitude: _selectedLocation.latitude,
                  longitude: _selectedLocation.longitude,
                );
                print("Modified RealEstate lat" +
                    _modifiedRealEstat.reatEstate.address.lat.toString());
                print("Modified RealEstate lan" +
                    _modifiedRealEstat.reatEstate.address.lan.toString());
                Navigator.of(context)
                    .pushNamed(AddAdvertiseDetaileScreen.routeName);
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
            onMapCreated: _onMapCreated,
            onTap: widget.isReadOnly
                ? null
                : (LatLng latLng) {
                    setState(() {
                      _selectedLocation = LatLng(
                        latLng.latitude,
                        latLng.longitude,
                      );
                    });

                    print("Selected Location lat .. " +
                        _selectedLocation.latitude.toString());
                    print("Selected Location lon .. " +
                        _selectedLocation.longitude.toString());
                  },
            initialCameraPosition: widget.isReadOnly
                ? CameraPosition(
                    target: widget.target,
                    zoom: 16,
                  )
                : CameraPosition(
                    target: _selectedLocation ?? widget.target,
                    zoom: 12,
                  ),
            markers: {
              Marker(
                markerId: MarkerId("1"),
                position: widget.isReadOnly
                    ? widget.target
                    : _selectedLocation ?? widget.target,
              )
            },
          ),
        ),
      ),
    );
  }
}
