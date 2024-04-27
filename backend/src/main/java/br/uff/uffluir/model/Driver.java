package br.uff.uffluir.model;

import jakarta.persistence.*;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
@Entity
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
    @JoinColumn(name = "car_id", nullable = false)
    private Car car;

    @OneToMany(mappedBy = "driver")
    private List<Ride> offerRides = new ArrayList<>();

}
