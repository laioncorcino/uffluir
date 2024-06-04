package br.uff.uffluir.service;

import br.uff.uffluir.error.exception.BadRequestException;
import br.uff.uffluir.error.exception.NotFoundException;
import br.uff.uffluir.json.AcceptRequest;
import br.uff.uffluir.json.RideRequest;
import br.uff.uffluir.model.Driver;
import br.uff.uffluir.model.Passenger;
import br.uff.uffluir.model.Ride;
import br.uff.uffluir.repository.DriverRepository;
import br.uff.uffluir.repository.PassengerRepository;
import br.uff.uffluir.repository.RideRepository;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Optional;

@Service
@AllArgsConstructor
@Slf4j
public class RideService {

    private RideRepository rideRepository;
    private DriverRepository driverRepository;
    private PassengerRepository passengerRepository;

    public Ride createRide(RideRequest rideRequest) {
        Driver driver = driverRepository.findByEmail(rideRequest.getDriverEmail());
        if (driver == null) {
            throw new NotFoundException("Driver not found");
        }

        return saveRide(new Ride(rideRequest, driver));
    }

    private Ride saveRide(Ride ride) {
        try {
            log.info("Saving ride from driver {}", ride.getDriver().getName());
            return rideRepository.save(ride);
        }
        catch (Exception e) {
            log.error("There was error saving ride");
            throw new BadRequestException("Unknown error");
        }
    }

    @Transactional(readOnly = true)
    public Page<Ride> getAllRides(Pageable pageable) {
        return rideRepository.findAll(pageable);
    }

    public Ride acceptRide(AcceptRequest acceptRequest, Long rideId) {
        Passenger passenger = passengerRepository.findByEmail(acceptRequest.getPassengerEmail());
        Ride ride = getById(rideId);

        ArrayList<Passenger> passengers = new ArrayList<>();
        passengers.add(passenger);

        ride.setPassengers(passengers);
        return rideRepository.save(ride);
    }

    private Ride getById(Long rideId) {
        log.info("finding ride of id {}", rideId);
        Optional<Ride> ride = rideRepository.findById(rideId);

        return ride.orElseThrow(() -> {
            log.error("ride of id {} not found", rideId);
            return new NotFoundException("ride not found");
        });
    }

}
