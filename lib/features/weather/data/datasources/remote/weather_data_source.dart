import 'package:injectable/injectable.dart';
import 'package:weathet_app/features/weather/data/datasources/remote/weather_api.dart';
import 'package:weathet_app/features/weather/domain/models/base/result/result.dart';
import 'package:weathet_app/features/weather/domain/models/weather_forecast_hourly.dart';

@LazySingleton()
@injectable
class WeatherRemoteDataSource {
  const WeatherRemoteDataSource({
    @Named('WeatherApi') required this.weatherApi,
  });

  final WeatherApi weatherApi;

  Future<Result<WeatherForecastModel, Failure>> getWeather(
      {String? city}) async {
    try {
      final response = await weatherApi.fetchWeatherForecast(cityName: city);
      if (response.current == null) {
        throw Exception('City not found');
      }
      return SuccessResult(response);
    } catch (e) {
      return FailureResult(UnexpectedFailure(e.toString()));
    }
  }
}
