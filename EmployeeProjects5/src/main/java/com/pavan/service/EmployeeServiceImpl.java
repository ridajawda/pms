package com.pavan.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pavan.dao.EmployeeDAO;
import com.pavan.model.EmployeeBO;

@Service
public class EmployeeServiceImpl implements EmployeeService {
	
	private EmployeeDAO employeeDAO;

	public void setEmployeeDAO(EmployeeDAO employeeDAO) {
		this.employeeDAO = employeeDAO;
	}

	@Override
	@Transactional
	public void addEmployee(EmployeeBO p) {
		this.employeeDAO.addEmployee(p);
	}

	@Override
	@Transactional
	public void updateEmployee(EmployeeBO p) {
		this.employeeDAO.updateEmployee(p);
	}

	@Override
	@Transactional
	public List<EmployeeBO> listEmployees() {
		return this.employeeDAO.listEmployees();
	}

	@Override
	@Transactional
	public EmployeeBO getEmployeeById(int id) {
		return this.employeeDAO.getEmployeeById(id);
	}

	@Override
	@Transactional
	public void deleteEmployee(int id) {
		this.employeeDAO.deleteEmployee(id);
	}

}
