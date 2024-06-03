package br.uff.uffluir.json;

import br.uff.uffluir.model.Passenger;
import lombok.Data;

@Data
public class PassengerResponse {

    private Long passengerId;
    private String name;
    private String email;

    public PassengerResponse(Passenger passenger) {
        this.passengerId = passenger.getPassengerId();
        this.name = passenger.getName();
        this.email = passenger.getEmail();
    }

}
