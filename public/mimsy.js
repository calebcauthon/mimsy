Mimsy = function() {
  
  function ask(phone_number) {
    $.post('ask', { phone_number: phone_number }, function(response) {
      console.log(response);
    });
  }

  return {
    ask: ask
  };
}();