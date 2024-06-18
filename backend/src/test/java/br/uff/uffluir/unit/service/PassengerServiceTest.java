package br.uff.uffluir.unit.service;

import br.uff.uffluir.error.exception.BadRequestException;
import br.uff.uffluir.error.exception.NotFoundException;
import br.uff.uffluir.json.PassengerRequest;
import br.uff.uffluir.model.Passenger;
import br.uff.uffluir.repository.PassengerRepository;
import br.uff.uffluir.service.PassengerService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.AssertionsForClassTypes.catchThrowable;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;

@ExtendWith(SpringExtension.class)
@ActiveProfiles("test")
public class PassengerServiceTest {

    @InjectMocks
    private PassengerService passengerService;

    @Mock
    private PassengerRepository passengerRepository;

    @Test
    @DisplayName("deve_criar_passageiro_com_sucesso")
    public void createPassenger() {
        PassengerRequest passengerRequest = buildPassengerRequest();
        Passenger passenger = buildPassenger(passengerRequest);

        Mockito.when(passengerRepository.save(any(Passenger.class))).thenReturn(passenger);

        Passenger createdPassenger = passengerService.createPassenger(passengerRequest);

        assertThat(createdPassenger).isNotNull();
        assertThat(createdPassenger.getName()).isEqualTo(passengerRequest.getName());
    }

    @Test
    @DisplayName("deve_tratar_exception_de_integridade_de_dados_ao_criar_passageiro")
    public void createPassengerDataIntegrityViolation() {
        PassengerRequest passengerRequest = buildPassengerRequest();

        Mockito.when(passengerRepository.save(any(Passenger.class))).thenThrow(new DataIntegrityViolationException("Duplicated key"));

        Throwable exception = catchThrowable(() -> passengerService.createPassenger(passengerRequest));

        assertThat(exception)
                .isInstanceOf(BadRequestException.class)
                .hasMessage("Duplicated key");
    }

    @Test
    @DisplayName("deve_tratar_exception_desconhecida_ao_criar_passageiro")
    public void createPassengerUnknownError() {
        PassengerRequest passengerRequest = buildPassengerRequest();

        Mockito.when(passengerRepository.save(any(Passenger.class))).thenThrow(new RuntimeException("Unknown error"));

        Throwable exception = catchThrowable(() -> passengerService.createPassenger(passengerRequest));

        assertThat(exception)
                .isInstanceOf(BadRequestException.class)
                .hasMessage("Unknown error");
    }

    @Test
    @DisplayName("deve_tratar_exception_ao_nao_encontrar_passageiro_por_id")
    public void getPassengerByIdNotFound() {
        Mockito.when(passengerRepository.findById(eq(1L))).thenReturn(Optional.empty());

        Throwable exception = catchThrowable(() -> passengerService.getById(1L));

        assertThat(exception)
                .isInstanceOf(NotFoundException.class)
                .hasMessage("passenger not found");
    }

    @Test
    @DisplayName("deve_deletar_passageiro_com_sucesso")
    public void deletePassenger() {
        Passenger passenger = buildPassenger();

        Mockito.when(passengerRepository.findById(eq(1L))).thenReturn(Optional.of(passenger));
        Mockito.doNothing().when(passengerRepository).deleteById(eq(1L));

        passengerService.deletePassenger(1L);

        Mockito.verify(passengerRepository, Mockito.times(1)).deleteById(1L);
    }

    @Test
    @DisplayName("deve_tratar_exception_ao_nao_encontrar_passageiro_para_deletar")
    public void deletePassengerNotFound() {
        Mockito.when(passengerRepository.findById(eq(1L))).thenReturn(Optional.empty());

        Throwable exception = catchThrowable(() -> passengerService.deletePassenger(1L));

        assertThat(exception)
                .isInstanceOf(NotFoundException.class)
                .hasMessage("passenger not found");
    }

    private PassengerRequest buildPassengerRequest() {
        PassengerRequest passengerRequest = new PassengerRequest();
        passengerRequest.setName("John Doe");
        passengerRequest.setEmail("john.doe@example.com");
        passengerRequest.setPass("123456789");
        return passengerRequest;
    }

    private Passenger buildPassenger() {
        Passenger passenger = new Passenger();
        passenger.setPassengerId(1L);
        passenger.setName("John Doe");
        passenger.setEmail("john.doe@example.com");
        passenger.setPass("123456789");
        return passenger;
    }

    private Passenger buildPassenger(PassengerRequest passengerRequest) {
        return new Passenger(passengerRequest);
    }

}
