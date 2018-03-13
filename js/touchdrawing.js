 // Variables for referencing the canvas and 2dcanvas context
    var canvas,ctx;
    var color = "black";
    // Variables to keep track of the mouse position and left-button status 
    var mouseX,mouseY,mouseDown=0;
    var state = 'draw';
    // Variables to keep track of the touch position
    var touchX,touchY;
    var flag = false;
    var dot_flag = false;
    var prevX = 0 , currX = 0, prevY = 0, currY = 0;
    var text = 'text';
    var draw = 'draw';
    var text_size = 20;
    var size = 3;
    // Draws a dot at a specific position on the supplied canvas name
    // Parameters are: A canvas context, the x position, the y position, the size of the dot
    function drawDot(ctx,x,y,size) {

        // Let's use black by setting RGB values to 0, and 255 alpha (completely opaque)
        r=0; g=0; b=0; a=255;

        // Select a fill style
        color = document.getElementById("pen_color").value;
        ctx.strokeStyle = "#" + color;
        // Draw a filled circle
        ctx.beginPath();
       // ctx.arc(x, y, 5, 0, Math.PI*2, true); 
      ctx.moveTo(prevX, prevY);
        ctx.lineTo(x, y);
        ctx.lineWidth = size;
        //ctx.fillRect(x,y,5,5);
        ctx.stroke();
        ctx.closePath();
        ctx.fill();

    } 

    // Clear the canvas context using the canvas width and height
    function clearCanvas(canvas,ctx) {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        document.getElementById('input').value = "";
    }

    // Keep track of the mouse button being pressed and draw a dot at current location
    function sketchpad_mouseDown() {
        mouseDown=1;
        if(state == 'draw'){
        //size = document.getElementById("draw_size").value;
        //check_size(size);
        check_draw_size();
        drawDot(ctx,mouseX,mouseY,size);
        }
        else{
            //size = document.getElementById("draw_size").value;
            insertText(ctx,mouseX,mouseY,size);
        }

    }

    function check_draw_size(){
        document.getElementById("myCanvas1").addEventListener("click", function(){
            size = 1;
            });
            document.getElementById("myCanvas2").addEventListener("click", function(){
            size = 3;
            });
            document.getElementById("myCanvas3").addEventListener("click", function(){
            size = 5;
            }); 
            document.getElementById("myCanvas4").addEventListener("click", function(){
            size = 7;
            });
    }
    // Keep track of the mouse button being released
    function check_text_size(){
            document.getElementById("text1").addEventListener("click", function(){
            text_size = 20;
            });
            document.getElementById("text2").addEventListener("click", function(){
            text_size = 50;
            });
            document.getElementById("text3").addEventListener("click", function(){
            text_size = 70;
            }); 
            document.getElementById("text4").addEventListener("click", function(){
            text_size = 100;
            });
    }
    function sketchpad_mouseUp() {
        mouseDown=0;
    }
    //draw-image kk 
    function draw_image_file(e) {
        if (e.target.files[0] != null) {
    var url = URL.createObjectURL(e.target.files[0]);
    var img = new Image();
    img.onload = function() {
        ctx.drawImage(img, 0, 0, canvas.width, canvas.height);    
    }
    img.src = url;  } 
}
    // Keep track of the mouse position and draw a dot if mouse button is currently pressed
    function sketchpad_mouseMove(e) { 
        // Update the mouse co-ordinates when moved
        getMousePos(e);
        // Draw a dot if the mouse button is currently being pressed
        if (mouseDown==1) {
            if(state == 'draw'){
                //size = document.getElementById("draw_size").value;
                check_draw_size();
                drawDot(ctx,mouseX,mouseY,size);
            }
        }
    }
    // Get the current mouse position relative to the top-left of the canvas
    function getMousePos(e) {
        if (!e)
            var e = event;

        if (e.offsetX) {
            prevY = mouseY;
            prevX = mouseX;
            mouseX = e.offsetX;
            mouseY = e.offsetY;
        }
        else if (e.layerX) {
            prevX = mouseX;
            prevY = mouseY;
            mouseX = e.layerX;
            mouseY = e.layerY;
        }
     }

    // Draw something when a touch start is detected
    function sketchpad_touchStart() {
        // Update the touch co-ordinates
        getTouchPos();
        prevY = touchY;
        prevX = touchX;
        if(state == 'draw'){
            //size = document.getElementById("draw_size").value;
            drawDot(ctx,touchX,touchY,size);
        }
        else{
            check_text_size();
            insertText(ctx,touchX,touchY,size);
        }
        // Prevents an additional mousedown event being triggered
        event.preventDefault();
    }

    // Draw something and prevent the default scrolling when touch movement is detected
    function sketchpad_touchMove(e) { 
        // Update the touch co-ordinates
        getTouchPos(e);
        if(e.touches.length == 1){
            if(state == 'draw'){
            //size = document.getElementById("draw_size").value;
            check_draw_size();
            drawDot(ctx,touchX,touchY,size); 
        }
        else{
            check_text_size();
            insertText(ctx, mouseX, mouseY, text_size);
        }
        // Prevent a scrolling action as a result of this touchmove triggering.
        event.preventDefault();
    }   
}
    function getTouchPos(e) {
        if (!e)
            var e = event;
        if(e.touches){
            if (e.offsetX) {
                prevY = touchY;
                prevX = touchX;
                touchX = e.offsetX;
                touchY = e.offsetY;
            }
            else if (e.layerX) {
                prevX = touchX;
                prevY = touchY;
                touchX = e.layerX;
                touchY = e.layerY;
            }
        }
    }
    //insert text 
    function insertText(ctx,x,y,size){
        //size = document.getElementById("draw_size").value;
        check_text_size()
        var style = 'bold';
        var tsize = text_size.toString() + "px";
        var family = '"Arial Black", Gadget, sans-serif'
        ctx.font = style + " " + tsize + " " + family;
        color = document.getElementById("pen_color").value;
        ctx.fillStyle = "#" + color;
        ctx.fillText(text, x, y);
    }
    function changeState(){
        state = text;
        check_text_size();
        text = window.prompt("Текстээ оруулна уу!");    
    }
    function changeState_draw(){
        state = draw;
        alert("Зурах тохиргоо");
    }

    // Set-up the canvas and add our event handlers after the page has loaded
    function init() {
        // Get the specific canvas element from the HTML document
        canvas = document.getElementById('sketchpad');

        canvas.width = window.innerWidth - 50;
        canvas.height = window.innerHeight - window.innerHeight/7 ;
        document.getElementById("x-axis").value = canvas.width;
        document.getElementById("y-axis").value = canvas.height;
        // If the browser supports the canvas tag, get the 2d drawing context for this canvas
        if (canvas.getContext)
            ctx = canvas.getContext('2d');
        // Check that we have a valid context to draw on/with before adding event handlers
        if (ctx) {
            // React to mouse events on the canvas, and mouseup on the entire document
            canvas.addEventListener('mousedown', sketchpad_mouseDown, false);
            canvas.addEventListener('mousemove', sketchpad_mouseMove, false);
            window.addEventListener('mouseup', sketchpad_mouseUp, false);

            // React to touch events on the canvas
            canvas.addEventListener('touchstart', sketchpad_touchStart, false);
            canvas.addEventListener('touchmove', sketchpad_touchMove, false);
        }
        document.getElementById("Pen").addEventListener("click", changeState);
        document.getElementById("draw").addEventListener("click", changeState_draw);
        //zuraasiin hemjeeg tohiruulah
                document.getElementById("sizes").innerHTML = "Зураасны хэмжээ";
                var myCanvas = ["myCanvas1","myCanvas2","myCanvas3","myCanvas4"];
                for (var i = 0; i < myCanvas.length; i++) {
                    var c = document.getElementById(myCanvas[i]);
                    var ctx1 = c.getContext("2d");
                    ctx1.beginPath();
                    ctx1.lineWidth = 1 + i*2;
                    ctx1.strokeStyle = "#ff4d4d"
                    ctx1.moveTo(30, 20);
                    ctx1.lineTo(150,20);
                    ctx1.stroke();
                }
            // text n hemjeeg tohiruulah
                document.getElementById("text_size1").innerHTML = "Үсэгний хэмжээ";
                var myCanvas = ["text1","text2","text3","text4"];
                var textValue = ["SMALL", "MEDIUM", "LARGE", "HUGE"]
                var k = 0;
                for (var i = 0; i < myCanvas.length; i++) {
                    var style = 'italic';
                    var k = (i + 1) * 10;
                    var tsize = k.toString() + "px";
                    var family = '"Arial Black", Gadget, sans-serif'
                    var c1 = document.getElementById(myCanvas[i]);
                    var ctx2 = c1.getContext("2d");
                    ctx2.font = style + " " + tsize + " " + family;
                    ctx2.fillStyle = "#ff4d4d";
                    ctx2.fillText(textValue[i], 15, 30);
                }
            //upload image ---------------------------
                var input = document.getElementById('input');
                input.addEventListener('change', draw_image_file);
                document.getElementById("draw_image").innerHTML = "Зураг оруулах"
    }