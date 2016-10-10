package data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.transaction.annotation.Transactional;

import entities.Questions;
import entities.Quizes;
import entities.Scores;
import entities.Users;

@Transactional
public class QuizesDAO {

	@PersistenceContext
	private EntityManager em;
	
	public List<Quizes> index() {
		String query = "Select q from Quizes q";
		return em.createQuery(query, Quizes.class).getResultList();
	}
	public Quizes show(int id) {
		return em.find(Quizes.class, id);
	}
	public List<Scores> showScores(int id) {
		String query= "Select s from Scores s where s.id_Quizes = ?1";
		List<Scores> results = em.createQuery(query, Scores.class)
				.setParameter(1,id).getResultList();
		return results;
	}
	public List<Questions> showQuestions(int id) {
		String query= "Select q from Questions q where q.id_Questions = ?1";
		List<Questions> results = em.createQuery(query, Questions.class)
				.setParameter(1,id).getResultList();
		return results;
	}
	
	public void create(Quizes quiz){
		em.persist(quiz);
		em.flush();
	}
	public Quizes update(int id, Quizes quiz) {
		Quizes managedQuiz = em.find(Quizes.class, id);
		managedQuiz.setName(quiz.getName());
		em.merge(managedQuiz);
		return managedQuiz;
	}
	public void createQuestions(int id, Questions question){
		Quizes quiz = em.find(Quizes.class, id);
		question.setQuiz(quiz);
		em.persist(question);
		em.flush();
	}

	public void destroy(int id) {
		Quizes quiz = em.find(Quizes.class, id);
		em.remove(quiz);
	}
	public void destroyQuestion(int id) {
		Questions question = em.find(Questions.class, id);
		em.remove(question);
	}

	public void createScore(int id, Scores score) {
		Quizes quiz = em.find(Quizes.class, id);
		score.setQuiz(quiz);
		Users user = em.find(Users.class, 1);
		score.setUser(user);
		em.persist(score);
		em.flush();
	}
}
