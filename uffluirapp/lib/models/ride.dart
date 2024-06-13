class Ride{

    final String rideId;
    final DateTime arrival_date;
    final String arrival_place;
    final TimeOfDay arrival_time;
    final DateTime departure_date;
    final String departure_place;
    final TimeOfDay departure_time;
    final String scheduled_stop;
    final Integer size;
    final String status;
    final String user_id;

    Ride({
        this.rideId,
        this.arrival_date,
        this.arrival_place,
        this.arrival_time,
        this.departure_date,
        this.departure_place,
        this.departure_time,
        this.scheduled_stop,
        this.size,
        this.status,
        this.user_id,
    });

}

// JAVA
// package br.uff.uffluir.model;
// import jakarta.persistence.*;
// import lombok.Data;
// import java.time.LocalDateTime;
// import java.util.ArrayList;
// import java.util.List;
// @Data
// @Entity
// public class Ride {
//     @Id
//     @GeneratedValue(strategy = GenerationType.IDENTITY)
//     private Long rideId;
//     @Column(unique = true)
//     private String key;
//     @Column(name = "departure_place")
//     private String departurePlace;
//     @Column(name = "arrival_place")
//     private String arrivalPlace;
//     @Column(name = "departure_time")
//     private LocalDateTime departureTime;
//     @Column(name = "arrival_time")
//     private LocalDateTime arrivalTime;
//     @ManyToOne
//     @JoinColumn(name = "driver_id", nullable = false)
//     private Driver driver;
//     @ManyToMany
//     @JoinTable(
//         name = "ride_passenger",
//         joinColumns = @JoinColumn(name = "ride_id"),
//         inverseJoinColumns = @JoinColumn(name = "passenger_id")
//     )
//     private List<Passenger> passengers = new ArrayList<>();
// }