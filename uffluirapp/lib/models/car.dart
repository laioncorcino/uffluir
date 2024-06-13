class Car {

    final String carId;
    final String brand;
    final String color;
    final String model;
    final String plate;
    final String user_id;
    final Integer year;

    Car({
        this.carId,
        this.brand,
        this.color,
        this.model,
        this.plate,
        this.user_id,
        this.year,
    });

}

// JAVA
// public class Car {

//     @Id	
//     @GeneratedValue(strategy = GenerationType.IDENTITY)
//     private Long carId;
//     private String brand;
//     private String model;
//     private String plate;
//     private Integer year;
//     private String color;

//     public Car(CarRequest carRequest) {
//         this.brand = carRequest.getBrand();
//         this.model = carRequest.getModel();
//         this.plate = carRequest.getPlate();
//         this.year = carRequest.getYear();
//         this.color = carRequest.getColor();
//     }

// }