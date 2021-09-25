import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Movie {
  String _name;
  String _description;
  String _imgUrl;
  String _from;
  String _to;
  int _noOfSeats;

  Movie();

  Movie.withData(this._name, this._description, this._imgUrl, this._from,
      this._to, this._noOfSeats);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get description => _description;

  int get noOfSeats => _noOfSeats;

  set noOfSeats(int value) {
    _noOfSeats = value;
  }

  String get to => _to;

  set to(String value) {
    _to = value;
  }

  String get from => _from;

  set from(String value) {
    _from = value;
  }

  String get imgUrl => _imgUrl;

  set imgUrl(String value) {
    _imgUrl = value;
  }

  set description(String value) {
    _description = value;
  }

  Map<String, dynamic> toMap(Movie movie) {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['name'] = movie.name;
    map['description'] = movie.description;
    map['img_url'] = movie.imgUrl;
    map['from'] = movie.from;
    map['to'] = movie.to;
    map['noofseats'] = movie.noOfSeats;
    return map;
  }

  Future<bool> addMovie(Movie movie, File selectedImage) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    try {
      StorageReference reference = FirebaseStorage.instance
          .ref()
          .child("movies/" + movie.name + "/" + "movie.png");
      StorageUploadTask uploadTask =
          reference.putData(selectedImage.readAsBytesSync());
      String url = await (await uploadTask.onComplete).ref.getDownloadURL();
      movie.imgUrl = url;
      await fireStore.collection("movies").add(this.toMap(movie));
      return true;
    } catch (error) {
      return false;
    }
  }
}
