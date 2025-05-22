package org.example.travelapp.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.List;

@Repository
public class TravelDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<TravelTO> mainListByTitle() {
        String sql = "SELECT no, district, title, description, address, phone FROM travel ORDER BY title LIMIT 10";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(TravelTO.class));
    }

    public List<TravelTO> mainListByDistrict() {
        String sql = "SELECT no, district, title, description, address, phone FROM travel ORDER BY district LIMIT 10";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(TravelTO.class));
    }

    public List<TravelTO> travelSearchDistrict(String strDistrict){
        String sql = "select no, district, title, description, address, phone from travel where district like ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<TravelTO>(TravelTO.class), "%"+strDistrict+"%");
    }

    public List<TravelTO> searchByTitle(String title) {
        String sql = "select title, description, address from travel where title like ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(TravelTO.class), "%" + title + "%");
    }

    public TravelTO travelDetails(int no) {
        String sql = "select no, district, title, description, address, phone from travel WHERE no = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(TravelTO.class), no);
    }
}
