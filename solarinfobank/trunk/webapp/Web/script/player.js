function setHeight(n){
	if(type == "fl")
		player.resize(width,n);
	else
		$(player).css('height',n);
}

		          
function setType(){
	if(!player)
		return;
	if(player.controls)
		type = "wm";
	else if(player.play)
		type="fl";
	else if(player.DoPlay)
		type="rl";
}

function play(){
	if(type == "wm"){
		player.controls.play();
	}
	else if(type == "fl"){
		player.play();
	}else 
		player.DoPlay();
}
function getPosition(){
	if(type == "wm"){
		return player.controls.currentPosition;
	}
	else if(type == "rl")
		return player.GetPosition();
	else 
		return player.getPosition();
}
function setPosition(n){
	alert("dsf")
	player.seek(23);
	return;
	if(type == "wm"){
		player.controls.currentPosition = n;
	}
	else if(type == "fl"){
		alert("fl"+player)
		player.seek(23);
	}		
}
function stop(){
	if(type == "wm")
		player.controls.pause();
	else if(type == "fl")
		player.pause();
	else if(type == "rl")
		player.DoStop();
}
function getTotal(){
	if(type == "wm"){
		return player.currentMedia.duration;
	}
	else if(type == "rl")
		return player.GetLength();
	else if(type == "fl") 
		return player.getDuration();
}
//影藏进度提
function hidecontrolBar(){
	player.controls.hide();
	
}
//后退播放多少分钟
function goBack(m){
	var p = getPosition();
	p = p-(m*60);
	if(p<0)p=0;
	setPosition(p);
}