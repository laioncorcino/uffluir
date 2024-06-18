package br.uff.uffluir.integration;

import br.uff.uffluir.json.*;
import br.uff.uffluir.repository.RideRepository;
import br.uff.uffluir.wrapper.PageableResponse;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class RideSystemTest extends RideInfraTest {

    @Autowired
    private RideRepository rideRepository;

    @BeforeEach
    public void cleanerDatabase() {
        rideRepository.deleteAll();
    }

    @Test
    @DisplayName("deve_retornar_lista_de_corridas")
    public void listRides() {
        populateDatabase();

        ResponseEntity<PageableResponse<RideResponse>> getResponse = doGetRides();

        assertThat(getResponse.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(getResponse.getHeaders()).isNotNull();
        assertThat(getResponse.getHeaders().getContentType()).isEqualTo(MediaType.APPLICATION_JSON);

        PageableResponse<RideResponse> pageRides = getResponse.getBody();

        assertThat(pageRides).isNotNull();
        assertThat(pageRides.getNumberOfElements()).isEqualTo(3);
        assertThat(pageRides.getNumber()).isEqualTo(0);
        assertThat(pageRides.getSize()).isEqualTo(10);

        List<RideResponse> contentList = pageRides.getContent();

        assertTrue(contentList.stream().anyMatch(ride -> ride.getDriver().getEmail().equals("driver1@example.com")));
        assertTrue(contentList.stream().anyMatch(ride -> ride.getDriver().getEmail().equals("driver2@example.com")));
        assertTrue(contentList.stream().anyMatch(ride -> ride.getDriver().getEmail().equals("driver3@example.com")));
    }

    @Test
    @DisplayName("deve_criar_corrida_com_sucesso")
    public void createRide() {
        RideRequest rideRequest = new RideRequest(
                "driver@id.uff.br",
                "Location A",
                "Location B",
                "2023-12-31T10:00:00",
                "2023-12-31T10:30:00",4
        );

        ResponseEntity<RideResponse> postResponse = doPostRide(rideRequest);

        assertThat(postResponse).isNotNull();
        assertThat(postResponse.getStatusCode()).isEqualTo(HttpStatus.CREATED);

        assertThat(postResponse.getBody()).isNotNull();
        assertThat(postResponse.getBody().getDriver().getEmail()).isEqualTo("driver@id.uff.br");
        assertThat(postResponse.getBody().getDeparturePlace()).isEqualTo("Instituto de Computação");
        assertThat(postResponse.getBody().getArrivalPlace()).isEqualTo("Campus Gragoatá");
        assertThat(postResponse.getBody().getDepartureTime()).isEqualTo("2023-06-20 10:00:00");
        assertThat(postResponse.getBody().getArrivalTime()).isEqualTo("2023-06-20 10:30:00");
        assertThat(postResponse.getBody().getSize()).isEqualTo(4);
    }

    @Test
    @DisplayName("deve_aceitar_corrida_com_sucesso")
    public void acceptRide() {
        populateDatabase();
        RideRequest rideRequest = new RideRequest("driver1@example.com", "Location A", "Location B", "2023-12-31T10:00:00", "2023-12-31T10:30:00",4);
        ResponseEntity<RideResponse> postResponse = doPostRide(rideRequest);

        String uri = extractUrlContext(postResponse);
        Long rideId = Long.parseLong(uri.substring(uri.lastIndexOf('/') + 1));

        AcceptRequest acceptRequest = new AcceptRequest("passenger1@example.com");
        ResponseEntity<RideResponse> putResponse = doPutAcceptRide(rideId, acceptRequest);

        assertThat(putResponse.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(putResponse.getBody()).isNotNull();
        assertThat(putResponse.getBody().getStatus()).isEqualTo("CLOSED");
    }

    @Test
    @DisplayName("deve_concluir_corrida_com_sucesso")
    public void concludeRide() {
        populateDatabase();
        RideRequest rideRequest = new RideRequest("driver1@example.com", "Location A", "Location B", "2023-12-31T10:00:00", "2023-12-31T10:30:00",4);
        ResponseEntity<RideResponse> postResponse = doPostRide(rideRequest);

        String uri = extractUrlContext(postResponse);
        Long rideId = Long.parseLong(uri.substring(uri.lastIndexOf('/') + 1));

        ConcludedRequest concludedRequest = new ConcludedRequest("driver6@example.com");
        ResponseEntity<Void> putResponse = doPutConcludeRide(rideId, concludedRequest);

        assertThat(putResponse.getStatusCode()).isEqualTo(HttpStatus.OK);
    }

    @Test
    @DisplayName("deve_deletar_corrida_com_sucesso")
    public void deleteRide() {
        populateDatabase();
        RideRequest rideRequest = new RideRequest("driver1@example.com", "Location A", "Location B", "2023-12-31T10:00:00", "2023-12-31T10:30:00",4);
        ResponseEntity<RideResponse> postResponse = doPostRide(rideRequest);

        String uri = extractUrlContext(postResponse);
        Long rideId = Long.parseLong(uri.substring(uri.lastIndexOf('/') + 1));

        DeleteRequest deleteRequest = new DeleteRequest("driver7@example.com");
        ResponseEntity<Void> deleteResponse = doDeleteRide(rideId, deleteRequest);

        assertThat(deleteResponse.getStatusCode()).isEqualTo(HttpStatus.NO_CONTENT);

        ResponseEntity<RideResponse> getResponse = testRestTemplate.exchange(
                RIDE_API + "/" + rideId,
                HttpMethod.GET,
                new HttpEntity<>(createHeader()),
                RideResponse.class
        );

        assertThat(getResponse.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
    }

}
