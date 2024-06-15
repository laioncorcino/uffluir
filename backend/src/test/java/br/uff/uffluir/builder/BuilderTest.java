package br.uff.uffluir.builder;

import br.uff.uffluir.json.AcceptRequest;
import br.uff.uffluir.json.RideRequest;
import br.uff.uffluir.model.Car;
import br.uff.uffluir.model.Driver;
import br.uff.uffluir.model.Passenger;
import br.uff.uffluir.model.Ride;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.UUID;

public class BuilderTest {

    public static RideRequest buildRideRequest() {
        RideRequest rideRequest = new RideRequest();
        rideRequest.setDriverEmail("driver@id.uff.br");
        rideRequest.setDeparturePlace("Insituto Computação");
        rideRequest.setArrivalPlace("Gragoatá");
        rideRequest.setDepartureTime("2024-06-15 10:00:00");
        rideRequest.setArrivalTime("2024-06-15 11:00:00");
        rideRequest.setSize(4);
        return rideRequest;
    }

    public static AcceptRequest buildAcceptRequest() {
        AcceptRequest acceptRequest = new AcceptRequest();
        acceptRequest.setPassengerEmail("passenger@id.uff.br");
        return acceptRequest;
    }

    public static Ride buildRide() {
        Ride ride = new Ride();
        ride.setRideId(1L);
        ride.setKey(UUID.randomUUID().toString());
        ride.setDeparturePlace("Insituto Computação");
        ride.setArrivalPlace("Gragoatá");
        ride.setDepartureTime(LocalDateTime.parse("2024-06-15T10:00:00"));
        ride.setArrivalTime(LocalDateTime.parse("2024-06-15T11:00:00"));
        ride.setStatus("OPEN");
        ride.setSize(4);
        ride.setDriver(buildDriver());
        ride.setPassengers(new ArrayList<>());
        return ride;
    }

    public static Ride buildRide(RideRequest rideRequest, Driver driver) {
        return new Ride(rideRequest, driver);
    }

    public static Driver buildDriver() {
        Driver driver = new Driver();
        driver.setDriverId(1L);
        driver.setName("Driver");
        driver.setEmail("driver@id.uff.br");
        driver.setPass("12345");
        driver.setCnh("ABC-123");
        driver.setCar(new Car());
        return driver;
    }

    public static Passenger buildPassenger() {
        Passenger passenger = new Passenger();
        passenger.setPassengerId(1L);
        passenger.setName("Passenger");
        passenger.setEmail("passenger@id.uff.br");
        passenger.setPass("12345");
        return passenger;
    }

}
