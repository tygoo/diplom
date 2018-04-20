<html>
<head>
<title>3D IMAGE</title>
    <script type="text/javascript" src="js/touchdrawing.js"></script>
    <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.js" type="text/javascript"></script>
    <link rel="stylesheet" href="css/bootstrap.css" type="text/css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="css/csstyle.css">
    <script src="js/jscolor.js"></script>
<style>
/* Some CSS styling */
 .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 660px}
    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;} 
    }
</style>
</head>

<body onload="init()">
    <nav class="navbar navbar-inverse">

      <div class="container-fluid">

        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>                        
          </button>

          <a href="#" id="btn" class="navbar-brand"  style="color:white; background:#4CAF50; margin-left: 10px; width: 100px; height: 40px; padding:10px 25px; margin-top: 5px;">Илгээх</a>
          <a href="#" class="navbar-brand" onclick="clearCanvas(canvas,ctx);" style="color:white; background:#ff3333; margin-left: 10px; width: 100px; height: 40px; padding:10px 15px; margin-top: 5px;"><center>Арилгах</center></a>
            <a href="#" style=" margin-left: 10px; width: 100px; height: 40px; padding:10px 15px; margin-top: 15px; text-decoration: none;">
                <img src="icons/Fast_text.png" class = "icon-text" style="color:white; margin-top: 15px;" width="19px" height="19px" id="Pen">
            </a>
            <a href="#" style=" width: 100px; height: 40px; padding:10px 5px; margin-top: 15px; text-decoration: none;">
                <img src="icons/draw.png" class = "icon-text" style="color:white;margin-top: 15px" width="19px" height="19px" id="draw">
            </a>
        </div>

            <div class="collapse navbar-collapse" id="myNavbar">
                <ul class="nav navbar-nav" style = "text-align:center">
                    <li class="dropdowns"><a href="#">Өнгө:
                        <input class="jscolor" value="dd3131" id = "pen_color" name="fname"></a>
                    </li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" id = "sizes" data-toggle="dropdown" href="#"><span class="caret"></span></a>
                          <ul class="dropdown-menu" id = "myList" style = "text-align:center">
                            <!--<li><input class="size" value="1" id = "draw_size" name="fname" type="number"></li>-->
                                <li id="drawCanvas"><a href="#">
                                    <canvas id="myCanvas1" width="160" height="50"></canvas></a>
                                </li>
                                <li id="drawCanvas"><a href="#">
                                    <canvas id="myCanvas2" width="160" height="50"></canvas></a>
                                </li>
                                <li id="drawCanvas"><a href="#">
                                    <canvas id="myCanvas3" width="160" height="50"></canvas></a>
                                </li>
                                <li id="drawCanvas"><a href="#">
                                    <canvas id="myCanvas4" width="160" height="50"></canvas></a>
                                </li>
                          </ul>
                    </li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" id = "text_size1" data-toggle="dropdown" href="#"><span class="caret"></span></a>
                          <ul class="dropdown-menu" id = "myList" style = "text-align:center">
                            <!--<li><input class="size" value="1" id = "draw_size" name="fname" type="number"></li>-->
                                <li id="textCanvas"><a href="#">
                                    <canvas id="text1" width="160" height="50"></canvas></a>
                                </li>
                                <li id="textCanvas"><a href="#">
                                    <canvas id="text2" width="160" height="50"></canvas></a>
                                </li>
                                <li id="textCanvas"><a href="#">
                                    <canvas id="text3" width="160" height="50"></canvas></a>
                                </li>
                                <li id="textCanvas"><a href="#">
                                    <canvas id="text4" width="160" height="50"></canvas></a>
                                </li>
                          </ul>
                    </li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" id = "draw_image" data-toggle="dropdown" href="#"><span class="caret"></span></a>
                          <ul class="dropdown-menu" id = "myList">
                            <!--<li><input class="size" value="1" id = "draw_size" name="fname" type="number"></li>-->
                            <center>
                            <input type="file" id="input" width="150" height="50"></center>

                          </ul>
                    </li>
                    <li style="color: #b3b3b3; font-size: 12px; margin-left: 10px">X:<input type="number" onchange="canvas.width = document.getElementById('x-axis').value;" id = "x-axis" name="fname" value="1" style="width: 50px; margin-top:15px; color: black; text-align: center;">
                    </li>
                    <li style="color: #b3b3b3; font-size: 12px; margin-left: 10px">Y:<input type="number" onchange="canvas.height = document.getElementById('y-axis').value;" id = "y-axis" name="fname" value="1" style="width: 50px; margin-top:15px; color: black;text-align: center;">
                    </li>
                    <li style="color: #b3b3b3; font-size: 12px; margin-left: 10px">Z:<input type="number" id = "z-axis" name="fname" value="1" style="width: 50px; margin-top:15px; color: black;text-align: center;">
                    </li>
                </ul>

                <ul class="nav navbar-nav navbar-right" style="margin-top: 1px;">
                    <li style="color: #b3b3b3; font-size: 13px; margin-left: 2px; text-align:center;"><form>
                      Хурдан арга <input type="radio" name="coffee" value="1" checked><br>
                      Уламжлалт арга <input type="radio" name="coffee" value="0">
                    </form>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div id="sketchpadapp" class="col-sm-12 col-xs-12 container">
        <center>
            <canvas id="sketchpad" height="400px" width="400px"> </canvas>
        </center>
    </div>
</body>
    <script>
    function setTextColor(picker) {
        document.getElementsByTagName('body')[0].style.color = '#' + picker.toString()
    }
    </script>
 <script type="text/javascript" src="js/saving.js"></script>
</html>
