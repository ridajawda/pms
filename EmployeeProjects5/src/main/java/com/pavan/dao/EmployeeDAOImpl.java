package com.pavan.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.pavan.model.EmployeeBO;

@Repository
public class EmployeeDAOImpl implements EmployeeDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(EmployeeDAOImpl.class);

	private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sf){
		this.sessionFactory = sf;
	}

	@Override
	public void addEmployee(EmployeeBO p) {
		Session session = this.sessionFactory.getCurrentSession();
		session.persist(p);
		logger.info("Employee saved successfully, Employee Details="+p);
	}

	@Override
	public void updateEmployee(EmployeeBO p) {
		Session session = this.sessionFactory.getCurrentSession();
		session.update(p);
		logger.info("Employee updated successfully, Employee Details="+p);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<EmployeeBO> listEmployees() {
		Session session = this.sessionFactory.getCurrentSession();
		List<EmployeeBO> employeesList = session.createQuery("from EmployeeBO").list();
		for(EmployeeBO p : employeesList){
			logger.info("Employee List::"+p);
		}
		return employeesList;
	}

	@Override
	public EmployeeBO getEmployeeById(int id) {
		Session session = this.sessionFactory.getCurrentSession();		
		EmployeeBO p = (EmployeeBO) session.load(EmployeeBO.class, new Integer(id));
		logger.info("Employee loaded successfully, Employee details="+p);
		return p;
	}

	@Override
	public void deleteEmployee(int id) {
		Session session = this.sessionFactory.getCurrentSession();
		EmployeeBO p = (EmployeeBO) session.load(EmployeeBO.class, new Integer(id));
		if(null != p){
			session.delete(p);
		}
		logger.info("Employee deleted successfully, Employee details="+p);
	}

}
