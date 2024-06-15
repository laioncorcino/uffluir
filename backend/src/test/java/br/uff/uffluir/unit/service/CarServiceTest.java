package br.uff.uffluir.unit.service;

import br.uff.uffluir.error.exception.BadRequestException;
import br.uff.uffluir.error.exception.NotFoundException;
import br.uff.uffluir.json.CarRequest;
import br.uff.uffluir.model.Car;
import br.uff.uffluir.repository.CarRepository;
import br.uff.uffluir.repository.DriverRepository;
import br.uff.uffluir.service.CarService;
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
public class CarServiceTest {

    @InjectMocks
    private CarService carService;

    @Mock
    private CarRepository carRepository;

    @Mock
    private DriverRepository driverRepository;

    @Test
    @DisplayName("deve_criar_carro_com_sucesso")
    public void createCar() {
        CarRequest carRequest = buildCarRequest();
        Car car = buildCar(carRequest);

        Mockito.when(carRepository.save(any(Car.class))).thenReturn(car);

        Car createdCar = carService.createCar(carRequest);

        assertThat(createdCar).isNotNull();
        assertThat(createdCar.getPlate()).isEqualTo(carRequest.getPlate());
    }

    @Test
    @DisplayName("deve_tratar_exception_de_integridade_de_dados_ao_criar_carro")
    public void createCarDataIntegrityViolation() {
        CarRequest carRequest = buildCarRequest();

        Mockito.when(carRepository.save(any(Car.class))).thenThrow(new DataIntegrityViolationException("Duplicated key"));

        Throwable exception = catchThrowable(() -> carService.createCar(carRequest));

        assertThat(exception)
                .isInstanceOf(BadRequestException.class)
                .hasMessage("Duplicated key");
    }

    @Test
    @DisplayName("deve_tratar_exception_desconhecida_ao_criar_carro")
    public void createCarUnknownError() {
        CarRequest carRequest = buildCarRequest();

        Mockito.when(carRepository.save(any(Car.class))).thenThrow(new RuntimeException("Unknown error"));

        Throwable exception = catchThrowable(() -> carService.createCar(carRequest));

        assertThat(exception)
                .isInstanceOf(BadRequestException.class)
                .hasMessage("Unknown error");
    }

    @Test
    @DisplayName("deve_atualizar_carro_com_sucesso")
    public void updateCar() {
        CarRequest carRequest = buildCarRequest();
        Car car = buildCar(carRequest);

        Mockito.when(carRepository.findById(eq(1L))).thenReturn(Optional.of(car));
        Mockito.when(carRepository.save(any(Car.class))).thenReturn(car);

        Car updatedCar = carService.updateCar(1L, carRequest);

        assertThat(updatedCar).isNotNull();
        assertThat(updatedCar.getPlate()).isEqualTo(carRequest.getPlate());
    }

    @Test
    @DisplayName("deve_tratar_exception_ao_nao_encontrar_carro_para_atualizar")
    public void updateCarNotFound() {
        CarRequest carRequest = buildCarRequest();

        Mockito.when(carRepository.findById(eq(1L))).thenReturn(Optional.empty());

        Throwable exception = catchThrowable(() -> carService.updateCar(1L, carRequest));

        assertThat(exception)
                .isInstanceOf(NotFoundException.class)
                .hasMessage("Car not found");
    }

    @Test
    @DisplayName("deve_obter_carro_por_id_com_sucesso")
    public void getCarById() {
        Car car = buildCar();

        Mockito.when(carRepository.findById(eq(1L))).thenReturn(Optional.of(car));

        Car foundCar = carService.getCarById(1L);

        assertThat(foundCar).isNotNull();
        assertThat(foundCar.getCarId()).isEqualTo(car.getCarId());
    }

    @Test
    @DisplayName("deve_tratar_exception_ao_nao_encontrar_carro_por_id")
    public void getCarByIdNotFound() {
        Mockito.when(carRepository.findById(eq(1L))).thenReturn(Optional.empty());

        Throwable exception = catchThrowable(() -> carService.getCarById(1L));

        assertThat(exception)
                .isInstanceOf(NotFoundException.class)
                .hasMessage("Car not found");
    }

    @Test
    @DisplayName("deve_deletar_carro_com_sucesso")
    public void deleteCar() {
        Car car = buildCar();

        Mockito.when(carRepository.findById(eq(1L))).thenReturn(Optional.of(car));
        Mockito.doNothing().when(carRepository).delete(car);

        carService.deleteCar(1L);

        Mockito.verify(carRepository, Mockito.times(1)).delete(car);
    }

    @Test
    @DisplayName("deve_tratar_exception_ao_nao_encontrar_carro_para_deletar")
    public void deleteCarNotFound() {
        Mockito.when(carRepository.findById(eq(1L))).thenReturn(Optional.empty());

        Throwable exception = catchThrowable(() -> carService.deleteCar(1L));

        assertThat(exception)
                .isInstanceOf(NotFoundException.class)
                .hasMessage("Car not found");
    }

    private CarRequest buildCarRequest() {
        CarRequest carRequest = new CarRequest();
        carRequest.setDriverId(1L);
        carRequest.setModel("Model");
        carRequest.setBrand("Brand");
        carRequest.setPlate("ABC-1234");
        return carRequest;
    }

    private Car buildCar() {
        Car car = new Car();
        car.setCarId(1L);
        car.setModel("Model");
        car.setBrand("Brand");
        car.setPlate("ABC-1234");
        return car;
    }

    private Car buildCar(CarRequest carRequest) {
        return new Car(carRequest);
    }

}
