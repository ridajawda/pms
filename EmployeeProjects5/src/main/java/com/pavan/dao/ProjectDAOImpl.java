package com.pavan.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.pavan.model.ProjectBO;

@Repository
public class ProjectDAOImpl implements ProjectDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectDAOImpl.class);

	private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sf){
		this.sessionFactory = sf;
	}

	@Override
	public void addProject(ProjectBO p) {
		Session session = this.sessionFactory.getCurrentSession();
		session.persist(p);
		logger.info("Project saved successfully, Project Details="+p);
	}

	@Override
	public void updateProject(ProjectBO p) {
		Session session = this.sessionFactory.getCurrentSession();
		session.update(p);
		logger.info("Project updated successfully, Project Details="+p);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ProjectBO> listProjects() {
		Session session = this.sessionFactory.getCurrentSession();
		List<ProjectBO> projectsList = session.createQuery("from ProjectBO").list();
		for(ProjectBO p : projectsList){
			logger.info("Project List::"+p);
		}
		return projectsList;
	}

	@Override
	public ProjectBO getProjectById(int id) {
		Session session = this.sessionFactory.getCurrentSession();		
		ProjectBO p = (ProjectBO) session.load(ProjectBO.class, new Integer(id));
		logger.info("Project loaded successfully, Project details="+p);
		return p;
	}

	@Override
	public void removeProject(int id) {
		Session session = this.sessionFactory.getCurrentSession();
		ProjectBO p = (ProjectBO) session.load(ProjectBO.class, new Integer(id));
		if(null != p){
			session.delete(p);
		}
		logger.info("Project deleted successfully, Project details="+p);
	}

}
