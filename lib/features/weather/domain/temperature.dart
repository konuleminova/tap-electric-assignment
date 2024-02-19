class Temperature {
  static num convert(num temperature, String fromUnit, String toUnit) {
    if (fromUnit == 'C' && toUnit == 'F') {
      return (temperature * 9 / 5) + 32;
    } else if (fromUnit == 'F' && toUnit == 'C') {
      return (temperature - 32) * 5 / 9;
    } else if (fromUnit == 'C' && toUnit == 'K') {
      return temperature + 273.15;
    } else if (fromUnit == 'K' && toUnit == 'C') {
      return temperature - 273.15;
    } else if (fromUnit == 'F' && toUnit == 'K') {
      return (temperature - 32) * 5 / 9 + 273.15;
    } else if (fromUnit == 'K' && toUnit == 'F') {
      return (temperature - 273.15) * 9 / 5 + 32;
    } else {
      return temperature;
    }
  }
}
