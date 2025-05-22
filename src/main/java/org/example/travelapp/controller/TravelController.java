package org.example.travelapp.controller;

import org.example.travelapp.model.TravelTO;
import org.example.travelapp.service.TravelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

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
        } else {
            lists = new ArrayList<>();
        }

        model.addAttribute("lists", lists);
        model.addAttribute("keyword", keyword);
        return "search";
    }

    // Get 요청으로 검색 파라미터 받을 수 있도록 함
//    @GetMapping("/search/{strDistrict}")
//    public String searchDistrict(@PathVariable("strDistrict") String strDistrict, Model model) {
//
//        // 검색어인 strDistrict 를 통해 service 호출
//        ArrayList<TravelTO> lists = service.searchDistrict(strDistrict);
//
//        // 검색 결과는 lists 라는 이름으로 model 에 담아 jsp로 전송
//        model.addAttribute("lists",lists);
//
//        // 검색 키워드( strDistrict ) 는 keyword 라는 이름으로 jsp로 함께 전달
//        model.addAttribute("keyword", strDistrict);
//
//        // "~~".jsp 로 포워딩 - 전달 받을 페이지가 결정되면 수정 예정
//        return "search";
//    }


//    @GetMapping("/search/{title}")
//    public String searchByTitle(@PathVariable("title") String title, Model model) {
//        // 검색 기능 호출
//        List<TravelTO> lists = service.searchByTitle(title);
//
//        // 결과를 모델에 담기
//        model.addAttribute("lists", lists);
//        model.addAttribute("keyword", title);
//
//        // JSP로 변환
//        return "search";
//    }


    @RequestMapping("/detail/{no}")
    public String detail(@PathVariable("no") int no, Model model) {
        TravelTO to = service.getDetail(no);
        model.addAttribute("place", to);
        return "detail";
    }
}
