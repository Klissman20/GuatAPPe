import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:guatappe/domain/datasources/markers_datasource.dart';
import 'package:guatappe/domain/entities/marker_entity.dart';
import 'package:guatappe/infrastructure/mappers/marker_mapper.dart';
import 'package:guatappe/infrastructure/models/marker_model.dart';

class MarkerDataSourceImpl extends MarkersDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  MarkerDataSourceImpl(
      {required this.firebaseFirestore, required this.firebaseStorage});

  @override
  Future<List<MarkerEntity>> getMarkersList() async {
    try {
      List<MarkerModel> markersModelList = [];

      final querySnapshot = await firebaseFirestore.collection('places').get();

      for (var docSnapshot in querySnapshot.docs) {
        markersModelList.add(MarkerModel.fromJson(docSnapshot.data()));
      }

      return markersModelList
          .map((marker) => MarkerMapper.markerFirebaseToEntity(marker))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  @override
  Future<MarkerEntity> getMarkerImages(MarkerEntity marker) async {
    try {
      final storageRef = firebaseStorage.ref();
      final imagesRef = storageRef.child('${marker.id}/01.png');
      final imageData = await imagesRef.getDownloadURL();
      var url = Uri.parse(imageData);
      marker.imageList!.add(Image.network(url.toString()));
      return marker;
    } catch (e) {
      print(e);
      return marker;
    }
  }
}
