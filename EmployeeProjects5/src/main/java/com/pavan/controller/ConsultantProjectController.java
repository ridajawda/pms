package com.pavan.controller;

import java.util.LinkedHashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pavan.model.ConsultantBO;
import com.pavan.model.ProjectBO;
import com.pavan.service.ConsultantService;
import com.pavan.service.ProjectService;

@Controller
public class ConsultantProjectController {
	private ConsultantService consultantService;

	@Autowired(required = true)
	@Qualifier(value = "consultantService")
	public void setConsultantService(ConsultantService ps) {
		this.consultantService = ps;
	}

	private ProjectService projectService;

	@Autowired(required = true)
	@Qualifier(value = "projectService")
	public void setProjectService(ProjectService ps) {
		this.projectService = ps;
	}

	@RequestMapping(value = "/consultantProjects", method = RequestMethod.GET)
	public String consultantProjects(Model model) {
		model.addAttribute("listConsultants", this.consultantService.listConsultants());
		model.addAttribute("listProjects", this.projectService.listProjects());
		return "consultantProjects";
	}

	@RequestMapping(value = "/consultant/projects/add", method = RequestMethod.POST)
	public String addConsultantProject(@RequestParam("consultantId") int consultantId,
			@RequestParam("projects") Set<Integer> projectIds) {
		ConsultantBO emp = this.consultantService.getConsultantById(consultantId);
		Set<ProjectBO> projects = new LinkedHashSet<ProjectBO>();
		if (emp.getProjects() != null && emp.getProjects().size() > 0) {
			for (ProjectBO pro : emp.getProjects()) {
				projectIds.add(pro.getId());
			}
		}
		for (Integer pId : projectIds) {
			ProjectBO p = this.projectService.getProjectById(pId);
			projects.add(p);
		}
		emp.setProjects(projects);
		this.consultantService.updateConsultant(emp);

		return "redirect:/consultantProjects";

	}

	@RequestMapping(value = "/project/consultants", method = RequestMethod.GET)
	public ModelAndView projectConsultants(
			@RequestParam(value = "project", required = false, defaultValue = "0") int project) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("projectConsultants");
		mv.addObject("projectsList", this.projectService.listProjects());
		if (project != 0) {
			mv.addObject("project", this.projectService.getProjectById(project));
			mv.addObject("projectConsultantsList", this.projectService.getProjectById(project).getConsultants());
			mv.setViewName("projectConsultantsInner");
		}
		return mv;
	}

	@RequestMapping(value = "/project/consultant/delete", method = RequestMethod.GET)
	@ResponseBody
	public String deleteProjectConsultant(@RequestParam("project") int project, @RequestParam("consultant") int consultant) {
		String message = "";
		ConsultantBO emp = this.consultantService.getConsultantById(consultant);
		ProjectBO pro = this.projectService.getProjectById(project);
		Set<ProjectBO> projects = new LinkedHashSet<ProjectBO>();
		for (ProjectBO p : emp.getProjects()) {
			if (p.getId() != project) {
				projects.add(p);
			}
		}
		emp.setProjects(projects);
		this.consultantService.updateConsultant(emp);
		message = emp.getName() +  " successfully removed from project " + pro.getName();
		return message;
	}

}