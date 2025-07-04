abstract interface class ImageRepository {
  Future<List<String>> getImages();

  Future<void> downloadAndResizeImage({
    required String url,
  });
}
