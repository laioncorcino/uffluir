package br.uff.uffluir.controller;

import br.uff.uffluir.json.DriverRequest;
import br.uff.uffluir.json.DriverResponse;
import br.uff.uffluir.model.Driver;
import br.uff.uffluir.service.DriverService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

@RestController
@RequestMapping("/api/v1/drivers")
public class DriverController {

    private final DriverService driverService;

    @Autowired
    public DriverController(DriverService driverService) {
        this.driverService = driverService;
    }

    @PostMapping()
    public ResponseEntity<DriverResponse> create(@RequestBody @Valid DriverRequest driverRequest) {
        Driver driver = driverService.createDriver(driverRequest);
        return ResponseEntity.ok(new DriverResponse(driver));
    }

    @DeleteMapping("/{driverId}")
    public ResponseEntity<Void> delete(@PathVariable Long driverId) {
        driverService.deleteDriver(driverId);
        return ResponseEntity.noContent().build();
    }

}
