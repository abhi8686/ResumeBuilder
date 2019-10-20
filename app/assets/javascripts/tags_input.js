TagsInput = {
	elements: [],
}
TagsInput.init = function(){
	this.inithandler()
}

TagsInput.initHandler = function(){

}

TagsInput.startTags = function(input_el, tags_container){
	
	this.elements[input_el] = [] 
	$(input_el).on("keyup", function(e) {
    if (e.keyCode == 13) {
    	TagsInput.elements[input_el].push($(input_el).val())
    	TagsInput.elements[input_el].push($(input_el).val().replace(/\n/g, ""))
    	TagsInput.updateValues(tags_container, $(input_el).val().replace(/\n/g, ""))
    	$(input_el).val('')
    }
	});
}

TagsInput.updateValues = function(container, val){
	$(container).append('<span class="highlight_tag"><span>'+ val +'</span><span class="ml-auto px-2">x</span></span>')
}