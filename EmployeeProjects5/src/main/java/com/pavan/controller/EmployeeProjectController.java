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

import com.pavan.model.EmployeeBO;
import com.pavan.model.ProjectBO;
import com.pavan.service.EmployeeService;
import com.pavan.service.ProjectService;

@Controller
public class EmployeeProjectController {
	private EmployeeService employeeService;

	@Autowired(required = true)
	@Qualifier(value = "employeeService")
	public void setEmployeeService(EmployeeService ps) {
		this.employeeService = ps;
	}

	private ProjectService projectService;

	@Autowired(required = true)
	@Qualifier(value = "projectService")
	public void setProjectService(ProjectService ps) {
		this.projectService = ps;
	}

	@RequestMapping(value = "/employeeProjects", method = RequestMethod.GET)
	public String employeeProjects(Model model) {
		model.addAttribute("listEmployees", this.employeeService.listEmployees());
		model.addAttribute("listProjects", this.projectService.listProjects());
		return "employeeProjects";
	}

	@RequestMapping(value = "/employee/projects/add", method = RequestMethod.POST)
	public String addEmployeeProject(@RequestParam("employeeId") int employeeId,
			@RequestParam("projects") Set<Integer> projectIds) {
		EmployeeBO emp = this.employeeService.getEmployeeById(employeeId);
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
		this.employeeService.updateEmployee(emp);

		return "redirect:/employeeProjects";

	}

	@RequestMapping(value = "/project/employees", method = RequestMethod.GET)
	public ModelAndView projectEmployees(
			@RequestParam(value = "project", required = false, defaultValue = "0") int project) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("projectEmployees");
		mv.addObject("projectsList", this.projectService.listProjects());
		if (project != 0) {
			mv.addObject("project", this.projectService.getProjectById(project));
			mv.addObject("projectEmployeesList", this.projectService.getProjectById(project).getEmployees());
			mv.addObject("projectClientsList", this.projectService.getProjectById(project).getClients());
			mv.addObject("projectConsultantsList", this.projectService.getProjectById(project).getConsultants());
			mv.setViewName("projectEmployeesInner");
		}
		return mv;
	}

	@RequestMapping(value = "/project/employee/delete", method = RequestMethod.GET)
	@ResponseBody
	public String deleteProjectEmployee(@RequestParam("project") int project, @RequestParam("employee") int employee) {
		String message = "";
		EmployeeBO emp = this.employeeService.getEmployeeById(employee);
		ProjectBO pro = this.projectService.getProjectById(project);
		Set<ProjectBO> projects = new LinkedHashSet<ProjectBO>();
		for (ProjectBO p : emp.getProjects()) {
			if (p.getId() != project) {
				projects.add(p);
			}
		}
		emp.setProjects(projects);
		this.employeeService.updateEmployee(emp);
		message = emp.getFirstName() + " " + emp.getLastName() + " successfully removed from project " + pro.getName();
		return message;
	}

}