var BbnLoading = {};
BbnLoading.prepend = function(tag, ele) { var x =document.getElementsByTagName(tag)[0]; x.insertBefore(ele ,x.children[0]); }
BbnLoading.createModalDiv = function(){
	var body = document.querySelector("body");
	var div = document.createElement("div");
	div.className = "bbnModalLoading";
	BbnLoading.prepend('body',div);
}
BbnLoading.removeModalDiv = function(){
	setTimeout(function(){
		var modalLoading = document.querySelector(".bbnModalLoading");
		modalLoading.className = "bbnModalNoLoading"
	}, 500);
}
BbnLoading.createSpin = function(){
    BbnLoading.createModalDiv();
	var modalLoading = document.querySelector(".bbnModalLoading");
	var div = document.createElement("div");
	div.className = "spinContent";
	var img = document.createElement("img");
    img.className = "spin";
	modalLoading.appendChild(div);
    div.appendChild(img)
    document.querySelector(".spin").setAttribute('src',"javascripts/img/spinner.gif");
}