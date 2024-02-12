import 'package:flutter/material.dart';
import 'package:imagefrontend/imagesclass.dart';

class SavedImagesProvider extends ChangeNotifier {
  final List<ImageItem> _savedImages = [];

  List<ImageItem> get savedImages => _savedImages;

  void toggleSave(String imageUrl) {
    final index = _savedImages.indexWhere((item) => item.imageUrl == imageUrl);
    if (index != -1) {
      _savedImages.removeAt(index);
    } else {
      _savedImages.add(ImageItem(imageUrl: imageUrl, isSaved: true));
    }
    notifyListeners();
  }

  void removeImage(String imageUrl) {
    _savedImages.removeWhere((item) => item.imageUrl == imageUrl);
    notifyListeners();
  }
}
