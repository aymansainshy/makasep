const GOOGLE_API_KEY = 'AIzaSyALjuHPIlFu_Y5wstCXgBV6UxSuz9F5wZ0';

class GoogleServicesApi {
  static String genarateLocationImage({double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}
