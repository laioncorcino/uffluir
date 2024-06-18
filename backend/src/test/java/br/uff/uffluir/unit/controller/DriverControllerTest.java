package br.uff.uffluir.unit.controller;

import br.uff.uffluir.json.DriverRequest;
import br.uff.uffluir.model.Driver;
import br.uff.uffluir.service.DriverService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

public class DriverControllerTest extends InfraControllerDriver {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private DriverService driverService;

    @Test
    @DisplayName("deve_criar_motorista_com_sucesso")
    public void createDriver() throws Exception {
        DriverRequest driverRequest = buildDriverRequest();
        Driver driver = buildDriver();

        Mockito.when(driverService.createDriver(any(DriverRequest.class))).thenReturn(driver);

        MockHttpServletRequestBuilder postRequest = post("/api/v1/drivers")
                .contentType(MediaType.APPLICATION_JSON)
                .content(asJsonString(driverRequest));

        mockMvc.perform(postRequest)
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("deve_deletar_motorista_com_sucesso")
    public void deleteDriver() throws Exception {
        Long driverId = 1L;

        Mockito.doNothing().when(driverService).deleteDriver(eq(driverId));

        MockHttpServletRequestBuilder deleteRequest = delete("/api/v1/drivers/{driverId}", driverId);

        mockMvc.perform(deleteRequest)
                .andExpect(status().isNoContent());
    }

    private DriverRequest buildDriverRequest() {
        DriverRequest driverRequest = new DriverRequest();
        driverRequest.setName("Driver Name");
        driverRequest.setEmail("driver@example.com");
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
        return driver;
    }

    private String asJsonString(final Object obj) {
        try {
            return new ObjectMapper().writeValueAsString(obj);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
