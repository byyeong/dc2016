<?php

    /*
	error_reporting (E_ALL ^ E_NOTICE);
	session_start(); //Do not remove this
	//only assign a new timestamp if the session variable is empty
	if (!isset($_SESSION['random_key']) || strlen($_SESSION['random_key'])==0){
	    $_SESSION['random_key'] = strtotime(date('Y-m-d H:i:s')); //assign the timestamp to the session variable
		$_SESSION['user_file_ext']= "";
	}
	#########################################################################################################
	# CONSTANTS																								#
	# You can alter the options below																		#
	#########################################################################################################
	$upload_dir = "upload_pic"; 				// The directory for the images to be saved in
	$upload_path = $upload_dir."/";				// The path to where the image will be saved
	$large_image_prefix = "resize_"; 			// The prefix name to large image
	$thumb_image_prefix = "thumbnail_";			// The prefix name to the thumb image
	$large_image_name = $large_image_prefix.$_SESSION['random_key'];     // New name of the large image (append the timestamp to the filename)
	$thumb_image_name = $thumb_image_prefix.$_SESSION['random_key'];     // New name of the thumbnail image (append the timestamp to the filename)
	$max_file = "3"; 							// Maximum file size in MB
	$max_width = "500";							// Max width allowed for the large image
	$thumb_width = "100";						// Width of thumbnail image
	$thumb_height = "100";						// Height of thumbnail image
	// Only one of these image types should be allowed for upload
	*/
	
	
	##########################################################################################################
	# IMAGE FUNCTIONS																						 #
	# You do not need to alter these functions																 #
	##########################################################################################################
	function resizeImage($image,$width,$height,$scale) {
		list($imagewidth, $imageheight, $imageType) = getimagesize($image);
		$imageType = image_type_to_mime_type($imageType);
		$newImageWidth = ceil($width * $scale);
		$newImageHeight = ceil($height * $scale);
		$newImage = imagecreatetruecolor($newImageWidth,$newImageHeight);
		switch($imageType) {
			case "image/gif":
				$source=imagecreatefromgif($image); 
				break;
		    case "image/pjpeg":
			case "image/jpeg":
			case "image/jpg":
				$source=imagecreatefromjpeg($image); 
				break;
		    case "image/png":
			case "image/x-png":
				$source=imagecreatefrompng($image); 
				break;
	  	}
		imagecopyresampled($newImage,$source,0,0,0,0,$newImageWidth,$newImageHeight,$width,$height);
		
		switch($imageType) {
			case "image/gif":
		  		imagegif($newImage,$image); 
				break;
	      	case "image/pjpeg":
			case "image/jpeg":
			case "image/jpg":
		  		imagejpeg($newImage,$image,90); 
				break;
			case "image/png":
			case "image/x-png":
				imagepng($newImage,$image);  
				break;
	    }
		
		chmod($image, 0777);
		return $image;
	}
	
	//You do not need to alter these functions
	function resizeThumbnailImage($thumb_image_name, $image, $width, $height, $start_width, $start_height, $scale){
		list($imagewidth, $imageheight, $imageType) = getimagesize($image);
		$imageType = image_type_to_mime_type($imageType);
		
		$newImageWidth = ceil($width * $scale);
		$newImageHeight = ceil($height * $scale);
		$newImage = imagecreatetruecolor($newImageWidth,$newImageHeight);
		switch($imageType) {
			case "image/gif":
				$source=imagecreatefromgif($image); 
				break;
		    case "image/pjpeg":
			case "image/jpeg":
			case "image/jpg":
				$source=imagecreatefromjpeg($image); 
				break;
		    case "image/png":
			case "image/x-png":
				$source=imagecreatefrompng($image); 
				break;
			
	  	}
	  	
		imagecopyresampled($newImage,$source,0,0,$start_width,$start_height,$newImageWidth,$newImageHeight,$width,$height);
		switch($imageType) {
			case "image/gif":
		  		imagegif($newImage,$thumb_image_name); 
				break;
	      	case "image/pjpeg":
			case "image/jpeg":
			case "image/jpg":
		  		imagejpeg($newImage,$thumb_image_name,90); 
				break;
			case "image/png":
			case "image/x-png":
				imagepng($newImage,$thumb_image_name);  
				break;
	    }
		chmod($thumb_image_name, 0777);
		return $thumb_image_name;
	}
	
	
	/*function allImagetoJpg($originalFile){
		list($imagewidth, $imageheight, $imageType) = getimagesize($originalFile);
        $imageType = image_type_to_mime_type($imageType);
	   switch($imageType) {
            case "image/gif":
                $image=imagecreatefromgif($originalFile); 
                break;
            case "image/pjpeg":
            case "image/jpeg":
            case "image/jpg":
                return;
            case "image/png":
            case "image/x-png":
                $image=imagecreatefrompng($originalFile); 
                break;
        }
        imagejpeg($image,$originalFile,90); 
        imagedestroy($image);
	}*/
	
	
	//You do not need to alter these functions
	function getHeight($image) {
		$size = getimagesize($image);
		$height = $size[1];
		return $height;
	}
	
	//You do not need to alter these functions
	function getWidth($image) {
		$size = getimagesize($image);
		$width = $size[0];
		return $width;
	}

?>