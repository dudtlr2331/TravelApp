package org.example.travelapp.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class TravelDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<TravelTO> travelMain(){
        String sql = "select no, district, title, description, address, phone from travel";
        List<TravelTO> lists = new ArrayList<>();
        return lists;
    }
}
