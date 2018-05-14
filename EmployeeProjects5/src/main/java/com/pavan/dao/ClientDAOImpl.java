package com.pavan.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.pavan.model.ClientBO;

@Repository
public class ClientDAOImpl implements ClientDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(ClientDAOImpl.class);

	private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sf){
		this.sessionFactory = sf;
	}

	@Override
	public void addClient(ClientBO p) {
		Session session = this.sessionFactory.getCurrentSession();
		session.persist(p);
		logger.info("Client saved successfully, Client Details="+p);
	}

	@Override
	public void updateClient(ClientBO p) {
		Session session = this.sessionFactory.getCurrentSession();
		session.update(p);
		logger.info("Client updated successfully, Client Details="+p);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ClientBO> listClients() {
		Session session = this.sessionFactory.getCurrentSession();
		List<ClientBO> clientsList = session.createQuery("from ClientBO").list();
		for(ClientBO p : clientsList){
			logger.info("Client List::"+p);
		}
		return clientsList;
	}

	@Override
	public ClientBO getClientById(int id) {
		Session session = this.sessionFactory.getCurrentSession();		
		ClientBO p = (ClientBO) session.load(ClientBO.class, new Integer(id));
		logger.info("Client loaded successfully, Client details="+p);
		return p;
	}

	@Override
	public void deleteClient(int id) {
		Session session = this.sessionFactory.getCurrentSession();
		ClientBO p = (ClientBO) session.load(ClientBO.class, new Integer(id));
		if(null != p){
			session.delete(p);
		}
		logger.info("Client deleted successfully, Client details="+p);
	}

}
