import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? selectedMedia;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Text Recognition"),
      ),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          try {
            List<MediaFile>? media = await GalleryPicker.pickMedia(
                context: context, singleMedia: true);
            if (media != null && media.isNotEmpty) {
              var data = await media.first.getFile();
              if (data != null) {
                setState(() {
                  selectedMedia = data;
                });
              }
            }
          } catch (e) {
            // Handle any errors here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to pick image: $e')),
            );
          } finally {
            setState(() {
              _isLoading = false;
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildUI() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_isLoading)
          const CircularProgressIndicator()
        else
          _imageView(),
      ],
    );
  }

  Widget _imageView() {
    if (selectedMedia == null) {
      return const Center(
        child: Text("Pick an image for text recognition"),
      );
    }
    return Center(
      child: Image.file(selectedMedia!, width: 200),
    );
  }
}
