
function openLayer(objId,conId){
var arrayPageSize = getPageSize();//����getPageSize()����
var arrayPageScroll = getPageScroll();//����getPageScroll()����
if (!document.getElementById("popupAddr")){

//�����������ݲ�
var popupDiv = document.createElement("div");

//�����Ԫ��������������ʽ
popupDiv.setAttribute("id","popupAddr")
popupDiv.style.position = "absolute";
popupDiv.style.border = "3px solid #6EBEF4";
popupDiv.style.padding = "5px";
popupDiv.style.margin = "50px auto";
popupDiv.style.background = "#fff";
popupDiv.style.zIndex = 99;



//��������������
var bodyBack = document.createElement("div");
bodyBack.setAttribute("id","bodybg")
bodyBack.style.position = "absolute";
bodyBack.style.width = "100%";
bodyBack.style.height = (arrayPageSize[1] + 35 + 'px');
bodyBack.style.zIndex = 98;
bodyBack.style.top = 0;
bodyBack.style.left = 0;

bodyBack.style.filter = "alpha(opacity=50)";
bodyBack.style.opacity = 0.5;
bodyBack.style.background = "#C0DEF2";

//ʵ�ֵ���(���뵽Ŀ��Ԫ��֮��)
var mybody = document.getElementById(objId);
insertAfter(popupDiv,mybody);//ִ�к���insertAfter()
insertAfter(bodyBack,mybody);//ִ�к���insertAfter()

}

//��ʾ������
document.getElementById("bodybg").style.display = "";
//��ʾ���ݲ�
var popObj=document.getElementById("popupAddr")
popObj.innerHTML = document.getElementById(conId).innerHTML;
popObj.style.display = "";
//�õ�������ҳ���д�ֱ���Ҿ���(ͳһ)
//popObj.style.width = "600px";
//popObj.style.height = "400px";
//popObj.style.top = arrayPageScroll[1] + (arrayPageSize[3] - 35 - 400) / 2 + 'px';
//popObj.style.left = (arrayPageSize[0] - 20 - 600) / 2 + 'px';
//�õ�������ҳ���д�ֱ���Ҿ���(����)
var arrayConSize=getConSize(conId)
popObj.style.top = arrayPageScroll[1] + (arrayPageSize[3] - arrayConSize[1]) / 2-50 + 'px';
popObj.style.left = (arrayPageSize[0] - arrayConSize[0]) / 2 -30 + 'px';
}
//��ȡ���ݲ�����ԭʼ�ߴ�
function getConSize(conId){
var conObj=document.getElementById(conId)
conObj.style.position = "absolute";
conObj.style.left=-1000+"px";
conObj.style.display="";
var arrayConSize=[conObj.offsetWidth,conObj.offsetHeight]
conObj.style.display="none";
return arrayConSize;
}
function insertAfter(newElement,targetElement){//����
var parent = targetElement.parentNode;
if(parent.lastChild == targetElement){
parent.appendChild(newElement);
}
else{
parent.insertBefore(newElement,targetElement.nextSibling);
}
}
//��ȡ�������ĸ߶�
function getPageScroll(){
var yScroll;
if (self.pageYOffset) {
yScroll = self.pageYOffset;
} else if (document.documentElement && document.documentElement.scrollTop){
yScroll = document.documentElement.scrollTop;
} else if (document.body) {
yScroll = document.body.scrollTop;
}

arrayPageScroll = new Array('',yScroll)
return arrayPageScroll;
}
//��ȡҳ��ʵ�ʴ�С
function getPageSize(){
var xScroll,yScroll;

if (window.innerHeight && window.scrollMaxY){
xScroll = document.body.scrollWidth;
yScroll = window.innerHeight + window.scrollMaxY;
} else if (document.body.scrollHeight > document.body.offsetHeight){
sScroll = document.body.scrollWidth;
yScroll = document.body.scrollHeight;
} else {
xScroll = document.body.offsetWidth;
yScroll = document.body.offsetHeight;
}

var windowWidth,windowHeight;
//var pageHeight,pageWidth; 
if (self.innerHeight) {
windowWidth = self.innerWidth;
windowHeight = self.innerHeight;
} else if (document.documentElement && document.documentElement.clientHeight) {
windowWidth = document.documentElement.clientWidth;
windowHeight = document.documentElement.clientHeight;
} else if (document.body) {
windowWidth = document.body.clientWidth;
windowHeight = document.body.clientHeight;
}

var pageWidth,pageHeight
if(yScroll < windowHeight){
pageHeight = windowHeight;
} else {
pageHeight = yScroll;
}
if(xScroll < windowWidth) {
pageWidth = windowWidth;
} else {
pageWidth = xScroll;
}
arrayPageSize = new Array(pageWidth,pageHeight,windowWidth,windowHeight)
return arrayPageSize;
}
//�رյ�����
function closeLayer(){
document.getElementById("popupAddr").style.display = "none";
document.getElementById("bodybg").style.display = "none";
return false;
}


