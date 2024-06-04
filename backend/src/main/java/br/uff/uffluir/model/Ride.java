package br.uff.uffluir.model;

import br.uff.uffluir.json.RideRequest;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Data
@Entity
@NoArgsConstructor
public class Ride {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long rideId;

    @Column(unique = true)
    private String key;

    @Column(name = "departure_place")
    private String departurePlace;

    @Column(name = "arrival_place")
    private String arrivalPlace;

    @Column(name = "departure_time")
    private LocalDateTime departureTime;

    @Column(name = "arrival_time")
    private LocalDateTime arrivalTime;

    @ManyToOne
    @JoinColumn(name = "driver_id", nullable = false)
    private Driver driver;

    @ManyToMany
    @JoinTable(
        name = "ride_passenger",
        joinColumns = @JoinColumn(name = "ride_id"),
        inverseJoinColumns = @JoinColumn(name = "passenger_id")
    )
    private List<Passenger> passengers = new ArrayList<>();

    public Ride(RideRequest rideRequest, Driver driver) {
        this.key = UUID.randomUUID().toString();
        this.departurePlace = rideRequest.getDeparturePlace();
        this.arrivalPlace = rideRequest.getArrivalPlace();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        this.departureTime = LocalDateTime.parse(rideRequest.getDepartureTime(), formatter);
        this.arrivalTime = LocalDateTime.parse(rideRequest.getArrivalTime(), formatter);
        this.driver = driver;
    }

}
