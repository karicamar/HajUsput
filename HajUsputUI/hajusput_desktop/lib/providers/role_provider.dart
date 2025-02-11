import 'package:hajusput_desktop/models/role.dart';
import 'package:hajusput_desktop/providers/base_provider.dart';

class RoleProvider extends BaseProvider<Role> {
  RoleProvider() : super("Role");

  @override
  Role fromJson(data) {
    // TODO: implement fromJson
    return Role.fromJson(data);
  }
}
