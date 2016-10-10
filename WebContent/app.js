addEventListener('load', function(){
    console.log('LOADED');
});

	var table = document.createElement('table');
	table.id = 'table';

	var thead = document.createElement('thead');
	thead.id = "thead";

	table.appendChild(thead);

	var tbody = document.createElement('tbody');
		tbody.id = "tbody"
	var tr1 = document.createElement('tr');
		tr1.id = "row1";
	var quizName = document.createElement('td');
		quizName.id="quizName";
		quizName.textContent = "Quiz Name";
	var view = document.createElement('td');
		view.id="view";
		view.textContent = "View";
		tr1.appendChild(quizName);
		tr1.appendChild(view);
		tbody.appendChild(tr1);

		var xhr = new XMLHttpRequest();
		console.log(xhr.readyState);  
		xhr.open('GET', 'api/quizes');  
		console.log(xhr.readyState);

		xhr.onreadystatechange = function(){
			console.log(xhr.readyState);

			if (xhr.status < 400 && xhr.readyState === 4) {

				var data = JSON.parse(xhr.responseText);
				console.log(data);


				data.forEach(function(value, index, array){
					var tr = document.createElement('tr');
					var td1 = document.createElement('td');
						td1.textContent = value.name;
					var td2 = document.createElement('td');
					var td2b = document.createElement('button');
					var take= document.createElement('button');
						take.setAttribute("id", value.id);
						take.textContent = "Take Quiz"
					var form= document.createElement('button');
						form.textContent = "Create Quiz";
					var edit= document.createElement('button');
						edit.textContent = "Edit";
						edit.setAttribute("id", value.id);
					var remove=document.createElement('button');
						remove.setAttribute("id", value.id);
						remove.textContent = "Remove"
			
						console.log(value);
						tr.appendChild(td1);
						tr.appendChild(td2);
						tr.appendChild(td2b);
						tr.appendChild(take);
						tr.appendChild(form);
						tr.appendChild(edit);
						tr.appendChild(remove);
						tbody.appendChild(tr);
						console.log(value.id);
    
     	
						take.addEventListener('click', function(e){

							table.remove();
							var id = e.target.id;
							var xhr = new XMLHttpRequest();
							console.log(xhr.readyState); 
							xhr.open('GET', 'api/quizes/' +id); 
							console.log(xhr.readyState);
							xhr.onreadystatechange = function(){
								console.log(xhr.readyState);
								var correct = [];
    		
								if (xhr.status < 400 && xhr.readyState === 4) {
    			
									var dataQuiz = JSON.parse(xhr.responseText);
//									console.log(dataQuiz);
//									console.log(dataQuiz.id);
//									console.log(dataQuiz.name);
//									console.log(dataQuiz.questions);
    		          		   
									var form3 = document.createElement('form');  
									var form2 = document.createElement('form'); 
		   
									dataQuiz.questions.forEach(function(value,index,array){
    		    	  
										var question = document.createElement('input'); 
											question.value= value.questionsText;
										form2.appendChild(question);
	    	     	    
										value.answers.forEach(function(value,index,array){
	    	     	    	
											var answerText = document.createElement('input');
												answerText.value = value.answerText;
    		    	  			
											var answer = document.createElement('input');
												answer.value = value.correct;
												answer.setAttribute("type","radio");
    		    	  		
											answer.addEventListener('click', function(e){
												correct.push(value.correct);
												console.log(correct);
											}); //end answer event listener
    		    	  		
										form2.appendChild(answer);
										form2.appendChild(answerText);
    		    	  		

										document.body.appendChild(form2);
    		    	  
										}) //end of answers forEach
    		    	 
    		    	  	
								}); //end of questions forEach
    		    
    		    
								var submitAnswers = document.createElement('button');
								submitAnswers.textContent = "Submit";
								form3.appendChild(submitAnswers);
								document.body.appendChild(form3);
	  			
	  		
  				
								submitAnswers.addEventListener('click', function(e){
//								
									var counter = 0;
									correct.forEach(function(value, index, array){
	  					
										if (value === true) {
											counter ++;
								}
	 	
									}); //end of correct forEach
	  			
									console.log(dataQuiz.id);
									var totalQuestions = dataQuiz.questions.length;
									var totalCorrect = counter;
									var totalScore = totalCorrect/totalQuestions;
									var percent = parseInt(totalScore * 100);
	  						
									var obj = {
										value : percent,
									};
									var jsonString = JSON.stringify(obj);

									var newXhr = new XMLHttpRequest();
									newXhr.open("POST", "api/quizes/" + dataQuiz.id+ "/scores/");

									newXhr.onreadystatechange = function() {
										if (newXhr.readyState === 4 && newXhr.status < 400) {
											console.log(newXhr.status);
											console.log(newXhr.responseText);
										}
										if (newXhr.readyState === 4 && newXhr.status >= 400) {
											console.error(newXhr.status + ': '
													+ newXhr.responseText);
										}
									};
							newXhr.send(jsonString);

	  				
							prompt("Your Score is: "+percent +" %");
	  				
	  			}); //end of submit event listener
	  			
	  		
    		  } else if(xhr.status >= 400 && xhr.readyState === 4) {
    		       console.error('ERROR!!!!');
    		   }
    		};

    		xhr.send(null);
    		
     	}); //end of takebtn listener
     	
     	
     	
     	td2b.addEventListener('click', function(e){
     		e.target.previousSibling.textContent = e.target.previousSibling.previousSibling.textContent;
     		console.log("Quiz Name: " + value.name);
     		console.log(value); 	
     	}); //end of viewbtn listener
     	
     	remove.addEventListener('click', function(e){
     		var id = e.target.id;
     		
     		var xhr = new XMLHttpRequest();
     		xhr.open('DELETE', 'api/quizes/' + id);
     		xhr.onreadystatechange = function() {
     			if (xhr.readyState === 4 && xhr.status < 400) {
     				console.log(xhr.status);
     				console.log(xhr.responseText);
     				
     			}	
     			if (xhr.readyState === 4 && xhr.status >= 400) {
     				console.error(xhr.status + ': ' + xhr.responseText);
     			}
    		    
     		};
     		var response = confirm("Confirm Delete");
     		if (response) {
     			xhr.send(null);
     			location.reload();
     		}
     	});  //end of remove listener
 
     	
     	
     	edit.addEventListener('click', function(e){
     		table.remove();
     		var id = e.target.id;
     		console.log(id);
     		var form = document.createElement('form');
     		var input = document.createElement('input');
     			input.type = "text";
     			input.value = e.target.previousSibling.previousSibling
     			.previousSibling.previousSibling.previousSibling.textContent;
     			input.id = "Quiz_Name";
     		var submit = document.createElement('input');
     			submit.type = "submit";
     			submit.value = "Submit";
		
     			form.appendChild(input);
     			form.appendChild(submit);
		
     			document.body.appendChild(form);
        
     			submit.addEventListener('click',function(e){
    		
     				var editQuiz ={name: input.value};
     				var jsonString = JSON.stringify(editQuiz);
     				var xhr = new XMLHttpRequest();
     				xhr.open('PUT', 'api/quizes/' + id);
     				xhr.onreadystatechange = function() {
     					if (xhr.readyState === 4 && xhr.status < 400) {
     						console.log(xhr.status);
     						console.log(xhr.responseText);
     					}
     					if (xhr.readyState === 4 && xhr.status >= 400) {
     						console.error(xhr.status + ': ' + xhr.responseText);
     					}
    		    
     				};
     				xhr.send(jsonString);
     			}); //end of submit event listener
     	
     		}); //end of edit event listener
    	
	
   
     		form.addEventListener('click', function(e){
     			table.remove();
     			var form = document.createElement('form');
     			var input = document.createElement('input');
     				input.type = "text";
     				input.value = "Quiz_Name";
     				input.id = "Quiz_Name";
     			var submit = document.createElement('input');
     				submit.type = "submit";
     				submit.value = "Submit";
     			form.appendChild(input);
     			form.appendChild(submit);
    		
     			document.body.appendChild(form);
   	
    
     				submit.addEventListener('click',function(e){
     					form.remove();
     					var newQuiz ={name: input.value};
     					var jsonString = JSON.stringify(newQuiz);
     					var xhr = new XMLHttpRequest();
     					xhr.open('POST', 'api/quizes');
     					xhr.onreadystatechange = function() {
     						if (xhr.readyState === 4 && xhr.status < 400) {
     							console.log(xhr.status);
     							console.log(xhr.responseText);
     						}
     						if (xhr.readyState === 4 && xhr.status >= 400) {
     							console.error(xhr.status + ': ' + xhr.responseText);
     						}
     					};

     					xhr.send(jsonString);
    
     				}); //end of remove-submit event listener
    
     		}); //end of form event listener
    
		}); //end of forEach
    
			table.appendChild(tbody);
			document.body.appendChild(table);
  		
	};
	if(xhr.status >= 400 && xhr.readyState === 4) {
     console.error('ERROR!!!!');
	};
};
	
xhr.send(null);

