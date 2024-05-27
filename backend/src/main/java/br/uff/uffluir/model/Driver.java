package br.uff.uffluir.model;

import br.uff.uffluir.json.DriverRequest;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@NoArgsConstructor
public class Driver {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long driverId;
    private String name;

    @Column(unique = true)
    private String email;
    private String pass;

    @Column(unique = true)
    private String cnh;

    @OneToOne
    @JoinColumn(name = "car_id")
    private Car car;

    @OneToMany(mappedBy = "driver")
    private List<Ride> offerRides = new ArrayList<>();

    public Driver(DriverRequest driverRequest) {
        this.name = driverRequest.getName();
        this.email = driverRequest.getEmail();
        this.pass = driverRequest.getPass();
        this.cnh = driverRequest.getCnh();
    }

}
