<?php
	$name = $_POST['name'];
	$eimailFrom = $_POST['email'];
	$subject = $_POST['subject'];
	$message = $_POST['message'];
	
	$eimailTo = "kostas.moulosiotis@hotmail.com";
	$headers = "From: ".$eimailFrom;
	$txt = "You have received an email from: ".$eimailFrom.".\n\n"."Message: \n\n".$message;
	
	if(mail($eimailTo, $subject, $txt, $headers)){
		echo "Your e-mail send succesfully!";
	}
	else{
		echo "Can not send your e-mail";
	}
	
	header("Location: contact.html");
?>