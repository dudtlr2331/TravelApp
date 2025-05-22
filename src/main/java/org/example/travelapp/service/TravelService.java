package org.example.travelapp.service;

import org.example.travelapp.model.TravelDAO;
import org.example.travelapp.model.TravelTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class TravelService {

    @Autowired
    private TravelDAO dao;

    // main 화면에 제목 별 출력
    public List<TravelTO> mainListByTitle() {
        return dao.mainListByTitle();
    }

    // main 화면에 지역 별 출력
    public List<TravelTO> mainListByDistrict() {
        return dao.mainListByDistrict();
    }

    public List<TravelTO> searchDistrict(String strDistrict) {
        return dao.travelSearchDistrict(strDistrict);
    }

    public List<TravelTO> searchByTitle(String title) {
        return dao.searchByTitle(title);
    }

    public List<TravelTO> searchDescription(String description) {
        return dao.searchDescription(description);
    }

    public TravelTO getDetail(int no) {
        return dao.travelDetails(no);
    }

    public List<TravelTO> getNearbyByDistrict(String district, int excludeNo) {
        return dao.getNearbyByDistrict(district, excludeNo);
    }
}
