function ValidateFileUpload(thisObject) {
	var permitedExtensions = new Array("jpg", "pdf", "jpeg", "gif", "png");
	var fileUploadPath = thisObject.value;
	var size = thisObject.files[0].size;
	var maxSize = 20971520;
	if (fileUploadPath != '') {
		var extension = fileUploadPath.substring(
				fileUploadPath.lastIndexOf('.') + 1).toLowerCase();

		for (var i = 0; i < permitedExtensions.length; i++) {
			if (extension == permitedExtensions[i]) {
				flag = 0;
				break;
			} else {
				flag = 1;
			}
		}
		if (flag != 0) {

			thisObject.value = "";
		}
		if (size > maxSize) {
			thisObject.value = "";
		}
	}

}