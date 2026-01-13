import 'package:application/common/Registerbloc/registrationBloc.dart';
import 'package:application/common/data/GroupRepositoryImp.dart';
import 'package:application/common/repositories/GroupRepository.dart';
import 'package:application/common/searchGroupBloc/SearchGroupBloc.dart';
import 'package:application/common/services/SearchGroupService.dart';
import 'package:application/common/usecases/GetGroupsUsecase.dart';
import 'package:application/features/SearchShedule/Data/SearchGroupRepoImp.dart';
import 'package:application/features/SearchShedule/Domain/repositories/SearchGroupRepo.dart';
import 'package:application/features/SearchShedule/Domain/usecases/deleteHistoryUsecase.dart';
import 'package:application/features/SearchShedule/Domain/usecases/deleteSearchHistoryUsecase.dart';
import 'package:application/features/SearchShedule/Domain/usecases/getSearchHistory.dart';
import 'package:application/features/SearchShedule/Domain/usecases/saveSearchInHistory.dart';
import 'package:application/features/Shedule/Data/SheduleParser.dart';
import 'package:application/features/Shedule/Data/SheduleRepositoryImpl.dart';
import 'package:application/features/Shedule/Domain/repository/SheduleRepository.dart';
import 'package:application/features/Shedule/Domain/usecases/GetAllShedule.dart';
import 'package:application/features/Shedule/Presentation/Bloc/SheduleBloc.dart';
import 'package:application/features/registration/data/RegisterReposytoryImp.dart';
import 'package:application/features/registration/domain/repository/registerRepo.dart';
import 'package:application/features/registration/domain/usecases/getUserData.dart';
import 'package:application/features/registration/domain/usecases/saveUSerData.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

var getIt = GetIt.instance;

class Di {
  void Init() {
    getIt.registerFactory<Shedulebloc>(
      () => Shedulebloc(getAllSheduleUsecase: getIt()),
    );
    getIt.registerFactory<RegistrationBloc>(
      () => RegistrationBloc(getUserData: getIt(), saveUserData: getIt()),
    );
    getIt.registerFactory<SearchGroupBloc>(
      () => SearchGroupBloc(
        deletehistoryusecase: getIt(),
        getGroupsUsecase: getIt(),
        searchService: getIt(),
        getSearchHistory: getIt(),
        saveSearchInHistoryUsecase: getIt(),
        deleteSearchHistoryUsecase: getIt(),
      ),
    );

    getIt.registerLazySingleton<SearchGroupRepo>(() => SearchGroupRepoImp());
    getIt.registerLazySingleton<SheduleRepository>(
      () => Shedulerepositoryimpl(dio: getIt(), parser: getIt()),
    );
    getIt.registerLazySingleton<RegisterRepository>(
      () => RegisterReposytoryImp(),
    );
    getIt.registerLazySingleton<GroupRepository>(() => GroupRepositoryImp());

    getIt.registerLazySingleton<SearchGtroupService>(
      () => SearchGtroupService(),
    );
    getIt.registerLazySingleton<Dio>(() => Dio());
    getIt.registerLazySingleton<Sheduleparser>(() => Sheduleparser());
    getIt.registerLazySingleton<Getallshedule>(
      () => Getallshedule(repository: getIt()),
    );

    getIt.registerLazySingleton<Deletehistoryusecase>(
      () => Deletehistoryusecase(repository: getIt()),
    );
    getIt.registerLazySingleton<DeleteSearchHistoryUsecase>(
      () => DeleteSearchHistoryUsecase(repository: getIt()),
    );
    getIt.registerLazySingleton<GetUserDataUsecase>(
      () => GetUserDataUsecase(registerRepository: getIt()),
    );
    getIt.registerLazySingleton<SaveUserDataUsecase>(
      () => SaveUserDataUsecase(registerRepository: getIt()),
    );
    getIt.registerLazySingleton<GetSearchHistory>(
      () => GetSearchHistory(repository: getIt()),
    );
    getIt.registerLazySingleton<SaveSearchInHistoryUsecase>(
      () => SaveSearchInHistoryUsecase(repository: getIt()),
    );
    getIt.registerLazySingleton<GetGroupsUsecase>(
      () => GetGroupsUsecase(repository: getIt()),
    );
  }
}
