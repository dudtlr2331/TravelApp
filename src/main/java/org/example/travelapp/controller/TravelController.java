package org.example.travelapp.controller;

import org.example.travelapp.model.TravelListTO;
import org.example.travelapp.model.TravelTO;
import org.example.travelapp.service.TravelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    // 메인 슬라이드 영역
    @GetMapping("/api/slider")
    @ResponseBody
    public List<Map<String, Object>> getSliderData() {
        List<TravelTO> list = service.getTopSlides(); // DAO에서 상위 5~6개 가져오도록
        List<Map<String, Object>> response = new ArrayList<>();

        for (TravelTO to : list) {
            Map<String, Object> item = new HashMap<>();
            item.put("no", to.getNo());
            item.put("img", "/images/travel_" + to.getNo() + ".jpg");
            item.put("title", to.getTitle());
            item.put("desc", to.getDescription());
            response.add(item);
        }

        return response;
    }

    @GetMapping("/search/all/{keyword}")
    public String searchAll(@PathVariable String keyword, @RequestParam(value = "cpage", defaultValue="1") int cpage, Model model) {
        TravelListTO lists = service.searchAllFields(keyword, cpage);

        model.addAttribute("lists", lists);
        model.addAttribute("keyword", keyword);
        return "search";
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
