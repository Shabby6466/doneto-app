part of 'remote_data_source.dart';

@LazySingleton(as: RemoteDataSource)
class RemoteDataSourceImp extends RemoteDataSource {
  final HttpApiCalls _httpApiCalls;
  final Logger _logger;


  RemoteDataSourceImp({
    required HttpApiCalls networkCallsWrapper,
    required Logger logger,
  })  : _logger = logger,
        _httpApiCalls = networkCallsWrapper;


  @override
  Future<GoogleAuthOutputs> googleAuth(GoogleAuthInput params) async {
    final res = await _httpApiCalls.onPost(
        api: ApiString.googleAuth, data: params.toJson());
    _logger.i('[UNICE Remote DataSource | googleAuth] $res');
    return GoogleAuthOutputs.fromJson(res.data['data']);
  }


}
