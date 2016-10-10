package controllers;

import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;

import data.UsersDAO;
import entities.Scores;
import entities.Users;

@RestController
//@RequestMapping("users")
public class UsersController {

	@Autowired
	private UsersDAO usersDAO;

//	@RequestMapping(path = "ping", method = RequestMethod.GET)
//	public String ping() {
//		return "pong";
//	}
	@RequestMapping(path = "users", method = RequestMethod.GET)
	public List<Users> index() {
		return usersDAO.index();
	}
	
	@RequestMapping(path="users/{id}",method=RequestMethod.GET)
	public Users show(@PathVariable int id) {
		return usersDAO.show(id);
	}
	
	@RequestMapping(path= "users", method = RequestMethod.POST)
	public void create(@RequestBody String usersJSON) {
		ObjectMapper mapper = new ObjectMapper();
		Users user = null;
		try {
			user = mapper.readValue(usersJSON, Users.class);
		}catch (Exception e) {
			e.printStackTrace();
		}
		usersDAO.create(user);
	}
	
	@RequestMapping(path= "users/{id}", method = RequestMethod.PUT)
		public void update(@PathVariable int id, @RequestBody String usersJSON) {
		ObjectMapper mapper = new ObjectMapper();
		Users user = null;
		try {
			user = mapper.readValue(usersJSON, Users.class);
		}catch (Exception e) {
			e.printStackTrace();
		}
		usersDAO.update(id, user);
	}
	
	@RequestMapping(path="users/{id}",method=RequestMethod.DELETE)
	public void destroy(@PathVariable int id) {
		usersDAO.destroy(id);
	}

	@RequestMapping(path = "users/{id}/scores", method = RequestMethod.GET)
	public Collection<Scores> getScoresForUserById(@PathVariable("id") int id) {
		return usersDAO.getScoresForUserById(id);
	}
	
}
