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

import com.pavan.model.ClientBO;
import com.pavan.model.ProjectBO;
import com.pavan.service.ClientService;
import com.pavan.service.ProjectService;

@Controller
public class ClientProjectController {
	private ClientService clientService;

	@Autowired(required = true)
	@Qualifier(value = "clientService")
	public void setClientService(ClientService ps) {
		this.clientService = ps;
	}

	private ProjectService projectService;

	@Autowired(required = true)
	@Qualifier(value = "projectService")
	public void setProjectService(ProjectService ps) {
		this.projectService = ps;
	}

	@RequestMapping(value = "/clientProjects", method = RequestMethod.GET)
	public String clientProjects(Model model) {
		model.addAttribute("listClients", this.clientService.listClients());
		model.addAttribute("listProjects", this.projectService.listProjects());
		return "clientProjects";
	}

	@RequestMapping(value = "/client/projects/add", method = RequestMethod.POST)
	public String addClientProject(@RequestParam("clientId") int clientId,
			@RequestParam("projects") Set<Integer> projectIds) {
		ClientBO emp = this.clientService.getClientById(clientId);
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
		this.clientService.updateClient(emp);

		return "redirect:/clientProjects";

	}

	@RequestMapping(value = "/project/clients", method = RequestMethod.GET)
	public ModelAndView projectClients(
			@RequestParam(value = "project", required = false, defaultValue = "0") int project) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("projectClients");
		mv.addObject("projectsList", this.projectService.listProjects());
		if (project != 0) {
			mv.addObject("project", this.projectService.getProjectById(project));
			mv.addObject("projectClientsList", this.projectService.getProjectById(project).getClients());
			mv.setViewName("projectClientsInner");
		}
		return mv;
	}

	@RequestMapping(value = "/project/client/delete", method = RequestMethod.GET)
	@ResponseBody
	public String deleteProjectClient(@RequestParam("project") int project, @RequestParam("client") int client) {
		String message = "";
		ClientBO emp = this.clientService.getClientById(client);
		ProjectBO pro = this.projectService.getProjectById(project);
		Set<ProjectBO> projects = new LinkedHashSet<ProjectBO>();
		for (ProjectBO p : emp.getProjects()) {
			if (p.getId() != project) {
				projects.add(p);
			}
		}
		emp.setProjects(projects);
		this.clientService.updateClient(emp);
		message = emp.getName() +  " successfully removed from project " + pro.getName();
		return message;
	}

}