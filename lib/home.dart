// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imagefrontend/imageprovider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> photoUrls = [];

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    const String apiKey =
        'KiAo831SI6PsI3uD7W9lc7vXkCw4Fk4Z5ODTSiEPN3oEU2oGyqeRI6Rt';
    const String url = 'https://api.pexels.com/v1/curated?per_page=10';
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': apiKey,
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> photos = data['photos'];
      setState(() {
        photoUrls = photos
            .map<String>((photo) => photo['src']['medium'] as String)
            .toList();
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pexels Photos'),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/savedimage');
          },
          icon: const Icon(Icons.save),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<SavedImagesProvider>(
          builder: (context, savedImagesProvider, _) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
              ),
              itemCount: photoUrls.length,
              itemBuilder: (BuildContext context, int index) {
                final imageUrl = photoUrls[index];
                final isSaved = savedImagesProvider.savedImages
                    .any((item) => item.imageUrl == imageUrl);
                return GestureDetector(
                  onTap: () {
                    savedImagesProvider.toggleSave(imageUrl);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(
                        imageUrl,
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        bottom: 8.0,
                        child: Icon(
                          isSaved ? Icons.favorite : Icons.favorite_border,
                          color: isSaved ? Colors.red : Colors.white,
                          size: 24.0,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
