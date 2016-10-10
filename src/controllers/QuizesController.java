package controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;

import data.QuizesDAO;
import entities.Questions;
import entities.Quizes;
import entities.Scores;
import entities.Users;

@RestController
public class QuizesController {

	@Autowired
	private QuizesDAO quizesDAO;

	@RequestMapping(path = "ping", method = RequestMethod.GET)
	public String ping() {
		return "pong";
	}

	@RequestMapping(path = "quizes", method = RequestMethod.GET)
	public List<Quizes> index() {
		return quizesDAO.index();
	}

	@RequestMapping(path = "quizes/{id}", method = RequestMethod.GET)
	public Quizes show(@PathVariable int id) {
		return quizesDAO.show(id);
	}
	@RequestMapping(path = "quizes/{id}/scores", method = RequestMethod.GET)
	public List<Scores> showScores(@PathVariable int id) {
		return quizesDAO.showScores(id);
	}
	@RequestMapping(path = "quizes/{id}/questions", method = RequestMethod.GET)
	public List<Questions> showQuestions(@PathVariable int id) {
		return quizesDAO.showQuestions(id);
	}

	@RequestMapping(path = "quizes", method = RequestMethod.POST)
	public void create(@RequestBody String quizesJSON) {
		ObjectMapper mapper = new ObjectMapper();
		Quizes quiz = null;
		try {
			quiz = mapper.readValue(quizesJSON, Quizes.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		quizesDAO.create(quiz);
	}

	@RequestMapping(path = "quizes/{id}", method = RequestMethod.PUT)
	public void update(@PathVariable int id, @RequestBody String quizesJSON) {
		ObjectMapper mapper = new ObjectMapper();
		Quizes quiz = null;
		try {
			quiz = mapper.readValue(quizesJSON, Quizes.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		quizesDAO.update(id, quiz);
	}
	
	@RequestMapping(path="quizes/{id}",method=RequestMethod.DELETE)
	public void destroy(@PathVariable int id) {
		quizesDAO.destroy(id);
	}

	@RequestMapping(path = "quizes/{id}/questions", method = RequestMethod.POST)
	public void createQuestions(@RequestBody String QuestionsJSON, @PathVariable int id) {
		ObjectMapper mapper = new ObjectMapper();
		Questions question = null;
		try {
			question = mapper.readValue(QuestionsJSON, Questions.class);
		} catch (Exception e) {
			System.out.println("in catch");
			e.printStackTrace();
		}
		quizesDAO.createQuestions(id, question);
	}
	
	@RequestMapping(path="quizes/{id}/questions/{questionId}",method=RequestMethod.DELETE)
	public void destroyQuestions(@RequestBody String QuestionsJSON,@PathVariable int id) {
		quizesDAO.destroyQuestion(id);
	}
	
	
	@RequestMapping(path = "quizes/{id}/scores/", method = RequestMethod.POST)
	public void showScores(@RequestBody String ScoresJSON, @PathVariable int id) {
		ObjectMapper mapper = new ObjectMapper();
		Scores score = null;
		try {
			score = mapper.readValue(ScoresJSON, Scores.class);
		} catch (Exception e) {
			System.out.println("in catch");
			e.printStackTrace();
		}
		quizesDAO.createScore(id, score);
	}
}
