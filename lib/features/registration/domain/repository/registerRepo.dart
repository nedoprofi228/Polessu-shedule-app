import 'package:application/features/registration/domain/entities/User.dart';

abstract class RegisterRepository {
  Future<User?> getUserGroup();
  Future<bool> saveUserGroup(User user);
}
