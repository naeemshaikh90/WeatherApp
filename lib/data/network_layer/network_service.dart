import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:weather_app/data/network_layer/api_end_points.dart';
import 'package:weather_app/data/network_layer/api_exceptions.dart';
import 'package:weather_app/data/network_layer/api_services.dart';
import 'package:weather_app/data/network_layer/api_status_code.dart';

enum HeaderType { ApiKey }

enum HttpMethod { GET, POST, PUT, DELETE }

abstract class NetworkService {
  http.Response get httpResponse;

  Future<http.Response> callApi({
    HttpMethod httpMethod,
    HeaderType headerType,
    String url,
    dynamic body,
    bool cancelPreviousRequest: false,
  });
}

class INetworkService extends NetworkService {
  HttpMethod _httpMethod;
  Map<String, String> _header;
  String _url;
  dynamic _body;
  IOClient client = IOClient();

  http.Response _httpResponse;

  @override
  http.Response get httpResponse => _httpResponse;

  @override
  Future<http.Response> callApi({
    HttpMethod httpMethod,
    HeaderType headerType,
    String url,
    body,
    bool cancelPreviousRequest = false,
  }) async {
    this._httpMethod = httpMethod;

    this._url = url;

    this._body = body;

    //get header as per its type
    this._header = _getHeader(headerType: headerType);

    if (cancelPreviousRequest) {
      client.close();
      client = IOClient();
    }

    return _makeHttpCall();
  }

  Map<String, String> _getHeader({
    HeaderType headerType,
  }) {
    Map<String, String> _createHeader({
      String apiKey,
      String apiHOst,
    }) {
      Map<String, String> map = Map<String, String>();
      map.putIfAbsent("x-rapidapi-key", () => apiKey);
      map.putIfAbsent("x-rapidapi-host", () => apiHOst);
      return map;
    }

    Map<String, String> header;
    switch (headerType) {
      case HeaderType.ApiKey:
        header = _createHeader(
          apiKey: ApiEndPoints().apiKey,
          apiHOst: ApiEndPoints().apiHost,
        );
        break;
    }
    return header;
  }

  Future<http.Response> _makeHttpCall() async {
    http.Response _response;

    //call api as per its method type
    _response = await _getHttpResponse(
      httpMethod: _httpMethod,
      header: _header,
      url: _url,
      body: _body,
    );

    http.Response _checkResponse;
    try {
      _checkResponse = _validateResponse(response: _response);
    } catch (exception) {
      _httpResponse = _response;
      throw exception;
    }
    return _checkResponse;
  }

  Future<http.Response> _getHttpResponse({
    HttpMethod httpMethod,
    Map<String, String> header,
    String url,
    dynamic body,
  }) async {
    http.Response _response;
    switch (httpMethod) {
      case HttpMethod.GET:
        _response = await client.get(
          url + body,
          headers: header,
        );
        break;
      case HttpMethod.POST:
        _response = await client.post(
          url,
          headers: header,
          body: body,
        );
        break;
      case HttpMethod.PUT:
        _response = await client.put(
          url,
          headers: header,
          body: body,
        );
        break;
      case HttpMethod.DELETE:
        _response = await client.delete(
          url,
          headers: header,
        );
    }
    return _response;
  }

  http.Response _validateResponse({http.Response response}) {
    if (ApiStatusCode.statusCode200Ok == response.statusCode) {
      return response;
    }

    switch (response.statusCode) {
      case ApiStatusCode.statusCode200Ok:
        return response;

      case ApiStatusCode.statusCode400BadRequest:
        throw BadRequestException();

      case ApiStatusCode.statusCode401Unauthorized:
        throw UnauthorizedException();

      case ApiStatusCode.statusCode403Forbidden:
        throw ForbiddenException();

      case ApiStatusCode.statusCode404NotFound:
        throw NotFoundException();

      case ApiStatusCode.statusCode500InternalServerError:
        throw InternalServerErrorException();

      case ApiStatusCode.statusCode503ServiceUnavailable:
        throw ServiceUnavailableException();

      case ApiStatusCode.statusCode504GatewayTimeout:
        throw GatewayTimeoutException();

      default:
        throw DefaultException();
    }
  }

}
