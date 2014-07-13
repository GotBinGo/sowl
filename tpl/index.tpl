<html>
   <head>
      <title>music player</title>
      <meta name="viewport" content="width=device-width; initial-scale=1.0; mininum-scale=0.5; maximum-scale=1.0; user-scalable=no;" />
      <script>
		{literal}	  
		function loadXMLDoc(term)
         {
         var geturl="search.php?term="+term;
         var xmlhttp;
         if (window.XMLHttpRequest)
           {// code for IE7+, Firefox, Chrome, Opera, Safari
           xmlhttp=new XMLHttpRequest();
           }
         else
           {// code for IE6, IE5
           xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
           }
         xmlhttp.onreadystatechange=function()
           {
           if (xmlhttp.readyState==4 && xmlhttp.status==200)
             {
             document.getElementById("Track_List").innerHTML=xmlhttp.responseText;
             }
           }
         xmlhttp.open("GET",geturl,true);
         xmlhttp.send();
         }
		 {/literal}	  
      </script>
      <link rel="stylesheet" type="text/css" href="style.css">
   </head>
   <body style="margin:0px;padding:0px;">
      <div id="header" style="background-color:#000000; color:#f0f0f0; "  >
         <table style="width:80%; margin:auto;">
            <tr style="width:100%">
               <td width="150">
                  <div style="  color:#f0f0f0;  padding:10px 0px; font-size:24px; font-family:Helvetica Neue, Arial;  ">
                     music player
					</div>
               </td>
               <td width="70" height="45" style="padding:0px; margin:0px; ">
                  <div style="  color:#f0f0f0;  width:100%; height:100%; margin:0px; padding:10px 0px; float:left; display:block; position:relative; vertical-align:middle; ">
                    <input type="text" id="term" name="term" value="" style="border-radius:5px; height:25px; background-color:#bbbbbb; border:none;">
					<script>
					{literal}	  
					document.getElementById("term").addEventListener('keydown',function(e)
					{
						if(window.event) // IE
						{
							bill = e.keyCode;
						}
						else if(e.which) // Netscape/Firefox/Opera
						{
							bill = e.which;
						}
						if(bill==13)
						{
							loadXMLDoc(document.getElementById("term").value);
						}
					});
					{/literal}	  
					</script>
                  </div>
               </td>
            </tr>
         </table>
      </div>
      <div style="height:15px;"></div>
      <div style="width:80%; margin:auto; margin-bottom:100px;">
      <div style="font-family:Arial; font-size:22px; margin:0 0 10 0">
         PlayList
      </div>
      <div id="Track_List" >	  
		{$tracks}
			
			
      </div>
      <!--<button onclick="Prev_Item()"><<|</button>
         <button onclick="Play_Pause()">Play/Pause</button>
         <button onclick="Next_Item()">|>></button>-->
      <audio id="player_element" src="" onended="Next_Item()" ontimeupdate="Progressbar()" onprogress="Buffer_Progressbar()"  preload="auto" ></audio>
      <div id="footer_player_container" onclick="Nothing()">
         <div id="footer_player">
            <div id="now_playing_container" style="width:100%; overflow-x:hidden; ">
               <div id="now_playing" style="color:#ffffff; font-family:Arial; line-height:20px; ">
                  - 
               </div>
            </div>
            <div id="progress" onclick="progress_Click(event)">
               <div id="progress_position"></div>
               <div id="progress_loaded"></div>
            </div>
         </div>
      </div>
      <span id="footer_play_btn" class="footer_control_btn" onclick="Play_Pause()">
      </span>	
      <script>
	  {literal}	  
         //mobil ellenorzés
         if (navigator.userAgent.match(/Android/i) ||
         		navigator.userAgent.match(/webOS/i) ||
         		navigator.userAgent.match(/iPhone/i) ||
         		navigator.userAgent.match(/iPad/i) ||
         		navigator.userAgent.match(/iPod/i) ||
         		navigator.userAgent.match(/BlackBerry/) || 
         		navigator.userAgent.match(/Windows Phone/i) || 
         		navigator.userAgent.match(/IEMobile/i) || 
         		navigator.userAgent.match(/Opera Mini/i)
         		)
         {
         	document.getElementById("now_playing_container").style["overflow-x"]="scroll";
         }
		 else
		 {
			document.write('<link rel="stylesheet" type="text/css" href="pc_style.css">');		 
		 }
		 {/literal}	  
      </script>
      <script>
	  {literal}	  
         var Dir="./upload/uploads/"
         
         var act_i=0;
         var next_i=0;
         var x=0;
         
         var player =document.getElementById("player_element");
         
         
         Play_Item();
         Play_Pause();
         
         
         //act_item.src=document.getElementById("0").getAttribute("sid");  ///getAttribute <<--
         
         function Nothing()
         {
         
         
         }
         
         
         function Play_This(t_id)
         {	
         	next_i=t_id;
         	Play_Item();
         }
         
         function Play_Pause()
         {
         
         	if(player.paused)
         	{
         		player.play();
         		//document.getElementById("play_btn").id="pause_btn";
         		document.getElementById("footer_play_btn").id="footer_pause_btn";
         	}
         	else
         	{
         		player.pause();
         		//document.getElementById("pause_btn").id="play_btn";
         		document.getElementById("footer_pause_btn").id="footer_play_btn";
         	}
         }
         function Prev_Item()
         {
         	if(act_i>0){
         		next_i=Number(act_i)-1;
         		Play_Item();
         	}
         	
         }
         function Next_Item()
         {
         	next_i=Number(act_i)+1;
         	if(document.getElementById(next_i)== null)
         	{
         		next_i=0; //KOVETKEZORE -- 0-elsore ugrik
         		Play_Item();
         		Play_Pause();
         	}
         	else
         	{
         		Play_Item();
         	}
         }
         function progress_Click(event)
         {
         	pos_x = event.offsetX?(event.offsetX):event.pageX-document.getElementById("progress").offsetLeft;
         	percent=(pos_x*100)/document.getElementById("progress").offsetWidth;
         	player.currentTime=((player.duration*percent)/100);
         }
         function Buffer_Progressbar()
         {
         
         	if(player.buffered.length>0)
         	{
         		pc=(player.buffered.end(0)/player.duration)*100+"%";
         		document.getElementById("progress_loaded").style["width"]=pc;
         	}
         	
         }
         function Progressbar()
         {
         	p=(player.currentTime/player.duration)*100+"%";	
         	document.getElementById("progress_position").style["width"]=p;
         }
         
         function Play_Item()
         {
         	player.pause()
         	player.src="";
         	player.load();
         	
         	player.src=Dir+""+document.getElementById(next_i).getAttribute("sid");
         	player.load();
         	player.play();
         	document.getElementById("now_playing").innerHTML=document.getElementById(next_i).innerHTML;
         	
         	act_i=Number(next_i);  //Eddigi kovetkezo lesz az aktualis
         	
         	//document.getElementById("play_btn").id="pause_btn";
         	document.getElementsByClassName("footer_control_btn")[0].id="footer_pause_btn";
         }
         
         //KEYDOWN
         document.onkeydown = function(e)
         {
         	if(window.event) // IE
         	{
         		bill = e.keyCode;
         	}
         	else if(e.which) // Netscape/Firefox/Opera
         	{
         		bill = e.which;
         	}
         	
         	if(bill==32)
         	{
         		Play_Pause();
         	}
         	if(bill==37)
         	{
         		Prev_Item();	
         	}
         	if(bill==39)
         	{
         		Next_Item();
         	}         	         
         }    
{/literal}	  		 
      </script>
   </body>
</html>