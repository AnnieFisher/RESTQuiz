package data;

import java.util.Collection;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.annotation.Transactional;

import entities.Quizes;
import entities.Scores;
import entities.Users;

@Transactional
public class UsersDAO {
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	@PersistenceContext
	private EntityManager em;

	public List<Users> index() {
		String query = "Select u from Users u";
		return em.createQuery(query, Users.class).getResultList();
	}

	public Users show(int id) {
		return em.find(Users.class, id);
	}

	public void create(Users user) {
		String rawPassword = user.getPassword();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		user.setPassword(encodedPassword);
		em.persist(user);
		em.flush();
	}

	public Users update(int id, Users user) {
		String rawPassword = user.getPassword();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		user.setPassword(encodedPassword);
		Users editUser = em.find(Users.class, id);
		editUser.setUsername(user.getUsername());
		editUser.setPassword(user.getPassword());
		em.merge(editUser);
		return editUser;
	}

	public void destroy(int id) {
		Users user = em.find(Users.class, id);
		em.remove(user);
	}

	
	public Collection<Scores> getScoresForUserById(int id) {
		Users user = null;
		try {
			user = em.find(Users.class, id);
		} catch(Exception e) {
			e.printStackTrace();
		}
		if (user != null) {
			return user.getScores();
		}
		return null;
	}
	
}
