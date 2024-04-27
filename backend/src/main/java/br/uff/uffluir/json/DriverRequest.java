package br.uff.uffluir.json;

import lombok.Data;

@Data
public class DriverRequest {

    private String name;
    private String email;
    private String pass;
    private String cnh;

}
