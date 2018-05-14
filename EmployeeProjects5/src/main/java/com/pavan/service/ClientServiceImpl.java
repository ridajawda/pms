package com.pavan.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pavan.dao.ClientDAO;
import com.pavan.model.ClientBO;

@Service
public class ClientServiceImpl implements ClientService {
	
	private ClientDAO clientDAO;

	public void setClientDAO(ClientDAO clientDAO) {
		this.clientDAO = clientDAO;
	}

	@Override
	@Transactional
	public void addClient(ClientBO p) {
		this.clientDAO.addClient(p);
	}

	@Override
	@Transactional
	public void updateClient(ClientBO p) {
		this.clientDAO.updateClient(p);
	}

	@Override
	@Transactional
	public List<ClientBO> listClients() {
		return this.clientDAO.listClients();
	}

	@Override
	@Transactional
	public ClientBO getClientById(int id) {
		return this.clientDAO.getClientById(id);
	}

	@Override
	@Transactional
	public void deleteClient(int id) {
		this.clientDAO.deleteClient(id);
	}

}
