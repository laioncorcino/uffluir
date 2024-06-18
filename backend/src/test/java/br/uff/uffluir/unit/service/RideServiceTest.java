package br.uff.uffluir.unit.service;

import br.uff.uffluir.error.exception.NotFoundException;
import br.uff.uffluir.json.AcceptRequest;
import br.uff.uffluir.json.RideRequest;
import br.uff.uffluir.model.Driver;
import br.uff.uffluir.model.Passenger;
import br.uff.uffluir.model.Ride;
import br.uff.uffluir.repository.DriverRepository;
import br.uff.uffluir.repository.PassengerRepository;
import br.uff.uffluir.repository.RideRepository;
import br.uff.uffluir.service.RideService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.Optional;

import static br.uff.uffluir.builder.BuilderTest.*;
import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.AssertionsForClassTypes.catchThrowable;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;

@ExtendWith(SpringExtension.class)
@ActiveProfiles("test")
public class RideServiceTest {

    @InjectMocks
    private RideService rideService;

    @Mock
    private RideRepository rideRepository;

    @Mock
    private DriverRepository driverRepository;

    @Mock
    private PassengerRepository passengerRepository;

    @Test
    @DisplayName("deve_criar_corrida_com_sucesso")
    public void createRide() {
        RideRequest rideRequest = buildRideRequest();
        Driver driver = buildDriver();

        Mockito.when(driverRepository.findByEmail(eq("driver@id.uff.br"))).thenReturn(driver);
        Mockito.when(rideRepository.save(any(Ride.class))).thenReturn(buildRide(rideRequest, driver));

        Ride ride = rideService.createRide(rideRequest);

        assertThat(ride).isNotNull();
        assertThat(ride.getDriver().getEmail()).isEqualTo("driver@id.uff.br");
    }

    @Test
    @DisplayName("deve_tratar_exception_ao_nao_encontrar_motorista")
    public void createRideDriverNotFound() {
        RideRequest rideRequest = buildRideRequest();

        Mockito.when(driverRepository.findByEmail("driver@example.com")).thenReturn(null);

        Throwable exception = catchThrowable(() -> rideService.createRide(rideRequest));

        assertThat(exception)
                .isInstanceOf(NotFoundException.class)
                .hasMessage("Driver not found");
    }

    @Test
    @DisplayName("deve_aceitar_corrida_com_sucesso")
    public void acceptRide() {
        AcceptRequest acceptRequest = buildAcceptRequest();
        Passenger passenger = buildPassenger();
        Ride ride = buildRide();

        Mockito.when(passengerRepository.findByEmail(eq("passenger@id.uff.br"))).thenReturn(passenger);
        Mockito.when(rideRepository.findById(eq(1L))).thenReturn(Optional.of(ride));
        Mockito.when(rideRepository.save(any(Ride.class))).thenReturn(ride);

        Ride acceptedRide = rideService.acceptRide(acceptRequest, 1L);

        assertThat(acceptedRide).isNotNull();
        assertThat(acceptedRide.getPassengers()).contains(passenger);
    }

    @Test
    @DisplayName("deve_tratar_exception_ao_nao_encontrar_passageiro")
    public void acceptRidePassengerNotFound() {
        AcceptRequest acceptRequest = buildAcceptRequest();

        Mockito.when(passengerRepository.findByEmail("passenger@example.com")).thenReturn(null);

        Throwable exception = catchThrowable(() -> rideService.acceptRide(acceptRequest, 1L));

        assertThat(exception)
                .isInstanceOf(NotFoundException.class)
                .hasMessage("Passenger not found");
    }

    @Test
    @DisplayName("deve_concluir_corrida_com_sucesso")
    public void concludeRide() {
        Ride ride = buildRide();
        Driver driver = buildDriver();

        Mockito.when(rideRepository.findById(eq(1L))).thenReturn(Optional.of(ride));
        Mockito.when(driverRepository.findByEmail(eq("driver@id.uff.br"))).thenReturn(driver);

        rideService.concludedRide(1L, "driver@id.uff.br");

        assertThat(ride.getStatus()).isEqualTo("CONCLUDED");
    }

    @Test
    @DisplayName("nao_deve_concluir_corrida_com_motorista_incorreto")
    public void concludeRideDriverNotMatch() {
        Ride ride = buildRide();

        Mockito.when(rideRepository.findById(eq(1L))).thenReturn(Optional.of(ride));
        Mockito.when(driverRepository.findByEmail(eq("wrong@example.com"))).thenReturn(null);

        Throwable exception = catchThrowable(() -> rideService.concludedRide(1L, "wrong@example.com"));

        assertThat(exception)
                .isInstanceOf(NotFoundException.class)
                .hasMessage("Driver not found");
    }

    @Test
    @DisplayName("deve_deletar_corrida_com_sucesso")
    public void deleteRide() {
        Ride ride = buildRide();
        Driver driver = buildDriver();

        Mockito.when(rideRepository.findById(eq(1L))).thenReturn(Optional.of(ride));
        Mockito.when(driverRepository.findByEmail(eq("driver@example.com"))).thenReturn(driver);
        Mockito.doNothing().when(rideRepository).delete(any(Ride.class));

        rideService.deleteRide(1L, "driver@example.com");

        Mockito.verify(rideRepository, Mockito.times(1)).delete(ride);
    }

    @Test
    @DisplayName("nao_deve_deletar_corrida_com_motorista_incorreto")
    public void deleteRideDriverNotMatch() {
        Ride ride = buildRide();

        Mockito.when(rideRepository.findById(eq(1L))).thenReturn(Optional.of(ride));
        Mockito.when(driverRepository.findByEmail(eq("wrong@example.com"))).thenReturn(null);

        Throwable exception = catchThrowable(() -> rideService.deleteRide(1L, "wrong@example.com"));

        assertThat(exception)
                .isInstanceOf(NotFoundException.class)
                .hasMessage("Driver not found");
    }

}


