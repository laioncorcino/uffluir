package br.uff.uffluir.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
public class Car {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long carId;
    private String brand;
    private String model;
    private String plate;
    private Integer year;
    private String color;

}
