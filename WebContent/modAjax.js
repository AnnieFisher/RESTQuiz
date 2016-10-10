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
