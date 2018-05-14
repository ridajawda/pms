package com.pavan.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pavan.dao.ConsultantDAO;
import com.pavan.model.ConsultantBO;

@Service
public class ConsultantServiceImpl implements ConsultantService {
	
	private ConsultantDAO consultantDAO;

	public void setConsultantDAO(ConsultantDAO consultantDAO) {
		this.consultantDAO = consultantDAO;
	}

	@Override
	@Transactional
	public void addConsultant(ConsultantBO p) {
		this.consultantDAO.addConsultant(p);
	}

	@Override
	@Transactional
	public void updateConsultant(ConsultantBO p) {
		this.consultantDAO.updateConsultant(p);
	}

	@Override
	@Transactional
	public List<ConsultantBO> listConsultants() {
		return this.consultantDAO.listConsultants();
	}

	@Override
	@Transactional
	public ConsultantBO getConsultantById(int id) {
		return this.consultantDAO.getConsultantById(id);
	}

	@Override
	@Transactional
	public void deleteConsultant(int id) {
		this.consultantDAO.deleteConsultant(id);
	}

}
