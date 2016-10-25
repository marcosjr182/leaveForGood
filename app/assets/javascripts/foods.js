
function renderFood(food){
	html = "<div class='food col-md-3'>\
		 				<div class='col-md-2'>"+ food.qty +"</div><div class='col-md-6'> "+ food.name +"</div></div>";

	$('.food-input').append(html);
}

function addFood(){
	name = $('.add-food > .food-name').val();
	var food = { food: { 'name': name, 'qty':'1', 'food_type':'1' }};
	console.log(food);
	$.post("/foods", food).done(function() {
	  renderFood(food);
	});
}