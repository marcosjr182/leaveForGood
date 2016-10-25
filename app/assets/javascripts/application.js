// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vm.runInNewContext(code, sandbox, options);r/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require chosen-jquery
//= require moment
//= require bootstrap-datetimepicker
//= require turbolinks
//= require_tree .


$(document).on("turbolinks:load", function() { 
  personal_val = $('#donation_personal').val();
  if (personal_val){ 
    $('.btn-donation-type.personal').addClass('active');
  } else {
    $('.btn-donation-type.organization').addClass('active');
  }

	$(".donation_vehicle").click(function(){
		var vehicle = $( this );
		vehicle.addClass('active');
		$('input[name="donation[vehicle]"]').val(vehicle.data('value'))
		$('.donation_vehicle').not(this).each(function(){
	    $(this).removeClass('active');
	  });
	});

	$(".btn-donation-type").click(function(){
		var btn = $( this );
		btn.addClass('active');
		
    input = $('#donation_personal')
    
    if ($(this).hasClass('personal')) {
      input.val('true');
		} else if ($(this).hasClass('organization')) {
			input.val('false');
		}
    console.log($('.btn-donation-type'));
		$('.btn-donation-type').not(this).each(function(){
	    $(this).removeClass('active');
	  });			
		
	});

  $('#pickupStart').datetimepicker({
  	daysOfWeekDisabled: [0, 6],
    enabledHours: [10, 11, 12, 13, 14, 15, 16, 17, 18],
    minDate: moment().add(1,'hours'),
    maxDate: moment().add(15,'days'),
  	icons: {
        time: "fa fa-clock-o",
        date: "fa fa-calendar",
        up: "fa fa-arrow-up",
        down: "fa fa-arrow-down"
    }
  });
  $('#pickupEnd').datetimepicker({
  	daysOfWeekDisabled: [0, 6],
  	enabledHours: [10, 11, 12, 13, 14, 15, 16, 17, 18],
    minDate: moment().add(3,'hours'),
    maxDate: moment().add(15,'days'),
  	icons: {
        time: "fa fa-clock-o",
        date: "fa fa-calendar",
        up: "fa fa-arrow-up", 
        down: "fa fa-arrow-down"
    }
  });

  $('.chosen-select').chosen({
    allow_single_deselect: true,
    no_results_text: 'No results matched',
    width: '200px'
  });
  
});
