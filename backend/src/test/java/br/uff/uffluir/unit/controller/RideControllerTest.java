package br.uff.uffluir.unit.controller;

import br.uff.uffluir.json.AcceptRequest;
import br.uff.uffluir.json.ConcludedRequest;
import br.uff.uffluir.json.DeleteRequest;
import br.uff.uffluir.json.RideRequest;
import br.uff.uffluir.model.Car;
import br.uff.uffluir.model.Driver;
import br.uff.uffluir.model.Ride;
import br.uff.uffluir.service.RideService;
import br.uff.uffluir.util.JsonUtil;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

public class RideControllerTest extends InfraControllerRide {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private RideService rideService;

    @Test
    @DisplayName("deve_criar_corrida_com_sucesso")
    public void createRide() throws Exception {
        RideRequest rideRequest = buildRideRequest();
        Ride ride = buildRide(rideRequest, buildDriver());

        Mockito.when(rideService.createRide(any(RideRequest.class))).thenReturn(ride);

        MockHttpServletRequestBuilder postRequest = doPost("/offer", JsonUtil.toJson(rideRequest));

        mockMvc.perform(postRequest)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.rideId").value(ride.getRideId()))
                .andExpect(jsonPath("$.departurePlace").value("Place A"))
                .andExpect(jsonPath("$.arrivalPlace").value("Place B"));
    }

    @Test
    @DisplayName("deve_listar_corridas")
    public void listRides() throws Exception {
        Page<Ride> rides = new PageImpl<>(List.of(buildRide()));

        Mockito.when(rideService.getAllRides(any(Pageable.class))).thenReturn(rides);

        MockHttpServletRequestBuilder getRequest = doGet("");

        mockMvc.perform(getRequest)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.content").isArray())
                .andExpect(jsonPath("$.content[0].rideId").value(rides.getContent().get(0).getRideId()));
    }

    @Test
    @DisplayName("deve_aceitar_corrida_com_sucesso")
    public void acceptRide() throws Exception {
        AcceptRequest acceptRequest = buildAcceptRequest();
        Ride ride = buildRide();

        Mockito.when(rideService.acceptRide(any(AcceptRequest.class), eq(1L))).thenReturn(ride);

        MockHttpServletRequestBuilder putRequest = doPut("/accept/1", JsonUtil.toJson(acceptRequest));

        mockMvc.perform(putRequest)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.rideId").value(ride.getRideId()))
                .andExpect(jsonPath("$.status").value("OPEN"));
    }

    @Test
    @DisplayName("deve_concluir_corrida_com_sucesso")
    public void concludeRide() throws Exception {
        ConcludedRequest concludedRequest = new ConcludedRequest();
        concludedRequest.setDriverEmail("driver@example.com");

        MockHttpServletRequestBuilder putRequest = doPut("/concluded/1", JsonUtil.toJson(concludedRequest));

        mockMvc.perform(putRequest)
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("deve_deletar_corrida_com_sucesso")
    public void deleteRide() throws Exception {
        DeleteRequest deleteRequestBody = new DeleteRequest();
        deleteRequestBody.setDriverEmail("driver@example.com");

        Mockito.doNothing().when(rideService).deleteRide(eq(1L), eq("driver@example.com"));

        MockHttpServletRequestBuilder deleteRequest = doDelete("/1", JsonUtil.toJson(deleteRequestBody));

        mockMvc.perform(deleteRequest)
                .andExpect(status().isNoContent());
    }

    private RideRequest buildRideRequest() {
        RideRequest rideRequest = new RideRequest();
        rideRequest.setDriverEmail("driver@example.com");
        rideRequest.setDeparturePlace("Place A");
        rideRequest.setArrivalPlace("Place B");
        rideRequest.setDepartureTime("2024-06-15 10:00:00");
        rideRequest.setArrivalTime("2024-06-15 11:00:00");
        rideRequest.setSize(4);
        return rideRequest;
    }

    private AcceptRequest buildAcceptRequest() {
        AcceptRequest acceptRequest = new AcceptRequest();
        acceptRequest.setPassengerEmail("passenger@example.com");
        return acceptRequest;
    }

    private Ride buildRide() {
        Ride ride = new Ride();
        ride.setRideId(1L);
        ride.setKey(UUID.randomUUID().toString());
        ride.setDeparturePlace("Place A");
        ride.setArrivalPlace("Place B");
        ride.setDepartureTime(LocalDateTime.parse("2024-06-15T10:00:00"));
        ride.setArrivalTime(LocalDateTime.parse("2024-06-15T11:00:00"));
        ride.setStatus("OPEN");
        ride.setSize(4);
        ride.setDriver(buildDriver());
        ride.setPassengers(new ArrayList<>());
        return ride;
    }

    private Ride buildRide(RideRequest rideRequest, Driver driver) {
        return new Ride(rideRequest, driver);
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

}
