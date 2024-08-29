import 'package:image_picker/image_picker.dart';

Future<XFile?> imagePick() async {
  try {
    final picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.gallery);
  } catch (e) {
    throw e.toString();
  }
}
