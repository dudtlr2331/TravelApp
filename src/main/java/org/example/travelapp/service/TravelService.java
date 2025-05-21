package org.example.travelapp.service;

import org.example.travelapp.model.TravelDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TravelService {

    @Autowired
    private TravelDAO dao;
}
