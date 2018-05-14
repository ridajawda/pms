package com.pavan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pavan.model.EmpIoyeeInfoBO;
import com.pavan.model.EmployeeBO;
import com.pavan.service.EmployeeService;

@Controller
public class EmployeeController {
	@Autowired
	private EmployeeService employeeService;

	@RequestMapping(value = "")
	public String index() {
		return "index";
	}

	@RequestMapping(value = "/employees", method = RequestMethod.GET)
	public ModelAndView employees() {
		ModelAndView mv = new ModelAndView();
		//mv.addObject("employee", new EmployeeBO());
		mv.addObject("employees", this.employeeService.listEmployees());
		mv.setViewName("employee");
		return mv;
	}

	@RequestMapping("/employee/showEmpPopup")
	public ModelAndView showEmpPopup() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("employee", new EmployeeBO());
		mv.addObject("employees", this.employeeService.listEmployees());
		mv.setViewName("employeePopUp");
		return mv;
	}

	@RequestMapping(value = "/employee/add", method = RequestMethod.POST)
	@ResponseBody
	public String addEmployee(@ModelAttribute("employee") EmployeeBO employee,
			@RequestParam(value = "managerId", required = false, defaultValue = "0") int managerId) {
		String message = "";
		if (managerId != 0) {
			employee.setManager(employeeService.getEmployeeById(managerId));
		}
		if (employee.getId() == 0) {
			this.employeeService.addEmployee(employee);
			message = employee.getFirstName() + " " + employee.getLastName() + " saved successfully.";
		} else {
			this.employeeService.updateEmployee(employee);
			message = employee.getFirstName() + " " + employee.getLastName() + " updated successfully.";
		}
		return message;
	}

	@RequestMapping("/employee/update/{id}")
	public ModelAndView updateEmployee(@PathVariable("id") int id) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("employeePopUp");
		EmployeeBO emp = this.employeeService.getEmployeeById(id);
		mv.addObject("employee", emp);
		mv.addObject("employees", this.employeeService.listEmployees());
		return mv;
	}

	@RequestMapping("/employee/delete/{id}")
	public String deleteEmployee(@PathVariable("id") int id) {
		this.employeeService.deleteEmployee(id);
		return "redirect:/employees";
	}

	@RequestMapping("/employee/showEmpInfoPopup")
	public ModelAndView showEmpInfoPopup(
			@RequestParam(value = "employeeId", required = false, defaultValue = "0") int employeeId) {
		ModelAndView mv = new ModelAndView();
		EmployeeBO emp = null;
		if (employeeId != 0) {
			emp = this.employeeService.getEmployeeById(employeeId);
			mv.addObject("employee", emp);
		}
		if (emp != null && emp.getEmpInfo() != null && emp.getEmpInfo().getId() > 0) {
			mv.addObject("empInfo", emp.getEmpInfo());
		} else {
			mv.addObject("empInfo", new EmpIoyeeInfoBO());
		}
		mv.setViewName("employeeInfoPopUp");
		return mv;
	}

	@RequestMapping(value = "/employee/info/add", method = RequestMethod.POST)
	@ResponseBody
	public String addEmployeeInfo(EmpIoyeeInfoBO empInfo,
			@RequestParam(value = "employeeId", required = false, defaultValue = "0") int employeeId) {
		String message = "";
		EmployeeBO employee = this.employeeService.getEmployeeById(employeeId);
		employee.setEmpInfo(empInfo);
		this.employeeService.updateEmployee(employee);
		message = employee.getFirstName() + " " + employee.getLastName() + " profile saved successfully.";
		return message;
	}
}