import 'package:breakingbad/constants/strings.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  Dio dio;
  CharactersWebServices() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(baseOptions);
  }
  Future<List<dynamic>> getAllCharacters() async{
    try{
    Response response = await dio.get('characters');
    print(response.data.toString());
    return response.data;
    }
    catch(e){
      print(e.toString());
      return [];
    }
  }
}