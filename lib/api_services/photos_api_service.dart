import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/photo.dart';
import '../utils/app_constant.dart';

/// A service class that communicates with the photos API.
class PhotosApiService {
  /// Fetches a list of photos from the API.
  ///
  /// [startPage] - the starting page to fetch
  /// [pageLimit] - the number of photos to fetch per page
  /// [albumId] - an optional album ID to filter photos by
  ///
  /// Returns a list of [Photo] objects.
  Future<List<Photo>> fetchPhotos({
    required int startPage,
    required int pageLimit,
    int? albumId,
  }) async {
    final url = albumId == null
        ? '$baseUrl/photos?_start=$startPage&_limit=$pageLimit'
        : '$baseUrl/photos?_start=$startPage&_limit=$pageLimit&albumId=$albumId';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final photos = data.map((json) => Photo.fromJson(json)).toList();
      return photos;
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
