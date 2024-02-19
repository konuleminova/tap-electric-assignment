import 'package:injectable/injectable.dart';
import 'package:weathet_app/features/weather/data/datasources/remote/weather_data_source.dart';
import 'package:weathet_app/features/weather/domain/models/base/result/result.dart';
import 'package:weathet_app/features/weather/domain/models/weather_forecast_hourly.dart';
import 'package:weathet_app/features/weather/domain/repositories/weather_repository.dart';

@injectable
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  const WeatherRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Result<WeatherForecastModel, Failure>> getWeather(
      {String? city}) async {
    final response = await remoteDataSource.getWeather(city: city);
    return response.fold(
      onSuccess: (response) => SuccessResult(response),
      onFailure: (failure) => FailureResult(failure),
    );
  }
}
