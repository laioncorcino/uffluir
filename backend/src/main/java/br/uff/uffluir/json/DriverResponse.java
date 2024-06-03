package br.uff.uffluir.json;

import br.uff.uffluir.model.Driver;
import lombok.Data;

@Data
public class DriverResponse {

    private Long driverId;
    private String name;
    private String email;
    private String cnh;

    public DriverResponse(Driver driver) {
        this.driverId = driver.getDriverId();
        this.name = driver.getName();
        this.email = driver.getEmail();
        this.cnh = driver.getCnh();
    }

}
