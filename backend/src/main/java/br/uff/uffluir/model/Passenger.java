package br.uff.uffluir.model;

import jakarta.persistence.*;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
@Entity
public class Passenger {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long passengerId;
    private String name;

    @Column(unique = true)
    private String email;
    private String pass;

    @ManyToMany(mappedBy = "passengers")
    private List<Ride> receiverRides = new ArrayList<>();

}
