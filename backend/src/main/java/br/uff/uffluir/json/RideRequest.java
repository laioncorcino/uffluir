package br.uff.uffluir.json;

import lombok.Data;

@Data
public class RideRequest {

    private String driverEmail;
    private String departurePlace;
    private String arrivalPlace;
    private String departureTime;
    private String arrivalTime;

}
