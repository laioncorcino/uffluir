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
    return snapshot.docs.map((ride) {
      return RideModel(
          id: ride.id,
          name: ride['name'] ?? "",
          arrival_date: ride['arrival_date'] ?? "",
          arrival_place: ride['arrival_place'] ?? "",
          departure_date: ride['departure_date'] ?? "",
          departure_place: ride['departure_place'] ?? "",
          departure_time: ride['departure_time'] ?? 0,
          return_time: ride['return_time'] ?? "",
          scheduled_stop: ride['scheduled_stop'] ?? "",
          size: ride['size'] ?? 0,
          status: ride['status'] ?? "",
          rider_id: ride['rider_id'] ?? "");
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

RideModel RideModelFirebase(DocumentSnapshot ride) {
  return RideModel(
    id: ride.id,
    name: ride.data.toString().contains('name') ? ride.get('name') : '',
    arrival_date: ride.data.toString().contains('arrival_date')
        ? ride.get('arrival_date')
        : '',
    arrival_place: ride.data.toString().contains('arrival_place')
        ? ride.get('arrival_place')
        : '',
    departure_date: ride.data.toString().contains('departure_date')
        ? ride.get('departure_date')
        : '',
    departure_place: ride.data.toString().contains('departure_place')
        ? ride.get('departure_place')
        : '',
    departure_time: ride.data.toString().contains('departure_time')
        ? ride.get('departure_time')
        : 0,
    return_time: ride.data.toString().contains('return_time')
        ? ride.get('return_time')
        : '',
    scheduled_stop: ride.data.toString().contains('scheduled_stop')
        ? ride.get('scheduled_stop')
        : '',
    size: ride.data.toString().contains('size') ? ride.get('size') : 0,
    status: ride.data.toString().contains('status') ? ride.get('status') : '',
    rider_id:
        ride.data.toString().contains('rider_id') ? ride.get('rider_id') : '',
  );
}

Future<RideModel?> obtemInfoCarona(String? uid) async {
  DocumentSnapshot rideride =
      await FirebaseFirestore.instance.collection('ride').doc(uid).get();

  RideModel ride = RideModelFirebase(rideride);
  return ride;
}
