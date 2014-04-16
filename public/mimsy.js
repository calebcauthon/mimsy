Mimsy = function() {
  
  function ask(phone_number, fn) {
    $.post('ask', { phone_number: phone_number }, function(data) {
      response = jQuery.parseJSON(data);
      begin_polling(response.filename, function() { fn(response.image_url) });
    });
  };

  function begin_polling(filename, callback) {
    var interval;
    interval = setInterval(function() {
      $.get(filename, function(response) {
        if(response != "0") {
          callback();
          clearInterval(interval);
        }

      })
    }, 2000);
  };

  return {
    ask: ask
  };
}();