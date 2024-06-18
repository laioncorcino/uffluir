package br.uff.uffluir.integration;

import br.uff.uffluir.json.AcceptRequest;
import br.uff.uffluir.json.ConcludedRequest;
import br.uff.uffluir.json.DeleteRequest;
import br.uff.uffluir.json.RideRequest;
import br.uff.uffluir.json.RideResponse;
import br.uff.uffluir.wrapper.PageableResponse;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.Objects;

import static org.springframework.boot.test.context.SpringBootTest.WebEnvironment.DEFINED_PORT;

@ExtendWith(SpringExtension.class)
@ActiveProfiles("test")
@SpringBootTest(webEnvironment = DEFINED_PORT)
public abstract class RideInfraTest {

    protected static final String RIDE_API = "http://localhost:8080/api/v1/rides";

    protected TestRestTemplate testRestTemplate = new TestRestTemplate();

    protected ResponseEntity<PageableResponse<RideResponse>> doGetRides() {
        return testRestTemplate.exchange(
                RIDE_API,
                HttpMethod.GET,
                new HttpEntity<>(createHeader()),
                new ParameterizedTypeReference<>() {}
        );
    }

    protected ResponseEntity<RideResponse> doPostRide(RideRequest rideRequest) {
        return testRestTemplate.postForEntity(
                RIDE_API + "/offer",
                rideRequest,
                RideResponse.class
        );
    }

    protected ResponseEntity<RideResponse> doPutAcceptRide(Long rideId, AcceptRequest acceptRequest) {
        return testRestTemplate.exchange(
                RIDE_API + "/accept/" + rideId,
                HttpMethod.PUT,
                new HttpEntity<>(acceptRequest, createHeader()),
                RideResponse.class
        );
    }

    protected ResponseEntity<Void> doPutConcludeRide(Long rideId, ConcludedRequest concludedRequest) {
        return testRestTemplate.exchange(
                RIDE_API + "/concluded/" + rideId,
                HttpMethod.PUT,
                new HttpEntity<>(concludedRequest, createHeader()),
                Void.class
        );
    }

    protected ResponseEntity<Void> doDeleteRide(Long rideId, DeleteRequest deleteRequest) {
        return testRestTemplate.exchange(
                RIDE_API + "/" + rideId,
                HttpMethod.DELETE,
                new HttpEntity<>(deleteRequest, createHeader()),
                Void.class
        );
    }

    protected HttpHeaders createHeader() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Accept", "application/json");
        return headers;
    }

    protected void populateDatabase() {
        doPostRide(new RideRequest("driver1@example.com", "Location A", "Location B", "2023-12-31T10:00:00", "2023-12-31T10:30:00",4));
        doPostRide(new RideRequest("driver2@example.com", "Location C", "Location D", "2023-12-31T11:00:00", "2023-12-31T11:30:00", 3));
        doPostRide(new RideRequest("driver3@example.com", "Location E", "Location F", "2023-12-31T12:00:00", "2023-12-31T12:30:00", 2));
    }

    protected String extractUrlContext(ResponseEntity<RideResponse> postResponse) {
        return Objects.requireNonNull(postResponse.getHeaders().getLocation()).getPath();
    }

}
