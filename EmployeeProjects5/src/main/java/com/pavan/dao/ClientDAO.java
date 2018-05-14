package com.pavan.dao;

import java.util.List;

import com.pavan.model.ClientBO;

public interface ClientDAO {

	public void addClient(ClientBO p);
	public void updateClient(ClientBO p);
	public List<ClientBO> listClients();
	public ClientBO getClientById(int id);
	public void deleteClient(int id);
}
