package br.uff.uffluir.json;

import lombok.Data;

@Data
public class PassengerRequest {

    private String name;
    private String email;
    private String pass;
    private String cnh;

}
