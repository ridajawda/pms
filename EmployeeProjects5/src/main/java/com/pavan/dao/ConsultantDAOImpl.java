package com.pavan.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.pavan.model.ConsultantBO;

@Repository
public class ConsultantDAOImpl implements ConsultantDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(ConsultantDAOImpl.class);

	private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sf){
		this.sessionFactory = sf;
	}

	@Override
	public void addConsultant(ConsultantBO p) {
		Session session = this.sessionFactory.getCurrentSession();
		session.persist(p);
		logger.info("Consultant saved successfully, Consultant Details="+p);
	}

	@Override
	public void updateConsultant(ConsultantBO p) {
		Session session = this.sessionFactory.getCurrentSession();
		session.update(p);
		logger.info("Consultant updated successfully, Consultant Details="+p);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ConsultantBO> listConsultants() {
		Session session = this.sessionFactory.getCurrentSession();
		List<ConsultantBO> consultantsList = session.createQuery("from ConsultantBO").list();
		for(ConsultantBO p : consultantsList){
			logger.info("Consultant List::"+p);
		}
		return consultantsList;
	}

	@Override
	public ConsultantBO getConsultantById(int id) {
		Session session = this.sessionFactory.getCurrentSession();		
		ConsultantBO p = (ConsultantBO) session.load(ConsultantBO.class, new Integer(id));
		logger.info("Consultant loaded successfully, Consultant details="+p);
		return p;
	}

	@Override
	public void deleteConsultant(int id) {
		Session session = this.sessionFactory.getCurrentSession();
		ConsultantBO p = (ConsultantBO) session.load(ConsultantBO.class, new Integer(id));
		if(null != p){
			session.delete(p);
		}
		logger.info("Consultant deleted successfully, Consultant details="+p);
	}

}
