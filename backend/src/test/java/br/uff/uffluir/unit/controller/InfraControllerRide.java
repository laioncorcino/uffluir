package br.uff.uffluir.unit.controller;

import br.uff.uffluir.controller.RideController;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

@ExtendWith(MockitoExtension.class)
@WebMvcTest(controllers = RideController.class)
@AutoConfigureMockMvc
public abstract class InfraControllerRide {

    protected static final String RIDE_API = "http://localhost:8080/api/v1/rides";

    protected MockHttpServletRequestBuilder doGet(String path) {
        return get(RIDE_API + path)
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON);
    }

    protected MockHttpServletRequestBuilder doPost(String path, String requestJson) {
        return post(RIDE_API + path)
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON)
                .content(requestJson);
    }

    protected MockHttpServletRequestBuilder doPut(String path, String requestJson) {
        return put(RIDE_API + path)
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON)
                .content(requestJson);
    }

    protected MockHttpServletRequestBuilder doDelete(String path, String requestJson) {
        return delete(RIDE_API + path)
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON)
                .content(requestJson);
    }

}
