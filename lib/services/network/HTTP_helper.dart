import 'package:http/http.dart' as http;

class HTTPHelper{

  var client = http.Client();
  Uri url;
  Map<String,String>? headers;
  Map<String,String>? body;

  HTTPHelper(this.url);

  Future<http.Response> getData() async{
    return await client.get(url,headers: headers);
  }

  Future<http.Response> postData() async{
    return await client.post(url,headers: headers,body: body);
  }

}