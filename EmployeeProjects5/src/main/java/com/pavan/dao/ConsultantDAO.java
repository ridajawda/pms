package com.pavan.dao;

import java.util.List;

import com.pavan.model.ConsultantBO;

public interface ConsultantDAO {

	public void addConsultant(ConsultantBO p);
	public void updateConsultant(ConsultantBO p);
	public List<ConsultantBO> listConsultants();
	public ConsultantBO getConsultantById(int id);
	public void deleteConsultant(int id);
}
