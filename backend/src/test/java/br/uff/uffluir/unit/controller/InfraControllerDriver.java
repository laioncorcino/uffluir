package br.uff.uffluir.unit.controller;

import br.uff.uffluir.controller.DriverController;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;


@ExtendWith(MockitoExtension.class)
@WebMvcTest(controllers = DriverController.class)
@AutoConfigureMockMvc
public abstract class InfraControllerDriver {

    protected static final String DRIVER_API = "http://localhost:8080/api/v1/drivers";

    protected MockHttpServletRequestBuilder doPost(String path, String requestJson) {
        return post(DRIVER_API + path)
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON)
                .content(requestJson);
    }

    protected MockHttpServletRequestBuilder doDelete(String path, String requestJson) {
        return delete(DRIVER_API + path)
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON)
                .content(requestJson);
    }

}
