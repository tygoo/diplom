var cnv = document.getElementById('sketchpad');  //Replace 'cnv1' with your canvas ID
var php_file ='save_cnvimg.php';  //address of php file that get and save image on server
var axis_data;
var zAxis;
var width, height;
/* Ajax Function
 Send "data" to "php", using the method added to "via", and pass response to "callback" function
 data - object with data to send, name:value; ex.: {"name1":"val1", "name2":"2"}
 php - address of the php file where data is send
 via - request method, a string: 'post', or 'get'
 callback - function called to proccess the server response
*/
function ajaxSend(data, php, via, callback) {
  var ob_ajax = new XMLHttpRequest();

  //put data from 'data' into a string to be send to 'php'
  var str_data ='';
  for(var k in data) {
    str_data += k +'='+ data[k] + '&';
  }
  str_data = str_data.replace(/&$/, '');  //delete ending &sen
  //send data to php
  ob_ajax.open(via, php, true);
  if(via =='post') ob_ajax.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
  ob_ajax.send(str_data);

  //check the state request, if completed, pass the response to callback function
  ob_ajax.onreadystatechange = function(){
    if (ob_ajax.readyState == 4) callback(ob_ajax.responseText);
  }
}
//register click on #btn_cnvimg to get and save image

var btn_cnvimg = document.getElementById('btn');
if(btn_cnvimg) btn_cnvimg.addEventListener('click', function(e){
  var imgname = window.prompt('Зурганд заавал нэр өгнө үү!\n- Хэрвээ зурганд өгсөн нэр өмнөх зургийн нэртэй ижил байвал,\n өмнөх зураг устах болохыг анхаарна уу! \n', '');
  if(imgname !== null){
    //set data that will be send with ajaxSend() to php (base64 PNG image-data of the canvas, and image-name)
    zAxis = document.getElementById("z-axis").value;
    height = cnv.height;
    width = cnv.width;
    //-----------------------traditionally = 0 or fast method  = 1---------------------
    // 
    var method = document.forms[0];
    var txt = "";
    for (var i = 0; i < method.length; i++) {
        if (method[i].checked) {
            txt = txt + method[i].value;
        }
    }
    axis_data = imgname + " " + zAxis + " " + txt + " " + width + " " + height;
    //---------------------------------------------------------------------------
    var img_data = {'cnvimg':cnv.toDataURL('image/png', 1.0), 'imgname':imgname, 'axis': axis_data};
    //send image-data to php file
    ajaxSend(img_data, php_file, 'post', function(resp){
      //show server response in #ajaxresp, if not exist, alert response
      if(document.getElementById('ajaxresp')) document.getElementById('ajaxresp').innerHTML = resp;
      else window.alert('Амжилттай илгээгдлээ!');
    });
  }
});