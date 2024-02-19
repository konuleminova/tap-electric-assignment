import 'package:flutter/material.dart';
import 'package:weathet_app/features/weather/presentation/weather.dart';
import 'package:weathet_app/di/di.dart';
class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    _textEditingController.text = '';
    super.initState();
  }

  void _searchWeather() {
    if (_textEditingController.text.length < 3) {
      return;
    }
    getIt<WeatherCubit>().onSubmitSearch(_textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: 'Enter city name',
              ),
              onSubmitted: (_) => _searchWeather(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _searchWeather,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
