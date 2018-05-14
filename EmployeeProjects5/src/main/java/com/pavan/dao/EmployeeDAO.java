package com.pavan.dao;

import java.util.List;

import com.pavan.model.EmployeeBO;

public interface EmployeeDAO {

	public void addEmployee(EmployeeBO p);
	public void updateEmployee(EmployeeBO p);
	public List<EmployeeBO> listEmployees();
	public EmployeeBO getEmployeeById(int id);
	public void deleteEmployee(int id);
}
