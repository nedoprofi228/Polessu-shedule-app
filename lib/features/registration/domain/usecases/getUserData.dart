import 'package:application/features/registration/domain/entities/User.dart';
import 'package:application/features/registration/domain/repository/registerRepo.dart';

class GetUserDataUsecase {
  final RegisterRepository registerRepository;

  const GetUserDataUsecase({required this.registerRepository});

  Future<User?> call() async {
    return await registerRepository.getUserGroup();
  }
}
