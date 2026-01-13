import 'package:application/common/repositories/GroupRepository.dart';

class GetGroupsUsecase {
  final GroupRepository repository;

  const GetGroupsUsecase({required this.repository});

  Future<List<String>> call() async {
    return await repository.getGroups();
  }
}
