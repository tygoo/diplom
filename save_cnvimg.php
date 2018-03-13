<?php
define('UPLOAD_DIR', 'uploads/');  //Upload folder
define('UPLOAD_DIR1', 'searcher/');
//get properly base64 image data passed via post in 'cnvimg'
$cnvimg = trim(strip_tags($_POST['cnvimg']));
$cnvimg = str_replace('data:image/png;base64,', '', $cnvimg);
$cnvimg = str_replace(' ', '+', $cnvimg);

//get image data from base64 and save it on server
$data = base64_decode($cnvimg);
$file = UPLOAD_DIR . $_POST['imgname'] .'.bmp'; 
$success = file_put_contents($file, $data);
//------------------------------------------------
$cnvimg1 = trim(strip_tags($_POST['axis']));
$cnvimg1 = str_replace('data:txt;base64,', '', $cnvimg1);
$cnvimg1 = str_replace(' ', '+', $cnvimg1);

$data_1 = $cnvimg1;
$file_1 = UPLOAD_DIR1. $_POST['imgname'].'.txt';
$success = file_put_contents($file_1, $data_1);
//output response (link to image file, or error message)
print $success ? 'Image: <a href="'. $file .'" target="_blank">'. $file .'</a>' : 'Unable to save the file.';