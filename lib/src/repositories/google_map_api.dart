const GOOGLE_API_KEY = 'AIzaSyBmr8qt-nwfSQ1SCfzqomQQuJA8z68ZeQo';

class GoogleServicesApi {
  static String genarateLocationImage({double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}
