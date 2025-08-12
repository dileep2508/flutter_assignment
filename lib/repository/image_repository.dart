// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ImageRepository {
//   Future<List<Map<String, String>>> fetchImages() async {
//     final response = await http.get(Uri.parse('https://picsum.photos/v2/list?limit=10'));
//     if (response.statusCode == 200) {
//       final List data = json.decode(response.body);
//       return data
//     .map((e) => {
//           'url': e['download_url'].toString(),
//           'author': e['author'].toString(),
//           'description': 'Photo by ${e['author']}',
//         })
//     .toList();

//     } else {
//       throw Exception('Failed to load images');
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageRepository {
  Future<List<Map<String, String>>> fetchImages() async {
    final response = await http.get(
      Uri.parse('https://picsum.photos/v2/list?limit=10'),
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      return data.map((e) {
        final id = e['id'].toString();
        // Set a fixed width, height adjusts automatically in Flutter
        final imageUrl = 'https://picsum.photos/id/$id/800';

        return {
          'url': imageUrl,
          'author': e['author'].toString(),
          'description': 'Photo by ${e['author']}',
        };
      }).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}
