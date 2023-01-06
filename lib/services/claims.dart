part of 'package:mawa_package/mawa_package.dart';

class Claims{
  Claims({required this.id});
  final String id;

  getClaim()async{
    return await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.claims,
      queryParameters: {
      QueryParameters.policy:id
      }
    ));
  }

}