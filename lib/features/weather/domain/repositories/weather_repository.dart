import 'package:weathet_app/features/weather/domain/models/base/result/result.dart';
import 'package:weathet_app/features/weather/domain/models/weather_forecast_hourly.dart';

abstract class WeatherRepository {
  Future<Result<WeatherForecastModel, Failure>> getWeather({String? city});
}
