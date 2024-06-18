package br.uff.uffluir.json;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RideRequest {

    private String driverEmail;
    private String departurePlace;
    private String arrivalPlace;
    private String departureTime;
    private String arrivalTime;
    private Integer size;

    public RideRequest(String mail, String departurePlace, String arrivalPlace, String departureTime, String arrivalTime, int size) {
        this.driverEmail = mail;
        this.departurePlace = departurePlace;
        this.arrivalPlace = arrivalPlace;
        this.departureTime = departureTime;
        this.arrivalTime = arrivalTime;
        this.size = size;
    }
}
