$(function(){
	$('.hmenu').click(function(){
		$('#category_menu').toggle(300, function(){});
		$('.hmenu div').toggleClass('active');
	});
});