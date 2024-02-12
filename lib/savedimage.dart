import 'package:flutter/material.dart';
import 'package:imagefrontend/imageprovider.dart';
import 'package:provider/provider.dart';

class SavedImagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final savedImagesProvider = Provider.of<SavedImagesProvider>(context);
    final savedImages = savedImagesProvider.savedImages;

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Images'),
      ),
      body: savedImages.isEmpty
          ? Center(child: Text('No saved images'))
          : ListView.builder(
              itemCount: savedImages.length,
              itemBuilder: (BuildContext context, int index) {
                final imageUrl = savedImages[index].imageUrl;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(imageUrl),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        savedImagesProvider.removeImage(imageUrl);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
