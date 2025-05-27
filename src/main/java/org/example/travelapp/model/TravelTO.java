package org.example.travelapp.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TravelTO {
    private int no;
    private String district;
    private String title;
    private String description;
    private String address;
    private String phone;
    private Double  latitude;   // 위도
    private Double  longitude;  // 경도
}