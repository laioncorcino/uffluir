package br.uff.uffluir.service;

import br.uff.uffluir.error.exception.BadRequestException;
import br.uff.uffluir.error.exception.NotFoundException;
import br.uff.uffluir.json.PassengerRequest;
import br.uff.uffluir.model.Passenger;
import br.uff.uffluir.repository.PassengerRepository;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Slf4j
@Service
@AllArgsConstructor
public class PassengerService {

    private PassengerRepository passengerRepository;

    public Passenger createPassenger(PassengerRequest passengerRequest) {
        return savePassenger(new Passenger(passengerRequest));
    }

    private Passenger savePassenger(Passenger passenger) {
        try {
            log.info("Saving passenger from name {}", passenger.getName());
            return passengerRepository.save(passenger);
        }
        catch (DataIntegrityViolationException e) {
            log.error("Duplicated key --- {}", e.getMessage());
            throw new BadRequestException("Duplicated key");
        }
        catch (Exception e) {
            log.error("There was error saving passenger");
            throw new BadRequestException("Unknown error");
        }
    }

    public void getById(Long passengerId) {
        log.info("finding passenger of id {}", passengerId);
        Optional<Passenger> passenger = passengerRepository.findById(passengerId);

        passenger.orElseThrow(() -> {
            log.error("passenger of id {} not found", passengerId);
            return new NotFoundException("passenger not found");
        });
    }

    public void deletePassenger(Long passengerId) {
        getById(passengerId);
        log.info("deleting passenger of id {}", passengerId);
        passengerRepository.deleteById(passengerId);
    }

}
