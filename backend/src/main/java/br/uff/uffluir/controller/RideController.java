package br.uff.uffluir.controller;

import br.uff.uffluir.json.AcceptRequest;
import br.uff.uffluir.json.RideRequest;
import br.uff.uffluir.json.RideResponse;
import br.uff.uffluir.model.Ride;
import br.uff.uffluir.service.RideService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import static org.springframework.data.domain.Sort.Direction.ASC;

@RestController
@RequestMapping("/api/v1/rides")
public class RideController {

    private final RideService rideService;

    @Autowired
    public RideController(RideService rideService) {
        this.rideService = rideService;
    }

    @PostMapping("/offer")
    public ResponseEntity<RideResponse> create(@RequestBody @Valid RideRequest rideRequest) {
        Ride ride = rideService.createRide(rideRequest);
        return ResponseEntity.ok(new RideResponse(ride));
    }

    @GetMapping
    public ResponseEntity<Page<RideResponse>> list(@PageableDefault(sort = "rideId", direction = ASC) Pageable pageable) {
        return ResponseEntity.ok(rideService.getAllRides(pageable).map(RideResponse::new));
    }

    @PutMapping("/accept/{rideId}")
    public ResponseEntity<RideResponse> accept(@RequestBody AcceptRequest acceptRequest, @PathVariable Long rideId) {
        Ride ride = rideService.acceptRide(acceptRequest, rideId);
        return ResponseEntity.ok(new RideResponse(ride));
    }

}
