import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/settings_bloc.dart';
import 'package:weather_app/blocs/theme_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/blocs/weather_bloc_observer.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/screens/weather_screen.dart';
void main() {
  Bloc.observer = WeatherBlocObserver();
  final WeatherRepository weatherRepository = WeatherRepository(httpClient: http.Client());
  //ortherBloc?
  // runApp(
  //   MultiBlocProvider(
  //     providers: [
  //       BlocProvider<ThemeBloc>(create: (context)=>ThemeBloc()),
  //       BlocProvider<SettingsBloc>(create: (context)=>SettingsBloc())
  //     ],
  //     child: MyApp(weatherRepository: weatherRepository),
  //   ),
  // );
  runApp(
      BlocProvider<ThemeBloc>(
        create: (context) => ThemeBloc(),
        child: BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(),
          child: MyApp(weatherRepository: weatherRepository,),
        ),
      )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final WeatherRepository weatherRepository;
  MyApp({Key key, @required this.weatherRepository}) : assert(weatherRepository!=null),super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Weather App',

      home: BlocProvider(
        create: (context)=>WeatherBloc(
            weatherRepository: weatherRepository
        ),
        child: WeatherScreen(),
      )
    );
  }
}


/*
{"consolidated_weather":[{"id":6414599172653056,"weather_state_name":"Light Rain","weather_state_abbr":"lr","wind_direction_compass":"ENE","created":"2021-05-08T09:35:19.899960Z","applicable_date":"2021-05-08","min_temp":4.665,"max_temp":11.524999999999999,"the_temp":12.225,"wind_speed":5.545898510753201,"wind_direction":57.50465948545508,"air_pressure":1018.0,"humidity":51,"visibility":11.001066272965879,"predictability":75},
 */
