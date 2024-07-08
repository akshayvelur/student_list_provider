import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_5/controller/controller.dart';
import 'package:task_5/delete.dart';
import 'package:task_5/student_add_page.dart';
import 'package:task_5/student_edit.dart';
import 'dart:io';

import 'package:task_5/student_profile.dart';

class StudentList extends StatelessWidget {
  StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<DataController>(context, listen: false).onInit();
    return Consumer<DataController>(
        builder: (context, value, child) => Scaffold(
              backgroundColor: Color.fromARGB(255, 223, 223, 223),
              appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 51, 32, 56),
                title: Text(
                  "STUDENT LIST",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
              body: value.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 15),
                          child: TextField(
                            // onChanged: (value) => value.(value),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.purple, width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                labelText: "search",
                                suffixIcon: Icon(Icons.search)),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: value.filteredStudentList.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => StudentProfile(
                                      id: value.filteredStudentList[index].id!,
                                      name:
                                          value.filteredStudentList[index].name,
                                      age: value.filteredStudentList[index].age,
                                      phone: value
                                          .filteredStudentList[index].phone,
                                      gender: value
                                          .filteredStudentList[index].gender,
                                      images: value
                                          .filteredStudentList[index].images),
                                ));
                              },
                              child: Card(
                                color: Color.fromARGB(255, 218, 218, 218),
                                margin: EdgeInsets.only(
                                    left: 12, right: 12, top: 12),
                                child: Container(
                                  height: 70,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: ListTile(
                                      title: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Text(
                                          value.filteredStudentList[index].name,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      leading: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(90)),
                                        child: ClipOval(
                                          child: Image.file(
                                            File(value
                                                .filteredStudentList[index]
                                                .images),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) => StudentEdit(
                                                      id: value
                                                          .filteredStudentList[
                                                              index]
                                                          .id!,
                                                      name: value
                                                          .filteredStudentList[
                                                              index]
                                                          .name,
                                                      age: value
                                                          .filteredStudentList[
                                                              index]
                                                          .age,
                                                      image: value
                                                          .filteredStudentList[
                                                              index]
                                                          .images,
                                                      gender: value
                                                          .filteredStudentList[
                                                              index]
                                                          .gender,
                                                      phone: value
                                                          .filteredStudentList[
                                                              index]
                                                          .phone)));
                                            },
                                            icon: Icon(Icons.edit),
                                          ),
                                          deleteButton(value, index, context),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => StudentAdd()));
                },
                child: Icon(Icons.add),
              ),
            ));
  }
}
