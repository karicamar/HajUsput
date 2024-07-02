import 'package:hajusput_mobile/models/gender.dart';
import 'package:hajusput_mobile/providers/base_provider.dart';

class GenderProvider extends BaseProvider<Gender> {
  GenderProvider() : super("Gender");

  @override
  Gender fromJson(data) {
    // TODO: implement fromJson
    return Gender.fromJson(data);
  }
}
