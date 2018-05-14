package com.pavan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pavan.model.ClientBO;
import com.pavan.service.ClientService;

@Controller
public class ClientController {
	
	private ClientService clientService;
	
	@Autowired(required = true)
	@Qualifier(value = "clientService")
	public void setClientService(ClientService ps) {
		this.clientService = ps;
	}
	
	@RequestMapping(value = "/clients", method = RequestMethod.GET)
	public ModelAndView clients() {
		ModelAndView mv = new ModelAndView();
		// mv.addObject("client", new ClientBO());
		mv.addObject("clients", this.clientService.listClients());
		mv.setViewName("client");
		return mv;
	}
	
	@RequestMapping("/client/showCliPopup")
	public ModelAndView showEmpPopup() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("client", new ClientBO());
		mv.addObject("clients", this.clientService.listClients());
		mv.setViewName("clientPopUp");
		return mv;
	}

	@RequestMapping(value = "/client/add", method = RequestMethod.POST)
	@ResponseBody
	public String addClient(@ModelAttribute("client") ClientBO client) {
		String message = "";
		if (client.getId() == 0) {
			this.clientService.addClient(client);
			message = client.getName() + " saved successfully.";
		} else {
			this.clientService.updateClient(client);
			message = client.getName() + " updated successfully.";
		}
		return message;
	}

	@RequestMapping("/client/update/{id}")
	public ModelAndView updateClient(@PathVariable("id") int id) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("clientPopUp");
		ClientBO cli = this.clientService.getClientById(id);
		mv.addObject("client", cli);
		mv.addObject("clients", this.clientService.listClients());
		return mv;
	}

	@RequestMapping("/client/delete/{id}")
	public String deleteClient(@PathVariable("id") int id) {
		this.clientService.deleteClient(id);
		return "redirect:/clients";
	}

}