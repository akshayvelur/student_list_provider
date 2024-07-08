import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_5/controller/add_controller.dart';
import 'dart:io';
import 'student_list.dart';
import 'package:flutter/services.dart';
import 'db_helper.dart';
import 'package:image_picker/image_picker.dart';

class StudentAdd extends StatelessWidget {
  StudentAdd({Key? key}) : super(key: key);

  // void refreshData() async {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<AddController>(context, listen: false).initrun;
    return Consumer<AddController>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(MaterialPage(child: StudentList()));
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          title: Text(
            "ADD STUDENT",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 51, 32, 56),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(255, 83, 5, 114))),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Camera',
                                        style: myStyle(
                                            18, FontWeight.bold, Colors.black),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            value.imageSource =
                                                ImageSource.camera;
                                            value.getImage();
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                          },
                                          icon: Icon(
                                            Icons.camera_alt_outlined,
                                            size: 35,
                                            color: Colors.black,
                                          ))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Gallery',
                                        style: myStyle(
                                            18, FontWeight.bold, Colors.black),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            value.imageSource =
                                                ImageSource.gallery;
                                            value.getImage();
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                          },
                                          icon: Icon(
                                            Icons.photo_outlined,
                                            size: 35,
                                            color: Colors.black,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ));
                  },
                  child: Center(
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 71, 67, 67)),
                      child: value.imagePath == null
                          ? Image.asset(
                              'assets/users.png',
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(
                                value.imagePath,
                              ),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Positioned(
                    right: 70,
                    top: 100,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Color.fromARGB(255, 247, 247, 247),
                    )),
                Positioned(right: 80, top: 107, child: Icon(Icons.add_a_photo))
              ],
            ),
            SizedBox(
              height: 15,
            ),
            if (value.photoerrorVisible && value.imagePath == null)
              Text(
                'Please add a photo',
                style: TextStyle(color: Colors.red),
              ),
            Form(
              key: value.formKey,
              child: Container(
                width: double.infinity,
                height: 360,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 83, 5, 114),
                                  width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          labelText: "Name"),
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      validator: (value) {
                        if (value == "") {
                          return "please enter your name";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 83, 5, 114),
                                  width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          labelText: "Age"),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(2)
                      ],
                      controller: ageController,
                      validator: (value) {
                        if (value == "") {
                          return "please enter your age";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 83, 5, 114),
                                  width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          labelText: "Phone Number"),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      controller: phoneController,
                      validator: (value) {
                        if (value == "") {
                          return "please enter your phone Number";
                        } else if (value!.length != 10) {
                          return "phone number not valid";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Select Gender :',
                          style: myStyle(16, FontWeight.bold, Colors.black),
                        ),
                        Row(
                          children: [
                            Radio(
                                activeColor: Colors.red,
                                value: 'Male',
                                groupValue: value.groupValue,
                                onChanged: (change) {
                                  value.grupValueAdd(change);
                                  // setState(() {
                                  //   groupValue = value;
                                  // });
                                }),
                            Text('Male',
                                style:
                                    myStyle(12, FontWeight.bold, Colors.black)),
                            Radio(
                                activeColor: Colors.red,
                                value: 'Female',
                                groupValue: value.groupValue,
                                onChanged: (change) {
                                  value.grupValueAdd(change);
                                  // setState(() {
                                  //   groupValue = value;
                                  // });
                                }),
                            Text('Female',
                                style:
                                    myStyle(12, FontWeight.bold, Colors.black))
                          ],
                        ),
                      ],
                    ),
                    if (value.genderErrorVisible && value.groupValue == null)
                      Text(
                        'Please select a gender',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        Color.fromARGB(255, 51, 27, 82))),
                onPressed: () async {
                  if (!value.isPhotoSelected) {
                    // setState(() {
                    //   photoerrorVisible = true;
                    // });
                    value.photoerror(true);
                  }
                  if (value.groupValue == null) {
                    // setState(() {
                    //   genderErrorVisible = true;
                    // });
                    value.genderError(true);
                  }
                  if (value.formKey.currentState!.validate() &&
                      value.isPhotoSelected == true &&
                      value.groupValue != null) {
                    await value.addData(
                        nameController.text,
                        ageController.text,
                        phoneController.text,
                        value.imageSource.toString(),
                        value.groupValue.toString());
                   
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => StudentList()),
                        (route) => false);
                  } else {
                    return;
                  }
                },
                child: Text(
                  "ADD STUDENT",
                  style: TextStyle(color: Colors.white),
                ))
          ]),
        ),
      ),
    );
  }
}

myStyle(double size, FontWeight weight, Color clr) {
  return TextStyle(fontSize: size, fontWeight: weight, color: clr);
}
