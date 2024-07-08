import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_5/db_helper.dart';
import 'package:task_5/model.dart';

class AddController extends ChangeNotifier {
  String groupValue = " ";

  String imagePath = " ";

  late ImageSource imageSource;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<StudentModel> allData = [];

  bool isPhotoSelected = false;

  bool photoerrorVisible = false;

  bool genderErrorVisible = false;

  initrun() {
    groupValue = '';
    imagePath = '';
    genderErrorVisible = true;
    photoerrorVisible = false;
    isPhotoSelected = false;
    notifyListeners();
  }

  Future<void> addData(String nameController, String ageController,
      String phoneController, String imageSource, String groupValue) async {
    await SQLHelper.createData(nameController, ageController, phoneController,
        imagePath.toString(), groupValue.toString());
    imagePath = "";
    genderErrorVisible = false;
    notifyListeners();
  }

  void getImage() async {
    final selectedImage = await ImagePicker().pickImage(source: imageSource);
    if (selectedImage != null) {
      imagePath = selectedImage.path;
      isPhotoSelected = true;
      notifyListeners();
    }
  }

  photoerror(bool out) {
    photoerrorVisible = out;
    notifyListeners();
  }

  genderError(bool out) {
    genderErrorVisible = out;
    notifyListeners();
  }

  grupValueAdd(var value) {
    groupValue = value;
    notifyListeners();
  }
}
