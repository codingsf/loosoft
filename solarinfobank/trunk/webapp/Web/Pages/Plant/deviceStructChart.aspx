<%@ Page Title="" Language="C#" %>
<html>
	<head>
		<title>电站设备结构图</title>
		<script type="text/javascript" src="/script/ECOTree.js"></script>
		<link type="text/css" rel="stylesheet" href="/style/ECOTree.css" />
		<xml:namespace ns="urn:schemas-microsoft-com:vml" prefix="v"/>
		<style>v\:*{ behavior:url(#default#VML);}</style> 
		<style>
			.copy {
				font-family : "Verdana";				
				font-size : 20px;
				color : #CCCCCC;
			}
			*{
			 border:none;
			}
		</style>
			
		<script type="text/javascript">
		    var myTree = null;

		    function CreateTree() {

		        myTree = new ECOTree('myTree', 'myTreeContainer');
                myTree.config.iSubtreeSeparation = 20;
                myTree.config.iSiblingSeparation = 10;
                myTree.config.iLevelSeparation = 15;
				//myTree.config.nodeFill = 1;
				myTree.config.useTarget = true;
				myTree.config.iNodeJustification=1;
				myTree.config.iRootOrientation=3;
                <%=ViewData["jsstr"] %>
		        myTree.UpdateTree();
		    }
			       
		</script>			
	</head>
	<body onload="CreateTree();">
		<div id="myTreeContainer">
		</div>
	</body>
</html>