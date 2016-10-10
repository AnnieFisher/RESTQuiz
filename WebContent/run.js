window.addEventListener('load', function() {
  restApp.ajax("GET", "api/quizes", function(request) {
    if (request.readyState === 4 && request.status < 400) {
      var data = JSON.parse(request.responseText);
      restApp.tableBuilder(data,"data-table",["Quiz Name","View","Take","Edit","Delete",]);
    }
  });
});
