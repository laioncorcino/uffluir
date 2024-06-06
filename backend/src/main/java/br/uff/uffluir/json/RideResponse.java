package br.uff.uffluir.json;

import br.uff.uffluir.model.Ride;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class RideResponse {

    private Long rideId;
    private String key;
    private String departurePlace;
    private String arrivalPlace;
    private LocalDateTime departureTime;
    private LocalDateTime arrivalTime;
    private String status;
    private Integer size;
    private DriverResponse driver;
    private List<PassengerResponse> passengers;

    public RideResponse(Ride ride) {
        this.rideId = ride.getRideId();
        this.key = ride.getKey();
        this.departurePlace = ride.getDeparturePlace();
        this.arrivalPlace = ride.getArrivalPlace();
        this.departureTime = ride.getDepartureTime();
        this.arrivalTime = ride.getArrivalTime();
        this.driver = new DriverResponse(ride.getDriver());
        this.status = ride.getStatus();
        this.size = ride.getSize();
        this.passengers = ride.getPassengers().stream().map(PassengerResponse::new).toList();
    }

}
