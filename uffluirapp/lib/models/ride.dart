import 'package:cloud_firestore/cloud_firestore.dart';

class RideModel {
  String id;
  String name;
  String arrival_date;
  String arrival_place;
  String departure_date;
  String departure_place;
  String departure_time;
  String return_time;
  String scheduled_stop;
  int size;
  String status;
  String rider_id;

  RideModel({
    required this.id,
    required this.name,
    required this.arrival_date,
    required this.arrival_place,
    required this.departure_date,
    required this.departure_place,
    required this.departure_time,
    required this.return_time,
    required this.scheduled_stop,
    required this.size,
    required this.status,
    required this.rider_id,
  });

  factory RideModel.fromFirestore(String id, Map<String, dynamic> data) {
    return RideModel(
        id: id,
        name: data['name'] ?? "",
        arrival_date: data['arrival_date'] ?? "",
        departure_date: data['departure_date'] ?? "",
        departure_place: data[' departure_place'] ?? "",
        arrival_place: data['arrival_place'] ?? "",
        departure_time: data['departure_time'] ?? 0,
        return_time: data['return_time'] ?? "",
        scheduled_stop: data['scheduled_stop'] ?? "",
        size: data['size'] ?? 0,
        status: data['status'] ?? "",
        rider_id: data['rider_id'] ?? "");
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'arrival_date': arrival_date,
      'arrival_place': arrival_place,
      'departure_date': departure_date,
      'departure_place': departure_place,
      'departure_time': departure_time,
      'return_time': return_time,
      'scheduled_stop': scheduled_stop,
      'size': size,
      'status': status,
      'rider_id': rider_id
    };
  }
}

class RideService {
  List<RideModel> _instanciaListaRideModel(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return RideModel(
          id: doc.id,
          name: doc['name'] ?? "",
          arrival_date: doc['arrival_date'] ?? "",
          arrival_place: doc['arrival_place'] ?? "",
          departure_date: doc['departure_date'] ?? "",
          departure_place: doc['departure_place'] ?? "",
          departure_time: doc['departure_time'] ?? 0,
          return_time: doc['return_time'] ?? "",
          scheduled_stop: doc['scheduled_stop'] ?? "",
          size: doc['size'] ?? 0,
          status: doc['status'] ?? "",
          rider_id: doc['rider_id'] ?? "");
    }).toList();
  }

  Future<List<RideModel>> getRides() async {
    List<RideModel> listaCaronas = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('ride').get();

    listaCaronas.addAll(_instanciaListaRideModel(querySnapshot));

    return listaCaronas;
  }
}
