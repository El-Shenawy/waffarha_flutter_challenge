/// A model class that represents a photo.
class Photo {
  /// The ID of the photo.
  final int id;

  /// The ID of the album that the photo belongs to.
  final int albumId;

  /// The title of the photo.
  final String title;

  /// The URL of the thumbnail image for the photo.
  final String thumbnailUrl;

  /// The URL of the full-size image for the photo.
  final String url;

  /// Creates a new instance of the [Photo] class.
  ///
  /// [id] - the ID of the photo
  /// [albumId] - the ID of the album that the photo belongs to
  /// [title] - the title of the photo
  /// [thumbnailUrl] - the URL of the thumbnail image for the photo
  /// [url] - the URL of the full-size image for the photo
  Photo({
    required this.id,
    required this.albumId,
    required this.title,
    required this.thumbnailUrl,
    required this.url,
  });

  /// Creates a new instance of the [Photo] class from a JSON map.
  ///
  /// [json] - a JSON map representing a photo
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      albumId: json['albumId'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
      url: json['url'],
    );
  }
}