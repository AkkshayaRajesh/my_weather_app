import 'package:flutter/material.dart';
import 'package:my_weather_app/models/weather_model.dart';
import 'package:my_weather_app/services/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}



class _WeatherPageState extends State<WeatherPage> {

//API key
final _weatherService = WeatherService('0c02aa9557e1035e0a14fb32d6f8af41');
Weather? _weather;

//Fetch weather
_fetchWeather() async {
  //Get current city
String cityName = await _weatherService.getCurrentCity();
  
  //Fetch weather data for city
  try {
    Weather weather = await _weatherService.getWeather(cityName);
    setState(() {
      _weather = weather;
    });
  } catch (e) {
    print('Error fetching weather: $e');
  }
}

// Weather Animation
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloud.json';
      case 'mist':
        return 'assets/windy.json';
      case 'smoke':
        return 'assets/windy.json';
      case 'haze':
        return 'assets/windy.json';
      case 'dust':
        return 'assets/windy.json';
      case 'fog':
        return 'assets/windy.json';
      case 'rain':
        return 'assets/rainy.json';
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'clear':
        return 'assets/sunny.json';
      case 'tornado':
        return 'assets/thunder.json';
      case 'squall':
        return 'assets/cloud.json';
      case 'ash':
        return 'assets/cloud.json';
      case 'sand':
        return 'assets/windy.json';
      case 'snow':
        return 'assets/snowy.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      default:
        return 'assets/sunny.json';
    }
  }


//Initial State
@override
void initState() {
  super.initState();
  _fetchWeather();
}
@override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Center(
        child:Column(mainAxisAlignment: MainAxisAlignment.center, 
        children:        
        [ 
          //City Name
          Text(_weather?.cityName ?? 'Loading...'),
          //Weather Animation
          Lottie.asset(
            getWeatherAnimation(_weather?.mainCondition),
            width: 200,
            height: 200,
          ),
        
          // Temperature 
          Text('${_weather?.temperature.round()}°C' ),

          // Weather Condition
          Text(_weather?.mainCondition ?? 'Loading...'),
        ],
        ),
      ),
    );
  }
}