package br.uff.uffluir.controller;

import br.uff.uffluir.json.CarRequest;
import br.uff.uffluir.json.CarResponse;
import br.uff.uffluir.model.Car;
import br.uff.uffluir.service.CarService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/cars")
public class CarController {

    private final CarService carService;

    @Autowired
    public CarController(CarService carService) {
        this.carService = carService;
    }

    @PostMapping()
    public ResponseEntity<CarResponse> create(@RequestBody @Valid CarRequest carRequest) {
        Car car = carService.createCar(carRequest);
        CarResponse carResponse = new CarResponse(car);
        return ResponseEntity.ok(carResponse);
    }

    @DeleteMapping("/{carId}")
    public ResponseEntity<Void> delete(@PathVariable Long carId) {
        carService.deleteCar(carId);
        return ResponseEntity.noContent().build();
    }

    @PutMapping("/{carId}")
    public ResponseEntity<CarResponse> update(@PathVariable Long carId, @RequestBody @Valid CarRequest carRequest) {
        Car updatedCar = carService.updateCar(carId, carRequest);
        CarResponse carResponse = new CarResponse(updatedCar);
        return ResponseEntity.ok(carResponse);
    }
}
