package br.uff.uffluir.service;

import br.uff.uffluir.error.exception.BadRequestException;
import br.uff.uffluir.error.exception.NotFoundException;
import br.uff.uffluir.json.DriverRequest;
import br.uff.uffluir.model.Driver;
import br.uff.uffluir.repository.DriverRepository;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@AllArgsConstructor
@Slf4j
public class DriverService {

    private DriverRepository driverRepository;

    public Driver createDriver(DriverRequest driverRequest) {
        return saveDriver(new Driver(driverRequest));
    }

    private Driver saveDriver(Driver driver) {
        try {
            log.info("Saving driver from cnh {}", driver.getCnh());
            return driverRepository.save(driver);
        }
        catch (DataIntegrityViolationException e) {
            log.error("Duplicated key --- {}", e.getMessage());
            throw new BadRequestException("Duplicated key");
        }
        catch (Exception e) {
            log.error("There was error saving driver");
            throw new BadRequestException("Unknown error");
        }
    }

    private void getById(Long driverId) {
        log.info("finding driver of id {}", driverId);
        Optional<Driver> driver = driverRepository.findById(driverId);

        driver.orElseThrow(() -> {
            log.error("driver of id {} not found", driverId);
            return new NotFoundException("driver not found");
        });
    }

    public void deleteDriver(Long driverId) {
        getById(driverId);
        log.info("deleting driver of id {}", driverId);
        driverRepository.deleteById(driverId);
    }

}
