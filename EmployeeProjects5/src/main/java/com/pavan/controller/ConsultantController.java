package com.pavan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pavan.model.ConsultantBO;
import com.pavan.service.ConsultantService;

@Controller
public class ConsultantController {
	
	private ConsultantService consultantService;
	
	@Autowired(required = true)
	@Qualifier(value = "consultantService")
	public void setConsultantService(ConsultantService ps) {
		this.consultantService = ps;
	}
	
	@RequestMapping(value = "/consultants", method = RequestMethod.GET)
	public ModelAndView consultants() {
		ModelAndView mv = new ModelAndView();
		// mv.addObject("consultant", new ConsultantBO());
		mv.addObject("consultants", this.consultantService.listConsultants());
		mv.setViewName("consultant");
		return mv;
	}
	
	@RequestMapping("/consultant/showCliPopup")
	public ModelAndView showEmpPopup() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("consultant", new ConsultantBO());
		mv.addObject("consultants", this.consultantService.listConsultants());
		mv.setViewName("consultantPopUp");
		return mv;
	}

	@RequestMapping(value = "/consultant/add", method = RequestMethod.POST)
	@ResponseBody
	public String addConsultant(@ModelAttribute("consultant") ConsultantBO consultant) {
		String message = "";
		if (consultant.getId() == 0) {
			this.consultantService.addConsultant(consultant);
			message = consultant.getName() + " saved successfully.";
		} else {
			this.consultantService.updateConsultant(consultant);
			message = consultant.getName() + " updated successfully.";
		}
		return message;
	}

	@RequestMapping("/consultant/update/{id}")
	public ModelAndView updateConsultant(@PathVariable("id") int id) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("consultantPopUp");
		ConsultantBO cli = this.consultantService.getConsultantById(id);
		mv.addObject("consultant", cli);
		mv.addObject("consultants", this.consultantService.listConsultants());
		return mv;
	}

	@RequestMapping("/consultant/delete/{id}")
	public String deleteConsultant(@PathVariable("id") int id) {
		this.consultantService.deleteConsultant(id);
		return "redirect:/consultants";
	}

}