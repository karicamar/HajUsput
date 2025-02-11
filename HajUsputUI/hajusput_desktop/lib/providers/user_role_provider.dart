import 'package:hajusput_desktop/models/userRole.dart';
import 'package:hajusput_desktop/providers/base_provider.dart';

class UserRoleProvider extends BaseProvider<UserRole> {
  UserRoleProvider() : super("UserRole");

  @override
  UserRole fromJson(data) {
    // TODO: implement fromJson
    return UserRole.fromJson(data);
  }
}
