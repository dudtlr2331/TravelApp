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
        String sql = "SELECT no, district, title, description, address, phone FROM travel ORDER BY title LIMIT 6";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(TravelTO.class));
    }

    public List<TravelTO> mainListByDistrict() {
        String sql = "SELECT no, district, title, description, address, phone FROM travel ORDER BY district LIMIT 6";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(TravelTO.class));
    }

    public List<TravelTO> getTopSlides() {  /* 메인 슬라이드 영역 */
        String sql = "SELECT no, title, description FROM travel ORDER BY no LIMIT 6";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(TravelTO.class));
    }

    public List<TravelTO> travelSearchDistrict(String strDistrict){
        String sql = "select no, district, title, description, address, phone from travel where district like ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<TravelTO>(TravelTO.class), "%"+strDistrict+"%");
    }

    public List<TravelTO> searchByTitle(String title) {
        String sql = "select no, title, description, address from travel where title like ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(TravelTO.class), "%" + title + "%");
    }

    public List<TravelTO> searchDescription(String description) {
        String sql = "select no, district, title, description, address, phone from travel where description like ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(TravelTO.class), "%" + description + "%");
    }

    public TravelTO travelDetails(int no) {
        String sql = "SELECT no, district, title, description, address, phone FROM travel WHERE no = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(TravelTO.class), no);
    }

    public List<TravelTO> getNearbyByDistrict(String district, int excludeNo) {
        String sql = "SELECT no, title, district, description, address, phone FROM travel WHERE district = ? AND no != ? LIMIT 5";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(TravelTO.class), district, excludeNo);
    }

    public List<TravelTO> searchAllFields(String keyword, int startRow, int recordPerPage) {
        String sql = "SELECT * FROM travel WHERE title LIKE ? OR district LIKE ? OR description LIKE ? LIMIT ?, ?";
        String kw = "%" + keyword + "%";
        return jdbcTemplate.query( sql, new BeanPropertyRowMapper<>(TravelTO.class), kw, kw, kw , startRow, recordPerPage);
    }

    public int getTotalRecordByAll(String keyword) {
        String sql = "SELECT COUNT(*) FROM travel WHERE title LIKE ? OR district LIKE ? OR description LIKE ?";
        String kw = "%" + keyword + "%";
        return jdbcTemplate.queryForObject(sql, Integer.class, kw, kw, kw);
    }
}
