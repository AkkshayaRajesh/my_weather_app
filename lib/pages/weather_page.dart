import 'package:flutter/material.dart';
import 'package:my_weather_app/models/weather_model.dart';
import 'package:my_weather_app/services/weather_service.dart';

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
        [ Text(_weather?.cityName ?? 'Loading...'),
        Text('${_weather?.temperature.round()}°C' ),
        ],
        ),
      ),
    );
  }
}