import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/image_pick.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? selectedMedia;
  bool _isLoading = false;

  void _selectImage() async {
    final res = await imagePick().catchError((e) {
      debugPrint(e.toString());
      return null;
    });

    if (res != null) {
      selectedMedia = File(res.path);
      _isLoading = false;
      setState(() {});
    }
  }

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
          _selectImage();
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
          const Center(child: CircularProgressIndicator())
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
