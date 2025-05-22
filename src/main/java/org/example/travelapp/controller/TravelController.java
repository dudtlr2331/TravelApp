package org.example.travelapp.controller;

import org.example.travelapp.model.TravelTO;
import org.example.travelapp.service.TravelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
public class TravelController {

    @Autowired
    private TravelService service;

    @RequestMapping("/main")
    public String main(Model model) {
        List<TravelTO> titleList = service.mainListByTitle();      // title 기준
        List<TravelTO> districtList = service.mainListByDistrict(); // district 기준

        model.addAttribute("titleList", titleList);
        model.addAttribute("districtList", districtList);

        return "main";
    }

    @GetMapping("/search/{type}/{keyword}")
    public String search(
            @PathVariable("type") String type,
            @PathVariable("keyword") String keyword,
            Model model) {

        List<TravelTO> lists;

        if (type.equals("title")) {
            lists = service.searchByTitle(keyword);
        } else if (type.equals("district")) {
            lists = service.searchDistrict(keyword);
        } else if (type.equals("description")) {
            lists = service.searchDescription(keyword);
        }else {
            lists = new ArrayList<>();
        }

        model.addAttribute("lists", lists);
        model.addAttribute("keyword", keyword);
        return "search";
    }

    @RequestMapping("/detail/{no}")
    public String detail(
            @PathVariable("no") int no,
            @RequestParam(required = false) String type,
            @RequestParam(required = false) String keyword,
            Model model) {

        // 1. 상세 정보 조회
        TravelTO to = service.getDetail(no);
        model.addAttribute("place", to);

        // 2. 지역 기반 주변 관광지 추가
        List<TravelTO> nearbyList = service.getNearbyByDistrict(to.getDistrict(), no);
        model.addAttribute("nearbyList", nearbyList);

        // 3. 검색어가 있을 경우 검색 결과도 추가
        if (keyword != null && !keyword.isEmpty()) {
            List<TravelTO> results;

            if ("title".equals(type)) {
                results = service.searchByTitle(keyword);
            } else if ("district".equals(type)) {
                results = service.searchDistrict(keyword);
            } else {
                results = new ArrayList<>();
            }

            model.addAttribute("searchResults", results);
            model.addAttribute("keyword", keyword);
            model.addAttribute("type", type);
        }

        return "detail";
    }
}
