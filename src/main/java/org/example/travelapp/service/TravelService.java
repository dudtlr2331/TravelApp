package org.example.travelapp.service;

import org.example.travelapp.model.TravelDAO;
import org.example.travelapp.model.TravelListTO;
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

    // 메인 슬라이드
    public List<TravelTO> getTopSlides() {
        return dao.getTopSlides();
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

    public TravelListTO searchAllFields(String keyword, int cpage) {
        int totalRecord = dao.getTotalRecordByAll(keyword);
        TravelListTO listTO = new TravelListTO();
        listTO.setCpage(cpage);
        listTO.setTotalRecord(totalRecord);
        int startRow = (cpage - 1) * listTO.getRecordPerPage();

        listTO.setBoardLists(dao.searchAllFields(keyword, startRow, listTO.getRecordPerPage()));
        return listTO;
    }
}
