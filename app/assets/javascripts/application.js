// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .


$(document).ready(function() {
  $('#name').focus();

  var submitTime;

  $("form#add-task")
    .on("ajax:before", function() {
      submitTime = new Date();
    })

    .on("ajax:success", function(e, body, status, xhr) {
      var location = xhr.getResponseHeader("Location");

      console.log("getting list | " + location + " | " + submitTime.toISOString());
      getList(location, submitTime, function(list) {
        $("#tasks").html(list);

        $("form#add-task").find("input[name=name]")
          .val("")
          .focus();
      });
    });
});

function getList(location, ifModifiedSince, callback) {
  $.ajax({
    url: location,
    type: "GET",
    headers: { "If-Modified-Since": ifModifiedSince.toISOString() },
    contentType: 'application/json; charset=utf-8',
    success: function(body, status, xhr) {
      if (xhr.status === 200) {
        callback(body);
      } else {
        getList(location, ifModifiedSince, callback);
      }
    }
  });
}
