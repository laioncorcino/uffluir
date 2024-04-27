package br.uff.uffluir.model;

import br.uff.uffluir.json.CarRequest;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@NoArgsConstructor
public class Car {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long carId;
    private String brand;
    private String model;
    private String plate;
    private Integer year;
    private String color;

    public Car(CarRequest carRequest) {
        this.brand = carRequest.getBrand();
        this.model = carRequest.getModel();
        this.plate = carRequest.getPlate();
        this.year = carRequest.getYear();
        this.color = carRequest.getColor();
    }

}
