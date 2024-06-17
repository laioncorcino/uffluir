import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uffluir/models/ride.dart';
import 'package:uffluir/models/user.dart';

class Ride_user {
  final String ride_userId;
  final String rideId;
  final String userId;

  Ride_user({
    required this.ride_userId,
    required this.rideId,
    required this.userId,
  });
}

List<Ride_user> _instanciaListaRideUser(QuerySnapshot snapshot) {
  return snapshot.docs.map((rideUser) {
    return Ride_user(
        ride_userId: rideUser.id,
        rideId: rideUser['ride_id'] ?? "",
        userId: rideUser['user_id'] ?? "");
  }).toList();
}

Stream<List<Ride_user>> getRideUserList(RideModel? carona) {
  return FirebaseFirestore.instance
      .collection("ride_user")
      .where('ride_id', isEqualTo: carona?.id)
      .snapshots()
      .map(_instanciaListaRideUser);
}

Future<List<String>> getRideUsers(RideModel? carona) async {
  List<String> usuariosCarona = [];
  final rideUsers = getRideUserList(carona);
  final usersIterator = StreamIterator(rideUsers);
  await for (final usuario in rideUsers) {
    for (int i = 0; i < usuario.length; i++) {
      print("usuario[i] = ${usuario[i].userId}");
      usuariosCarona.add(usuario[i].userId);
    }
  }
  print("usuariosCarona = ${usuariosCarona}");
  return usuariosCarona;
}

Future<int> adicionarNaCarona(RideModel? ride, UserModel user) async {
  if (ride!.size == 0) {
    return 2;
  }
  ;
  try {
    QuerySnapshot userQuery = await FirebaseFirestore.instance
        .collection('ride_user')
        .where('ride_id', isEqualTo: ride?.id)
        .where('user_id', isEqualTo: user.id)
        .get();

    if (userQuery.docs.isNotEmpty) {
      return 1;
    } else {
      // Adicionar novo usuário ao Firestore
      String status = ride!.status;
      await FirebaseFirestore.instance
          .collection('ride_user')
          .add({'user_id': user.id, 'ride_id': ride?.id});

      if (ride!.size - 1 == 0) {
        status = "Lotada";
      }
      await FirebaseFirestore.instance.collection('ride').doc(ride!.id).set({
        'name': ride.name,
        'arrival_date': ride.arrival_date,
        'arrival_place': ride.arrival_place,
        'return_time': ride.return_time,
        'departure_date': ride.departure_date,
        'departure_place': ride.departure_place,
        'departure_time': ride.departure_time,
        'scheduled_stop': ride.scheduled_stop,
        'size': ride.size - 1,
        'status': status,
        'rider_id': ride.rider_id,
        'size': ride.size - 1
      });
    }
  } catch (e) {
    print("Error fetching or adding user to Firestore: $e");
  }
  return 0;
}
