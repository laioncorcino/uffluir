package br.uff.uffluir.unit.controller;

import br.uff.uffluir.controller.CarController;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

@ExtendWith(MockitoExtension.class)
@WebMvcTest(controllers = CarController.class)
@AutoConfigureMockMvc
public abstract class InfraControllerCar {

    protected static final String CAR_API = "http://localhost:8080/api/v1/cars";

    protected MockHttpServletRequestBuilder doGet(String path) {
        return get(CAR_API + path)
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON);
    }

    protected MockHttpServletRequestBuilder doPost(String path, String requestJson) {
        return post(CAR_API + path)
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON)
                .content(requestJson);
    }

    protected MockHttpServletRequestBuilder doPut(String path, String requestJson) {
        return put(CAR_API + path)
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON)
                .content(requestJson);
    }

    protected MockHttpServletRequestBuilder doDelete(String path, String requestJson) {
        return delete(CAR_API + path)
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON)
                .content(requestJson);
    }

}
