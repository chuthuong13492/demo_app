import 'package:demo_app/core/interfaces/dispose_able.dart';
import 'package:demo_app/core/interfaces/init_able.dart';
import 'package:demo_app/features/home/data/datasources/image_api.dart';
import 'package:demo_app/features/home/data/datasources/weather_api.dart';
import 'package:demo_app/features/home/data/repositories/image_repository.dart';
import 'package:demo_app/features/home/data/repositories/weather_repository.dart';
import 'package:demo_app/features/home/domain/repositories/image_repository.dart';
import 'package:demo_app/features/home/domain/repositories/weather_repository.dart';
import 'package:get_it/get_it.dart';

class Repository {
  Repository._();

  static final Repository _instance = Repository._();

  final GetIt _getIt = GetIt.asNewInstance();

  final Map<Type, Set<String>> _repositoryInstanceNames = {};

  /// [instanceName] if you provide a value here your factory gets registered with that
  /// name instead of a type. This should only be necessary if you need to register more
  /// than one instance of one type.
  static void register<T extends Object>(
    T repository, {
    String? instanceName,
  }) {
    _instance._getIt.registerLazySingleton<T>(
      instanceName: instanceName,
      () {
        if (repository is InitAble) {
          repository.initialize();
        }

        return repository;
      },
      dispose: (repository) {
        if (repository is DisposeAble) {
          repository.dispose();
        }
      },
    );
    _instance._addInstanceName<T>(instanceName ?? '');
  }

  static void initialize() {
    _instance.repositoryRegister();
  }

  static T get<T extends Object>({
    String? instanceName,
  }) {
    return _instance._getIt.get<T>(
      instanceName: instanceName,
    );
  }

  static T? getOrNull<T extends Object>({
    String? instanceName,
  }) {
    if (_instance._getIt.isRegistered<T>()) {
      return _instance._getIt.get<T>(
        instanceName: instanceName,
      );
    }

    return null;
  }

  static List<T> getAll<T extends Object>() {
    final Set<String> names = _instance._repositoryInstanceNames[T] ?? {};

    return names.map((name) => get<T>(instanceName: name)).toList();
  }

  static Future<void> reset() async {
    await _instance._getIt.reset();
    _instance.repositoryRegister();
  }

  void _addInstanceName<T extends Object>(String instanceName) {
    if (_repositoryInstanceNames.containsKey(T)) {
      _repositoryInstanceNames[T]!.add(instanceName);
    } else {
      _repositoryInstanceNames[T] = {instanceName};
    }
  }

  void repositoryRegister() {
    Repository.register<WeatherRepository>(
      WeatherRepositoryImpl(
        weatherApi: WeatherApiImpl(),
      ),
    );

    Repository.register<ImageRepository>(
      ImageRepositoryImpl(
        imageApi: ImageApiImpl(),
      ),
    );
  }
}
