package org.example.travelapp.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class SubjectDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<SubjectTO> searchByTitle(String title) {
        String sql = "select title, description, address from travel where title like ?";
        List<SubjectTO> lists = new ArrayList<>();
        return jdbcTemplate.query(
                sql,
                new BeanPropertyRowMapper<>(SubjectTO.class),
                "%" + title + "%"
        );
    }
}
