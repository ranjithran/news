import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import "package:news/AppKeys.dart";
class NewsApiLogic {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;

  final String _baseUrl =
      "https://newsapi.org/v2/top-headlines?apiKey=$newsApikey";

  void printOutError(error, StackTrace stacktrace) {
    print('Exception occured: $error with stacktrace: $stacktrace');
  }

  Future trendingNEWS() async {
    print("trending news");
    try {
      var code=await getCountryCode();
      final body = await get(_baseUrl+"&country=$code");
      return body.body.toString();
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
    }
  }

  Future getTopBusinessHeadlinesNews() async {
    try {
      print("Business");
      
      var code=await getCountryCode();
      final response = await get('$_baseUrl&category=business'+"&country=$code");
      return response.body;
    } catch (error, stacktrace) {
      print("error form  http ");
      printOutError(error, stacktrace);
    }
  }

  Future getTopEntertainmentHeadlinesNews() async {
    try {
      print("Entertainment");
      
      var code=await getCountryCode();
      final response = await get('$_baseUrl&category=entertainment'+"&country=$code");
      return response.body;
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
    }
  }

  Future getTopHealthHeadlinesNews() async {
    try {
      print("Health");
      
      var code=await getCountryCode();
      final response = await get('$_baseUrl&category=health'+"&country=$code");
      return response.body;
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
    }
  }

  Future getTopScienceHeadlinesNews() async {
    try {
      print("Science");
      
      var code=await getCountryCode();
      final response = await get('$_baseUrl&category=science'+"&country=$code");
      return response.body;
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
    }
  }

  Future getTopSportHeadlinesNews() async {
    try {
      print("sport");
      
      var code=await getCountryCode();
      final response = await get('$_baseUrl&category=sport'+"&country=$code");
      return response.body;
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
    }
  }

  Future getTopTechnologyHeadlinesNews() async {
    try {
      print("Technology");
      
      var code=await getCountryCode();
      final response = await get('$_baseUrl&category=technology'+"&country=$code");
      return response.body;
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
    }
  }

  Future getTopGeneralHeadlinesNews() async {
    try {
      print("General");
      
      var code=await getCountryCode();
      final response = await get('$_baseUrl&category=general'+"&country=$code");
      return response.body;
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
    }
  }


  Future getCountryCode() async {
    try {
      var code = await geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) async {
        _currentPosition = position;
        List<Placemark> p = await geolocator.placemarkFromCoordinates(
            _currentPosition.latitude, _currentPosition.longitude);

        Placemark place = p[0];
        return place.isoCountryCode;
      });
      return code;
    } catch (e) {
      print(e);
    }
  }
}
