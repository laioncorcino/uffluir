package br.uff.uffluir.configuration;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SwaggerConfig {

    @Bean
    OpenAPI customOpenApi() {
        return new OpenAPI()
            .components(new Components())
            .info(new Info()
                .title("UFFluir - Aplicativo de caronas")
                .description("Caronas")
                .version("v1")
            );
    }

}
