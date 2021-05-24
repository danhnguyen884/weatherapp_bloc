import 'package:equatable/equatable.dart';
import 'package:weather_icons/weather_icons.dart';

enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  showers,
  heavyCloud,
  lightCloud,
  lightRain,
  clear,
  unknown
}

class Weather extends Equatable {
  final WeatherCondition weatherCondition;
  final String formattedCondition;
  final double minTemp;
  final double temp;
  final double maxTemp;
  final int locationId;
  final String created;
  final DateTime lastUpdate;
  final String location;

  const Weather(
      {this.weatherCondition,
      this.formattedCondition,
      this.minTemp,
      this.temp,
      this.maxTemp,
      this.locationId,
      this.created,
      this.lastUpdate,
      this.location});

  @override
  // TODO: implement props
  List<Object> get props => [
        weatherCondition,
        formattedCondition,
        minTemp,
        temp,
        maxTemp,
        locationId,
        created,
        lastUpdate,
        location
      ];

// {"consolidated_weather":[{
//   "id":6414599172653056,
//   "weather_state_name":"Light Rain",
// "weather_state_abbr":"lr",
// "wind_direction_compass":"ENE",
// "created":"2021-05-08T09:35:19.899960Z",
// "applicable_date":"2021-05-08",
// "min_temp":4.665,
// "max_temp":11.524999999999999,
// "the_temp":12.225,
// "wind_speed":5.545898510753201,
// "wind_direction":57.50465948545508,
// "air_pressure":1018.0,
// "humidity":51,
// "visibility":11.001066272965879,
// "predictability":75
// }},
  factory Weather.fromJson(dynamic jsonObject) {
    final consolidatedWeather = jsonObject['consolidated_weather'][0];
    return Weather(
      weatherCondition: _mapStringToWeatherCondition(
              consolidatedWeather['weather_state_abbr']) ??
          '',
      formattedCondition: consolidatedWeather['weather_state_name'] ?? '',
      minTemp: consolidatedWeather['min_temp'] as double,
      temp: consolidatedWeather['the_temp'] as double,
      maxTemp: consolidatedWeather['max_temp'] as double,
      locationId:  jsonObject['woeid'] as int,
      created: consolidatedWeather['created'],
      lastUpdate: DateTime.now(),
      location: jsonObject['title']
    );
  }

  static WeatherCondition _mapStringToWeatherCondition(String inputString) {
    Map<String, WeatherCondition> map = {
      'sn': WeatherCondition.snow,
      'sl': WeatherCondition.sleet,
      'h': WeatherCondition.hail,
      't': WeatherCondition.thunderstorm,
      'hr': WeatherCondition.heavyRain,
      'lr': WeatherCondition.lightRain,
      's': WeatherCondition.showers,
      'hc': WeatherCondition.heavyCloud,
      'lc': WeatherCondition.lightCloud,
      'c': WeatherCondition.clear
    };
    return map[inputString] ?? WeatherCondition.unknown;
  }
}
