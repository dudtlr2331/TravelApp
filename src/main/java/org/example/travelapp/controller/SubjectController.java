package org.example.travelapp.controller;

import org.springframework.ui.Model;
import org.example.travelapp.model.SubjectDAO;
import org.example.travelapp.model.SubjectTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class SubjectController {

    @Autowired
    private SubjectDAO subjectDAO;

    @GetMapping("/search")
    public String searchByTitle(@RequestParam("title") String title, Model model) {
        List<SubjectTO> subjects = subjectDAO.searchByTitle(title);
        model.addAttribute("subjectList", subjects);
        model.addAttribute("keyword", title);
        return "subject_search";
    }

}
