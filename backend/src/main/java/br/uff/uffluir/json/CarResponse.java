package br.uff.uffluir.json;

import br.uff.uffluir.model.Car;
import lombok.Data;

@Data
public class CarResponse {

    private Long carId;
    private String brand;
    private String model;
    private String plate;
    private Integer year;
    private String color;

    public CarResponse(Car car) {
        this.carId = car.getCarId();
        this.brand = car.getBrand();
        this.model = car.getModel();
        this.plate = car.getPlate();
        this.year = car.getYear();
        this.color = car.getColor();
    }

}
