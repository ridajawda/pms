package com.pavan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pavan.model.ProjectBO;
import com.pavan.service.ProjectService;

@Controller
public class ProjectController {

	private ProjectService projectService;

	@Autowired(required = true)
	@Qualifier(value = "projectService")
	public void setProjectService(ProjectService ps) {
		this.projectService = ps;
	}

	@RequestMapping(value = "/projects", method = RequestMethod.GET)
	public String listProjects(Model model) {
		model.addAttribute("project", new ProjectBO());
		model.addAttribute("projects", this.projectService.listProjects());
		return "project";
	}
	
	@RequestMapping("/project/showProjectPopup")
	public ModelAndView showProjectPopup() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("project",
		             new ProjectBO());
		mv.setViewName("projectPopUp");
		return mv;
	}

	@RequestMapping(value = "/project/add", method = RequestMethod.POST)
	@ResponseBody
	public String addProject(@ModelAttribute("project") ProjectBO project) {
		String message = "";
		if (project.getId() == 0) {
			this.projectService.addProject(project);
			message = project.getName() + " saved successfully.";
		} else {
			this.projectService.updateProject(project);
			message = project.getName() + " updated successfully.";
		}
		return message;
	}

	@RequestMapping("/project/update/{id}")
	public ModelAndView updateProject(@PathVariable("id") int id) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("projectPopUp");
		ProjectBO pro = this.projectService.getProjectById(id);
		mv.addObject("project", pro);
		return mv;
	}

	@RequestMapping("/project/delete/{id}")
	public String deleteProject(@PathVariable("id") int id) {
		this.projectService.removeProject(id);
		return "redirect:/projects";
	}
	
	@RequestMapping(value = "project/carousel")
	public String index() {
		return "carousel";
	}
}
