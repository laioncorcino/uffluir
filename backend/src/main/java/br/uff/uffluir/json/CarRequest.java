package br.uff.uffluir.json;

import lombok.Data;

@Data
public class CarRequest {

    private Long driverId;
    private String brand;
    private String model;
    private String plate;
    private Integer year;
    private String color;

}
