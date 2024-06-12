Class User{

    final String userId;
    final String? cnh;
    final String email;
    final String name;
    final String pass;
    final Integer score;

    User({
        this.userId,
        this.cnh,
        this.email,
        this.name,
        this.pass,
        this.score,
    });

}


// JAVA

// Driver

// package br.uff.uffluir.model;

// import br.uff.uffluir.json.DriverRequest;
// import jakarta.persistence.*;
// import lombok.Data;
// import lombok.NoArgsConstructor;

// import java.util.ArrayList;
// import java.util.List;

// @Data
// @Entity
// @NoArgsConstructor
// public class Driver {

//     @Id
//     @GeneratedValue(strategy = GenerationType.IDENTITY)
//     private Long driverId;
//     private String name;

//     @Column(unique = true)
//     private String email;
//     private String pass;

//     @Column(unique = true)
//     private String cnh;

//     @OneToOne
//     @JoinColumn(name = "car_id")
//     private Car car;

//     @OneToMany(mappedBy = "driver")
//     private List<Ride> offerRides = new ArrayList<>();

//     public Driver(DriverRequest driverRequest) {
//         this.name = driverRequest.getName();
//         this.email = driverRequest.getEmail();
//         this.pass = driverRequest.getPass();
//         this.cnh = driverRequest.getCnh();
//     }

// }




// Passenger

// package br.uff.uffluir.model;

// import br.uff.uffluir.json.PassengerRequest;
// import jakarta.persistence.*;
// import lombok.Data;

// import java.util.ArrayList;
// import java.util.List;

// @Data
// @Entity
// public class Passenger {

//     @Id
//     @GeneratedValue(strategy = GenerationType.IDENTITY)
//     private Long passengerId;
//     private String name;

//     @Column(unique = true)
//     private String email;
//     private String pass;

//     @ManyToMany(mappedBy = "passengers")
//     private List<Ride> receiverRides = new ArrayList<>();

//     public Passenger(PassengerRequest passengerRequest) {
//         this.name = passengerRequest.getName();
//         this.email = passengerRequest.getEmail();
//         this.pass = passengerRequest.getPass();
//     }
// }