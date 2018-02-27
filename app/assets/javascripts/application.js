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

    convertFormToAjaxSubmit();
});

function convertFormToAjaxSubmit() {
    $('form').submit(function() {
        var since = new Date().toISOString();
        var valuesToSubmit = $(this).serialize();
        $.ajax({
            type: "POST",
            url: $(this).attr('action'),
            data: valuesToSubmit,
            dataType: "JSON"
        }).success(function(res, status, xhr){
            pollForList(xhr.getResponseHeader("Location"), since);
        });
        return false;
    });
}

function pollForList(location, since) {
    $.ajax({
        url: location,
        type: "GET",
        headers: {"If-Modified-Since": since},
        contentType: 'application/json; charset=utf-8',
        success: function(res, status, xhr) {
            if (xhr.status === 200) {
                $("div#tasks_list").html(res.html);
                $('#name').val('');
                $('#name').focus();
            } else {
                pollForList(location, since);
            }
        }
    });
}
