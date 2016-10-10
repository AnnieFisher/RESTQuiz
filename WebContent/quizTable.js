
var restApp = (function() {
  var module = {}; // create module obj to use closure and pass functionality


module.tableBuilder = function(dataArr, location) {  //tells tableBuilder function we need an array of data and a location for this function
  var table = document.createElement('table');

  table.appendChild(createTableHeader(dataArr[0]));  //passing create header method with dataArr[0] for the name and appending
  table.appendChild(createTableBody(dataArr));     // passing create body method with entrie data array

  var containerDiv = document.getElementById(location);  // passing location so we can append to something besides document.body
  containerDiv.appendChild(table);
};


var createTableHeader = function(dataObj) {    ////need a data Object for this function
  var thead = document.createElement("thead");
  var headRow = document.createElement("tr");
  for(header in dataObj) {                      // using a for in here to iterate a single object
    var th = document.createElement("th");
        th.textContent = header;
        headRow.appendChild(th);
  }
  thead.appendChild(headRow);
  return thead;
};

var createTableBody = function(dataArr) {        // need a data array for this function
  var tbody = document.createElement("tbody");
  dataArr.forEach(function(data,index,arr){        // using a forEach to iterate the array
    var tr = document.createElement("tr");
      for(property in data) {                        // for in to iterate the data obj within the array
        if(property === "name"){
        		if(Array.isArray(data[property])) {
        			var quetionTextArr =[];
        			data[property].forEach(function(question){
        				questionTextArr.push(question.questionText);
        			})
        			data[property] = questionTextArr.join(": ");
        		}
        		if (typeof data[property]==="object") {
        			var valuesArr = [];
        			for (p in data[property]){
        				valuesArr.push(data[property][p])
        			}
        			data[property] = valuesArr.join(", ");
        		}
       
    	  var td = document.createElement("td");
        td.textContent = data[property];
        tr.appendChild(td);
      }
     }
    tr.appendChild(makeButtonsForTableToView(data));   // pass in makebuttons function with data
    tr.appendChild(makeButtonsForTableToTake(data));
    tr.appendChild(makeButtonsForTableToEdit(data));
    tr.appendChild(makeButtonsForTableToDelete(data));
    tbody.appendChild(tr);
  });
  return tbody;
};

    var makeButtonsForTableToViewUser = function(dataObj) {  // pass in dataObj
      var td = document.createElement("td");
      var viewBtn = document.createElement("button");
      viewBtn.setAttribute("quizName", dataObj.name);
      viewBtn.textContent = "View";

      viewBtn.addEventListener("click", function(e){
        var quizName = e.target.getAttribute("quizName");
        console.console.log(quizName);
        module.ajax("GET","api/quizes", + quizName, function(){
          //do something with data when it comes back
        })
      });
      td.appendChild(viewBtn);
      return td;
    };
    module.ajax = function(method, url, callback, requestBody) {
    	  var xhr = new XMLHttpRequest();
    	  xhr.open(method,url);

    	  if (requestBody) {
    	    xhr.setRequestHeader("Content-type","application/json");
    	  } else {
    	    requestBody = null;
    	  }

    	  xhr.onreadystatechange = function() {
    	    callback(xhr);
    	  };

    	  xhr.send(requestBody);
    	};
    	return module;
  })();
