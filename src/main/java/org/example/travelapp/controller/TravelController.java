package org.example.travelapp.controller;

import org.example.travelapp.model.TravelTO;
import org.example.travelapp.service.TravelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
public class TravelController {

    @Autowired
    private TravelService service;

    @RequestMapping("/main.do")
    public List<TravelTO> main() {
        List<TravelTO> lists = new ArrayList<>();
        return lists;
    }

    @RequestMapping("/view.do")
    public String view() {
        return "view";
    }
}
