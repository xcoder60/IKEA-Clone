
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'global.dart';

class ApiConsumer{
  Future<Uint8List> RemoveBackgroundApi (String imagePath) async{


    var apiRequest = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.remove.bg/v1.0/removebg")
    );
    
    apiRequest.files.add(
      await http.MultipartFile.fromPath(
        "image_file",
        imagePath
      )
    );

    apiRequest.headers.addAll({
      "X-API-Key": ApiRemoveBackground
    });

     final responseFromApi = await apiRequest.send();

     if(responseFromApi.statusCode == 200){

       http.Response imagefromresponse = await http.Response.fromStream(responseFromApi);
       return imagefromresponse.bodyBytes;


     }
     else
     {
       throw Exception("Error Occured :: " + responseFromApi.statusCode.toString() );

     }
  }
}