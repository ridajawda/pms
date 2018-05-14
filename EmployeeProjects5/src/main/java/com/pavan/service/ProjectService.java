package com.pavan.service;

import java.util.List;

import com.pavan.model.ProjectBO;

public interface ProjectService {

	public void addProject(ProjectBO p);
	public void updateProject(ProjectBO p);
	public List<ProjectBO> listProjects();
	public ProjectBO getProjectById(int id);
	public void removeProject(int id);
	
}
