package br.uff.uffluir.controller;

import br.uff.uffluir.json.*;
import br.uff.uffluir.model.Ride;
import br.uff.uffluir.service.RideService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import static org.springframework.data.domain.Sort.Direction.DESC;

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
    public ResponseEntity<Page<RideResponse>> list(@PageableDefault(sort = "rideId", direction = DESC) Pageable pageable) {
        return ResponseEntity.ok(rideService.getAllRides(pageable).map(RideResponse::new));
    }

    @PutMapping("/accept/{rideId}")
    public ResponseEntity<RideResponse> accept(@RequestBody AcceptRequest acceptRequest, @PathVariable Long rideId) {
        Ride ride = rideService.acceptRide(acceptRequest, rideId);
        return ResponseEntity.ok(new RideResponse(ride));
    }

    @PutMapping("/concluded/{rideId}")
    public ResponseEntity<RideResponse> accept(@RequestBody ConcludedRequest concludedRequest, @PathVariable Long rideId) {
        rideService.concludedRide(rideId, concludedRequest.getDriverEmail());
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{rideId}")
    public ResponseEntity<Void> delete(@PathVariable Long rideId, @RequestBody DeleteRequest deleteRequest) {
        rideService.deleteRide(rideId, deleteRequest.getDriverEmail());
        return ResponseEntity.noContent().build();
    }

}
