package com.database.icms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class IndexController {

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index() {
		return "index";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
    public String getLoginPage() {
        return "login";
    }
	
	@RequestMapping(value = "/accessDeny", method = RequestMethod.GET)
    public String errorPage(ModelMap model) {
		model.addAttribute("msg", "Access Denied.");
        return "error";
    }

}
