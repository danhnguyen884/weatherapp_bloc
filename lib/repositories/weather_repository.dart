//now weather api
//https://www.metaweather.com/
//search by location
//https://www.metaweather.com/api/location/search/?query=chicago
//by location's id
//https://www.metaweather.com/api/location/2379574/


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';
const baseUrl = 'https://www.metaweather.com';
final locationUrl = (city) => 'https://www.metaweather.com/api/location/search/?query=${city}';
final weatherUrl = (locationId) => 'https://www.metaweather.com/api/location/${locationId}';
class WeatherRepository {
  final http.Client httpClient;
  //constructor
  WeatherRepository({@required this.httpClient}): assert(httpClient != null);
  Future<int> getLocationIdFromCity(String city) async {
    final response = await this.httpClient.get(Uri.parse(locationUrl(city)));
    if(response.statusCode == 200) {
      final cities = jsonDecode(response.body) as List;
      return (cities.first)['woeid'] ?? Map();
    } else {
      throw Exception('Error getting location id of : ${city}');
    }
  }
  //LocationId => Weather
  Future<Weather> fetchWeather(int locationId) async {
    final response = await this.httpClient.get(Uri.parse(weatherUrl(locationId)));
    if(response.statusCode != 200) {
      throw Exception('Error getting weather from locationId: ${locationId}');
    }
    final weatherJson = jsonDecode(response.body);
    return Weather.fromJson(weatherJson);
  }
  Future<Weather> getWeatherFromCity(String city) async {
    final int locationId = await getLocationIdFromCity(city);
    return fetchWeather(locationId);
  }
}