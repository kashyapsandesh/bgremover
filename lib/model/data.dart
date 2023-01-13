import 'package:http/http.dart' as http;

class Api {
  static const apikey = "n34c2x8iChJHjjdqVVgpGRLf";
  static var baseUrl = Uri.parse("https://api.remove.bg/v1.0/removebg");
  static removebg(String imagepath) async {
    var req = http.MultipartRequest("POST", baseUrl);
    req.headers.addAll({"X-API-Key": apikey});
    req.files.add(await http.MultipartFile.fromPath("image_file", imagepath));
    final res = await req.send();
    if (res.statusCode == 200) {
      http.Response img = await http.Response.fromStream(res);
      print(img.bodyBytes);
      return img.bodyBytes;
    } else {
      print("Failed to fetch data");
      return null;
    }
  }
}
