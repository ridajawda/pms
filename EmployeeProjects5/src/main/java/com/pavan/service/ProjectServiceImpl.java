package com.pavan.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pavan.dao.ProjectDAO;
import com.pavan.model.ProjectBO;

@Service
public class ProjectServiceImpl implements ProjectService {
	
	private ProjectDAO projectDAO;

	public void setProjectDAO(ProjectDAO projectDAO) {
		this.projectDAO = projectDAO;
	}

	@Override
	@Transactional
	public void addProject(ProjectBO p) {
		this.projectDAO.addProject(p);
	}

	@Override
	@Transactional
	public void updateProject(ProjectBO p) {
		this.projectDAO.updateProject(p);
	}

	@Override
	@Transactional
	public List<ProjectBO> listProjects() {
		return this.projectDAO.listProjects();
	}

	@Override
	@Transactional
	public ProjectBO getProjectById(int id) {
		return this.projectDAO.getProjectById(id);
	}

	@Override
	@Transactional
	public void removeProject(int id) {
		this.projectDAO.removeProject(id);
	}

}
