import 'dart:io';
import 'package:ecommerce/models/movie.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

class AddMovie extends StatefulWidget {
  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  var formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController noOfSeatsController = TextEditingController();

  FocusNode nameNode = FocusNode();
  FocusNode descriptionNode = FocusNode();
  FocusNode noOfSeatsNode = FocusNode();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  File selectedImage;

  TimeOfDay fromTime;
  TimeOfDay toTime;
  String imagePath = "Image Path";

  bool onPressedSave = false;
  @override
  void setState(fn) async {
    // TODO: implement setState
    super.setState(fn);
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Add Movie",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: TextFormField(
                      focusNode: nameNode,
                      controller: nameController,
                      style: TextStyle(fontSize: 20),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Enter Movie Name...",
                        hintMaxLines: 1,
                        hintStyle:
                            TextStyle(color: Colors.black87, fontSize: 17),
                        labelText: "Movie Name",
                        labelStyle:
                            TextStyle(color: Colors.black87, fontSize: 22),
                        prefixIcon: Icon(
                          Icons.movie_creation,
                          color: Colors.black87,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            gapPadding: 20),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Movie Name is Required";
                        }
                        return null;
                      },
                      cursorColor: Colors.blue,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(descriptionNode),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: TextFormField(
                      focusNode: descriptionNode,
                      controller: descriptionController,
                      maxLines: 3,
                      style: TextStyle(fontSize: 20),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Enter Movie Description...",
                        hintMaxLines: 1,
                        hintStyle:
                            TextStyle(color: Colors.black87, fontSize: 17),
                        labelText: "Movie Description",
                        labelStyle:
                            TextStyle(color: Colors.black87, fontSize: 22),
                        prefixIcon: Icon(
                          Icons.description,
                          color: Colors.black87,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            gapPadding: 20),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Movie Description is Required";
                        }
                        return null;
                      },
                      obscureText: false,
                      enableSuggestions: true,
                      cursorColor: Colors.blue,
                      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 10, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.image,
                          size: 25,
                        ),
                        Expanded(
                          child: Text(
                            imagePath,
                            style: TextStyle(fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: RaisedButton(
                            onPressed: () async {
                              await pickImage(ImageSource.gallery);
                              if (selectedImage != null) {
                                setState(() {
                                  imagePath = selectedImage.path;
                                });
                              }
                            },
                            child: Text("Browse"),
                            color: Colors.lightBlue,
                          ),
                        ),
                        RaisedButton(
                          onPressed: () async {
                            await pickImage(ImageSource.camera);
                            if (selectedImage != null) {
                              setState(() {
                                imagePath = selectedImage.path;
                              });
                            }
                          },
                          child: Text("Capture"),
                          color: Colors.lightBlue,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 10, left: 20),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.timelapse,
                            size: 25,
                          ),
                        ),
                        Text(
                          "Show Time",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "   From",
                          style: TextStyle(fontSize: 15),
                        ),
                        Container(
                          width: 80,
                          height: 40,
                          margin: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: fromController,
                            onTap: () async {
                              fromTime = TimeOfDay.now();
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              TimeOfDay picked = await showTimePicker(
                                  context: context, initialTime: fromTime);
                              if (picked != null && picked != fromTime) {
                                setState(() {
                                  fromTime = picked;
                                  if (fromTime.period == DayPeriod.am) {
                                    fromController.text =
                                        fromTime.hour.toString() +
                                            ":" +
                                            fromTime.minute.toString() +
                                            " am";
                                  } else {
                                    fromController.text =
                                        fromTime.hour.toString() +
                                            ":" +
                                            fromTime.minute.toString() +
                                            " pm";
                                  }
                                  print(fromController.text);
                                });
                              }
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'time is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        Text(
                          "   to ",
                          style: TextStyle(fontSize: 15),
                        ),
                        Container(
                          width: 75,
                          height: 40,
                          margin: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: toController,
                            onTap: () async {
                              toTime = TimeOfDay.now();
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              TimeOfDay picked = await showTimePicker(
                                  context: context, initialTime: toTime);
                              if (picked != null && picked != toTime) {
                                setState(() {
                                  toTime = picked;
                                  if (toTime.period == DayPeriod.am) {
                                    toController.text = toTime.hour.toString() +
                                        ":" +
                                        toTime.minute.toString() +
                                        " am";
                                  } else {
                                    toController.text = toTime.hour.toString() +
                                        ":" +
                                        toTime.minute.toString() +
                                        " pm";
                                  }
                                });
                              }
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'time is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15, right: 10, left: 10),
                    child: TextFormField(
                      focusNode: noOfSeatsNode,
                      controller: noOfSeatsController,
                      style: TextStyle(fontSize: 20),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter Num of Seats...",
                        hintMaxLines: 1,
                        hintStyle:
                            TextStyle(color: Colors.black87, fontSize: 17),
                        labelText: "Num of Seats",
                        labelStyle:
                            TextStyle(color: Colors.black87, fontSize: 22),
                        prefixIcon: Icon(
                          Icons.add,
                          color: Colors.black87,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            gapPadding: 20),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Num of Seats is Required";
                        }
                        return null;
                      },
                      obscureText: false,
                      enableSuggestions: true,
                      cursorColor: Colors.blue,
                      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                    ),
                  ),
                  if (onPressedSave == true)
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        top: 25,
                      ),
                      child: CircularProgressIndicator(),
                    )
                  else
                    Container(),
                  Container(
                    width: 150,
                    height: 50,
                    margin: EdgeInsets.only(top: 15),
                    child: FlatButton(
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          if (imagePath == "Image Path") {
                            showSnackBar("Please Choose Movie Image");
                          } else {
                            setState(() {
                              onPressedSave = true;
                            });
                            Movie movie = new Movie();
                            movie.name = nameController.text.toString();
                            movie.description =
                                descriptionController.text.toString();
                            movie.from = fromController.text;
                            movie.to = toController.text;
                            movie.noOfSeats =
                                int.parse(noOfSeatsController.text);
                            await movie.addMovie(movie, selectedImage);
                            setState(() {
                              onPressedSave = false;
                            });
                          }
                        }
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      color: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    if (selected != null) {
      this.setState(() {
        selectedImage = selected;
      });
    }
  }

  void showSnackBar(String s) {
    var snackBar = SnackBar(
      content: Text(s),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
