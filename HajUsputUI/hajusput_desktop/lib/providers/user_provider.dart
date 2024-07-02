import 'package:hajusput_desktop/models/user.dart';
import 'package:hajusput_desktop/providers/base_provider.dart';

class UserProvider extends BaseProvider<User> {
  UserProvider() : super("User");

  @override
  User fromJson(data) {
    // TODO: implement fromJson
    return User.fromJson(data);
  }
}
