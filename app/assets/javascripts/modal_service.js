ModalService = {}

ModalService.init = function(){
	this.initHandler()
}

ModalService.initHandler = function(){

	$('#profile_pic').on('change', function(){
		ModalService.previewFile(this)
		ModalService.changeProfileImage()
	})
}
ModalService.changeProfileImage = function(){
	var formData = new FormData();
	formData.append('file', $('#profile_pic')[0].files[0]);

		$.ajax({
       url : '/profile/update_profile_pic',
       type : 'POST',
       data : formData,
       processData: false,
       contentType: false,
       beforeSend: function(xhr) {
		    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
		  	},  
       success : function(data) {
           console.log(data);
           alert(data);
       }
		});
}

ModalService.previewFile = function(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    
    reader.onload = function(e) {
      $('.profile_picture').attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0])
  }
}

ModalService.profileInfoModal = function(){
	$('#profile_info_modal').modal()
	$('#profile_info_input').val($('.profile_info_content').html())
}

ModalService.submitProfileInfo = function(){
	data = $('#profile_info_input').val()
	$.ajax({
	  method: "POST",
	  url: "/profile/profile_info",
	  data: { profile_info: data },
	  beforeSend: function(xhr) {
	    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
	  },
	})
	  .done(function( msg ) {
	  	$('.profile_info_content').html(data)
	  	$('#profile_info_modal').modal('toggle')
	  });
}

ModalService.toggleModal = function(event_name, id, exp_id){
	$('#'+event_name+'_modal').modal('toggle')
	ModalService.getModalContent(event_name + '_modal', id, exp_id)
}

ModalService.submitForm = function(ele){
	key_name = ele + 's'
	data = {}
	alert()
	data[key_name] = $('#' + ele + '_form').serializeJSON()
	$.ajax({
	  method: "POST",
	  url: "/profile/update",
	  data: data,
	  beforeSend: function(xhr) {
	    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
	  },
	}).done(function( msg ) {
	  $('#' + ele+'s_modal').modal('toggle');
	  document.location.reload()
	});
	return false
}

ModalService.getModalContent = function(modal_name, id, exp_id){
	$.ajax({
	  method: "GET",
	  url: "/profile/get_modal",
	  data: { entity: modal_name, id , experience_id: exp_id },
	  beforeSend: function(xhr) {
	    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
	  },
	})
	  .done(function( msg ) {
	  	$('#' + modal_name + ' .modal-dialog').html(msg)

	  });

}

ModalService.deleteEntity = function(modal_entity,id){
	alert()
	$.ajax({
	  method: "DELETE",
	  url: "/profile/delete",
	  data: { entity: modal_entity, id: id },
	  beforeSend: function(xhr) {
	    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
	  },
	  success: function(){
	  	$('#' + modal_entity + '_modal').modal('toggle')
	  	$('.' + modal_entity + '_container[data-id='+ id +']').html('')	
	  		  document.location.reload()

	  }
	})
}

ModalService.imageUpload = function(){

}

ModalService.updateHighLights = function(){
	values = $('.highlights_input').tagsManager('tags');
	$.ajax({
	  method: "POST",
	  url: "/profile/highlights",
	  data: { highlights: values },
	  beforeSend: function(xhr) {
	    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
	  },
	})
	  .done(function( msg ) {
	  	$('#highlights_modal').html(msg)

		  document.location.reload()

	  });
}