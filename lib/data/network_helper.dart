import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class NetworkHelper{
  final String _url;

  NetworkHelper(this._url);

//загрузка данных
  Future getData() async {

    //Создаем файл для кэша
    String fileName = 'pathString.json';
    var dir = await getTemporaryDirectory();
    File file = File('${dir.path}/$fileName');


    log('getting from network');
    final Response response  = await get(Uri.parse(_url));
    log('status code::: ${response.statusCode}');
    if(response.statusCode == 200){
      final String data = response.body;
      //кэшируем загруженные данные
      file.writeAsStringSync(data,flush:true,mode: FileMode.write);
      return jsonDecode(data);
    }else{
      log('${response.statusCode}');
      return 'error';
    }

  }
}
