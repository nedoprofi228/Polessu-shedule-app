import 'package:application/features/registration/domain/entities/User.dart';
import 'package:application/features/registration/domain/repository/registerRepo.dart';

class SaveUserDataUsecase {
  final RegisterRepository registerRepository;

  const SaveUserDataUsecase({required this.registerRepository});

  Future<bool> call(User user) async {
    return await registerRepository.saveUserGroup(user);
  }
}
