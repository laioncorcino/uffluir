package br.uff.uffluir.repository;

import br.uff.uffluir.model.Driver;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface DriverRepository extends JpaRepository<Driver, Long> {

    @Modifying
    @Query("UPDATE Driver d SET d.car.carId = :carId WHERE d.driverId = :driverId")
    @Transactional
    void updateCarByDriverId(@Param("carId") Long carId, @Param("driverId") Long driverId);

}
