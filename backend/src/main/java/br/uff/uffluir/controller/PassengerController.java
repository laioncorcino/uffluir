package br.uff.uffluir.controller;

import br.uff.uffluir.json.PassengerRequest;
import br.uff.uffluir.json.PassengerResponse;
import br.uff.uffluir.model.Passenger;
import br.uff.uffluir.service.PassengerService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/passengers")
public class PassengerController {

    private final PassengerService passengerService;

    @Autowired
    public PassengerController(PassengerService passengerService) {
        this.passengerService = passengerService;
    }

    @PostMapping()
    public ResponseEntity<PassengerResponse> create(@RequestBody @Valid PassengerRequest passengerRequest) {
        Passenger passenger = passengerService.createPassenger(passengerRequest);
        return ResponseEntity.ok(new PassengerResponse(passenger));
    }

    @DeleteMapping("/{passengerId}")
    public ResponseEntity<Void> delete(@PathVariable Long passengerId) {
        passengerService.deletePassenger(passengerId);
        return ResponseEntity.noContent().build();
    }

}
