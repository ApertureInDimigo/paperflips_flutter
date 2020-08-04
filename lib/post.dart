import 'dart:io';
import 'dart:convert';


 class post {

postyou() async {
  var apiUrl = Uri.parse(''); //URL
  var client = HttpClient(); // `new` keyword optional

  // 1. Create request
  HttpClientRequest request = await client.postUrl(apiUrl);

  // 2. Add payload to request
  var payload = {
    'id': 'Post 1',                                       
    'password': 'Lorem ipsum dolor sit amet',
    "name" : "누구세요",
  };
  request.write(json.encode(payload));

  // 3. Send the request
  HttpClientResponse response = await request.close();

  // 4. Handle the response
  var resStream = response.transform(Utf8Decoder());
  await for (var data in resStream) {
    print('Received data: $data');
  }
}


}

