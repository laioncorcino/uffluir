package br.uff.uffluir.repository;

import br.uff.uffluir.model.Ride;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RideRepository extends JpaRepository<Ride, Long> {
}
