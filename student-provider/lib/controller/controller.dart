import 'package:flutter/material.dart';
import 'package:task_5/db_helper.dart';
import 'package:task_5/model.dart';

class DataController extends ChangeNotifier {
  List<StudentModel> studentList = <StudentModel>[];
  List<StudentModel> filteredStudentList = <StudentModel>[];
  bool isLoading = true;

  // void refreshData() async {
  //   final data = await SQLHelper.getAllData();

  // //   studentList = data;
  // //  filteredStudentList= data;
  //   notifyListeners();
  // }

  void onInit() async {
    isLoading = true;
    notifyListeners();
    await fetchStudents();
    filteredStudentList = [...studentList];
    // refreshData();
    isLoading = false;
    notifyListeners();
  }

  fetchStudents() async {
    try {
      var studentsData = await SQLHelper.getAllData();
      List<StudentModel> students = studentsData.map((student) {
        return StudentModel(
            id: student['id'],
            name: student['name'],
            age: student['age'],
            gender: student['gender'],
            images: student['images'],
            phone: student['phone']);
      }).toList();
      studentList.clear();

      studentList.addAll(students);
      runFilter("");
      notifyListeners();

      print("hello $studentList");
    } catch (e) {
      // log("error while fetching $e");
    }
  }
    runFilter(String query) {
    if (query.isEmpty) {
      filteredStudentList = [...studentList];
    } else {
      filteredStudentList = studentList
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // void runfilter(String enteredKeyword) {
  //   List<Map<String, dynamic>> results = [];
  //   if (enteredKeyword.isEmpty) {
  //     results = allData;
  //   } else {
  //     results = allData
  //         .where((element) => element['name']
  //             .toLowerCase()
  //             .contains(enteredKeyword.toLowerCase()))
  //         .toList();
  //   }

  //   foundUsers = results;
  //   notifyListeners();
  // }
//    delete(int id)async{
// await SQLHelper.deleteData(id);
//    }
  notifyListeners();
}
