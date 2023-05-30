import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_services/photos_api_service.dart';
import '../models/photo.dart';

/// A controller for managing photos and albums.
class PhotoController extends GetxController {
  final _photoService = PhotosApiService();

  /// A list of all photos.
  var photos = <Photo>[].obs;

  /// A list of all albums.
  var albums = List<int>.generate(100, (i) => i + 1).obs;

  /// Whether photos are currently being loaded.
  var isLoading = true.obs;

  /// The current page being viewed.
  var currentPage = 1.obs;

  /// The number of photos to display per page.
  var pageLimit = 10;

  /// The currently selected album ID.
  var selectedAlbum = 0.obs;

  /// Whether there is no more data to load.
  var noMoreData = false.obs;

  /// Whether previous data is currently being loaded.
  var isLoadingPreviousData = false.obs;

  /// Whether next data is currently being loaded.
  var isLoadingNextData = false.obs;

  /// The key to sort photos by.
  var sortBy = 'albumId'.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading(true);
    await fetchPhotos();
    isLoading(false);
  }

  /// Fetches photos from the API.
  ///
  /// Returns a list of [Photo] objects.
  Future<dynamic> fetchPhotos() async {
    try {
      final photos = await _photoService.fetchPhotos(
          startPage: (currentPage.value - 1) * pageLimit,
          pageLimit: pageLimit,
          albumId: selectedAlbum.value == 0 ? null : selectedAlbum.value);
      if (photos.isEmpty) {
        currentPage.value--;
      } else {
        this.photos.value = photos;
      }
      checkIfNoMoreData(photos);
    } catch (e) {
      debugPrint('${e}');
    }
  }

  /// Checks whether there is no more data to load.
  ///
  /// [photos] - a list of [Photo] objects.
  checkIfNoMoreData(List<Photo> photos) {
    if (currentPage.value >= 500 || photos.isEmpty) {
      noMoreData(true);
    } else {
      noMoreData(false);
    }
  }

  /// Returns a filtered list of photos.
  List<Photo> get filteredPhotos {
    if (selectedAlbum.value == 0) {
      return photos;
    }
    return photos
        .where((photo) => photo.albumId == selectedAlbum.value)
        .toList();
  }

  /// Sets the selected album.
  ///
  /// [albumId] - the ID of the album tofilter photos by.
  void setSelectedAlbum(int albumId) {
    selectedAlbum.value = albumId;
    currentPage.value = 1; // reset to first page when filter changes
  }

  /// Sets the key to sort photos by.
  ///
  /// [sortKey] - the key to sort photos by.
  void setSortBy(String sortKey) {
    sortBy.value = sortKey;
  }

  /// Returns a sorted list of photos.
  List<Photo> get sortedPhotos {
    List<Photo> sortedList = List.from(filteredPhotos);
    sortedList.sort((a, b) {
      if (sortBy.value == 'albumId') {
        return a.albumId.compareTo(b.albumId);
      } else {
        return a.title.compareTo(b.title);
      }
    });
    return sortedList;
  }

  /// Returns a paginated list of photos.

  List<Photo> get paginatedPhotos {
    final startIndex = (currentPage.value - 1) * pageLimit;
    final endIndex = currentPage.value * pageLimit;
    final filteredPhotos = sortedPhotos
        .where((photo) =>
            selectedAlbum.value == 0 || photo.albumId == selectedAlbum.value)
        .toList();
    if (startIndex >= filteredPhotos.length) {
      currentPage.value = (filteredPhotos.length / pageLimit).ceil();
    }
    return filteredPhotos.sublist(startIndex, endIndex);
  }

  /// Loads the next page of photos.
  Future<void> nextPage() async {
    isLoadingNextData(true);
    currentPage.value++;
    await fetchPhotos();
    isLoadingNextData(false);
  }

  /// Loads the previous page of photos.
  Future<void> prevPage() async {
    if (currentPage.value > 1) {
      isLoadingPreviousData(true);
      currentPage.value--;
      await fetchPhotos();
      isLoadingPreviousData(false);
    }
  }
}
