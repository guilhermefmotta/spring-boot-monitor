package com.monitor.demo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HealthController {

    private final Logger LOG = LoggerFactory.getLogger(HealthController.class);


    @GetMapping("/health")
    public String health() {
        LOG.info("OK");

        return  "OK";
    }
}
