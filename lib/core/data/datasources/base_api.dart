import '../../services/network_service.dart';

abstract interface class _BaseApi {
  DioNetworkService get client;
}

abstract class MainApi implements _BaseApi {
  @override
  final DioNetworkService client = AuthNetworkService.instance;

  final DioNetworkService noAuthClient = NoAuthNetworkService.instance;
}
