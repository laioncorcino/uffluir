package br.uff.uffluir.service;

import br.uff.uffluir.error.exception.BadRequestException;
import br.uff.uffluir.error.exception.NotFoundException;
import br.uff.uffluir.json.CarRequest;
import br.uff.uffluir.model.Car;
import br.uff.uffluir.repository.CarRepository;
import br.uff.uffluir.repository.DriverRepository;
import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.beans.PropertyDescriptor;
import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

@Service
@Slf4j
public class CarService {

    private final CarRepository carRepository;
    private final DriverRepository driverRepository;

    @Autowired
    public CarService(CarRepository carRepository, DriverRepository driverRepository) {
        this.carRepository = carRepository;
        this.driverRepository = driverRepository;
    }

    public Car createCar(CarRequest carRequest) {
        Car car = new Car(carRequest);

        try {
            log.info("Saving car with plate {}", car.getPlate());
            Car carSaved = carRepository.save(car);
            driverRepository.updateCarByDriverId(carSaved.getCarId(), carRequest.getDriverId());
            return carSaved;
        } catch (DataIntegrityViolationException e) {
            log.error("Duplicated key --- {}", e.getMessage());
            throw new BadRequestException("Duplicated key");
        } catch (Exception e) {
            log.error("There was an error saving car");
            throw new BadRequestException("Unknown error");
        }
    }

    @Transactional
    public Car updateCar(Long carId, CarRequest carRequest) {
        Car car = getCarById(carId);

        BeanUtils.copyProperties(carRequest, car, getNullPropertyNames(carRequest));

        try {
            log.info("Updating car with ID {}", carId);
            return carRepository.save(car);
        } catch (Exception e) {
            log.error("Error updating car with ID {}: {}", carId, e.getMessage());
            throw new BadRequestException("Failed to update car");
        }
    }

    private String[] getNullPropertyNames(Object source) {
        BeanWrapper src = new BeanWrapperImpl(source);
        Set<String> emptyNames = new HashSet<>();
        for (PropertyDescriptor pd : src.getPropertyDescriptors()) {
            Object srcValue = src.getPropertyValue(pd.getName());
            if (srcValue == null) {
                emptyNames.add(pd.getName());
            }
        }
        String[] result = new String[emptyNames.size()];
        return emptyNames.toArray(result);
    }

    public Car getCarById(Long carId) {
        log.info("Finding car with id {}", carId);
        Optional<Car> car = carRepository.findById(carId);
        return car.orElseThrow(() -> {
            log.error("Car with id {} not found", carId);
            return new NotFoundException("Car not found");
        });
    }

    public void deleteCar(Long carId) {
        Car car = getCarById(carId);
        log.info("Deleting car with id {}", carId);
        carRepository.delete(car);
    }
}
