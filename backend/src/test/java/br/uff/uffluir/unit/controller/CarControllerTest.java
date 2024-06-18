package br.uff.uffluir.unit.controller;

import br.uff.uffluir.json.CarRequest;
import br.uff.uffluir.model.Car;
import br.uff.uffluir.service.CarService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import com.fasterxml.jackson.databind.ObjectMapper;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

public class CarControllerTest extends InfraControllerCar {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private CarService carService;

    @Test
    @DisplayName("deve_criar_carro_com_sucesso")
    public void createCar() throws Exception {
        CarRequest carRequest = buildCarRequest();
        Car car = buildCar();

        Mockito.when(carService.createCar(any(CarRequest.class))).thenReturn(car);

        MockHttpServletRequestBuilder postRequest = doPost("", asJsonString(carRequest));

        mockMvc.perform(postRequest)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.carId").value(car.getCarId()))
                .andExpect(jsonPath("$.model").value("Model X"))
                .andExpect(jsonPath("$.plate").value("ABC-1234"));
    }

    @Test
    @DisplayName("deve_deletar_carro_com_sucesso")
    public void deleteCar() throws Exception {
        Long carId = 1L;

        Mockito.doNothing().when(carService).deleteCar(eq(carId));

        MockHttpServletRequestBuilder deleteRequest = doDelete("/" + carId, "");

        mockMvc.perform(deleteRequest)
                .andExpect(status().isNoContent());
    }

    @Test
    @DisplayName("deve_atualizar_carro_com_sucesso")
    public void updateCar() throws Exception {
        Long carId = 1L;
        CarRequest carRequest = buildCarRequest();
        Car updatedCar = buildCar();

        Mockito.when(carService.updateCar(eq(carId), any(CarRequest.class))).thenReturn(updatedCar);

        MockHttpServletRequestBuilder putRequest = doPut("/" + carId, asJsonString(carRequest));

        mockMvc.perform(putRequest)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.carId").value(updatedCar.getCarId()))
                .andExpect(jsonPath("$.model").value("Model X"))
                .andExpect(jsonPath("$.plate").value("ABC-1234"));
    }

    private CarRequest buildCarRequest() {
        CarRequest carRequest = new CarRequest();
        carRequest.setModel("Model X");
        carRequest.setPlate("ABC-1234");
        return carRequest;
    }

    private Car buildCar() {
        Car car = new Car();
        car.setCarId(1L);
        car.setModel("Model X");
        car.setPlate("ABC-1234");
        return car;
    }

    private String asJsonString(final Object obj) {
        try {
            return new ObjectMapper().writeValueAsString(obj);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
