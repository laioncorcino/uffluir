package br.uff.uffluir.unit.service;

import br.uff.uffluir.error.exception.BadRequestException;
import br.uff.uffluir.error.exception.NotFoundException;
import br.uff.uffluir.json.DriverRequest;
import br.uff.uffluir.model.Car;
import br.uff.uffluir.model.Driver;
import br.uff.uffluir.repository.DriverRepository;
import br.uff.uffluir.service.DriverService;
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
public class DriverServiceTest {

    @InjectMocks
    private DriverService driverService;

    @Mock
    private DriverRepository driverRepository;

    @Test
    @DisplayName("deve_criar_motorista_com_sucesso")
    public void createDriver() {
        DriverRequest driverRequest = buildDriverRequest();
        Driver driver = buildDriver(driverRequest);

        Mockito.when(driverRepository.save(any(Driver.class))).thenReturn(driver);

        Driver createdDriver = driverService.createDriver(driverRequest);

        assertThat(createdDriver).isNotNull();
        assertThat(createdDriver.getEmail()).isEqualTo(driverRequest.getEmail());
    }

    @Test
    @DisplayName("deve_tratar_exception_de_integridade_de_dados_ao_criar_motorista")
    public void createDriverDataIntegrityViolation() {
        DriverRequest driverRequest = buildDriverRequest();

        Mockito.when(driverRepository.save(any(Driver.class))).thenThrow(new DataIntegrityViolationException("Duplicated key"));

        Throwable exception = catchThrowable(() -> driverService.createDriver(driverRequest));

        assertThat(exception)
                .isInstanceOf(BadRequestException.class)
                .hasMessage("Duplicated key");
    }

    @Test
    @DisplayName("deve_tratar_exception_desconhecida_ao_criar_motorista")
    public void createDriverUnknownError() {
        DriverRequest driverRequest = buildDriverRequest();

        Mockito.when(driverRepository.save(any(Driver.class))).thenThrow(new RuntimeException("Unknown error"));

        Throwable exception = catchThrowable(() -> driverService.createDriver(driverRequest));

        assertThat(exception)
                .isInstanceOf(BadRequestException.class)
                .hasMessage("Unknown error");
    }

    @Test
    @DisplayName("deve_deletar_motorista_com_sucesso")
    public void deleteDriver() {
        Driver driver = buildDriver();

        Mockito.when(driverRepository.findById(eq(1L))).thenReturn(Optional.of(driver));
        Mockito.doNothing().when(driverRepository).deleteById(1L);

        driverService.deleteDriver(1L);

        Mockito.verify(driverRepository, Mockito.times(1)).deleteById(1L);
    }

    @Test
    @DisplayName("deve_tratar_exception_ao_nao_encontrar_motorista_para_deletar")
    public void deleteDriverNotFound() {
        Mockito.when(driverRepository.findById(eq(1L))).thenReturn(Optional.empty());

        Throwable exception = catchThrowable(() -> driverService.deleteDriver(1L));

        assertThat(exception)
                .isInstanceOf(NotFoundException.class)
                .hasMessage("driver not found");
    }

    private DriverRequest buildDriverRequest() {
        DriverRequest driverRequest = new DriverRequest();
        driverRequest.setEmail("driver@example.com");
        driverRequest.setName("Driver Name");
        driverRequest.setPass("password");
        driverRequest.setCnh("1234567890");
        return driverRequest;
    }

    private Driver buildDriver() {
        Driver driver = new Driver();
        driver.setDriverId(1L);
        driver.setName("Driver Name");
        driver.setEmail("driver@example.com");
        driver.setPass("password");
        driver.setCnh("1234567890");
        driver.setCar(new Car());
        return driver;
    }

    private Driver buildDriver(DriverRequest driverRequest) {
        return new Driver(driverRequest);
    }

}
