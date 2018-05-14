package com.pavan.dao;

import java.util.List;

import com.pavan.model.ProjectBO;

public interface ProjectDAO {

	public void addProject(ProjectBO p);
	public void updateProject(ProjectBO p);
	public List<ProjectBO> listProjects();
	public ProjectBO getProjectById(int id);
	public void removeProject(int id);
}
