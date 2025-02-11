import 'package:hajusput_mobile/models/carMake.dart';
import 'package:hajusput_mobile/providers/base_provider.dart';

class CarMakeProvider extends BaseProvider<CarMake> {
  CarMakeProvider() : super("CarMake");

  @override
  CarMake fromJson(data) {
    // TODO: implement fromJson
    return CarMake.fromJson(data);
  }
}
