import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_5/student_list.dart';

class StudentProfile extends StatelessWidget {
  final int id;
  final String name;
  final String age;
  final String phone;
  final String gender;
  final String images;

  const StudentProfile(
      {super.key,
      required this.id,
      required this.name,
      required this.age,
      required this.phone,
      required this.gender,
      required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(MaterialPage(child: StudentList()));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 83, 5, 114),
        title: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: FileImage(File('$images')),
                  radius: 70,
                ),
                SizedBox(
                  height: 30,
                ),
                Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromARGB(255, 223, 221, 221),
                      ),
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.height * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(0, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(8)),
                              width: double.infinity,
                              child: Text(
                                "  NAME                      :  ${name.toUpperCase()}",
                                style: GoogleFonts.oswald(),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(0, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(8)),
                              width: double.infinity,
                              child: Text(
                                "  AGE                         :  $age",
                                style: GoogleFonts.oswald(),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(0, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(8)),
                              width: double.infinity,
                              child: Text(
                                "  GENDER                  :  ${gender.toUpperCase()}",
                                style: GoogleFonts.oswald(),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(0, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(8)),
                              width: double.infinity,
                              child: Text(
                                " PHONE NUMBER     :  $phone",
                                style: GoogleFonts.oswald(),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
