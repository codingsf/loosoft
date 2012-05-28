<%@ Page Title="" Language="C#" %>

<html>
<head>
    <title>结构图</title>

    <script type="text/javascript" src="/script/ECOTree.js"></script>

    <link type="text/css" rel="stylesheet" href="/style/ECOTree.css" />
        <link href="/style/sub.css" rel="stylesheet" type="text/css" />
    <link href="/style/kj.css" rel="stylesheet" type="text/css" />
    <xml:namespace ns="urn:schemas-microsoft-com:vml" prefix="v" />
    <style>
        v\:*
        {
            behavior: url(#default#VML);
        }
    </style>
    <style>
        .copy
        {
            font-family: "Verdana";
            font-size: 20px;
            color: #CCCCCC;
        }
        *
        {
            border: none;
        }
    </style>

    <script type="text/javascript">
		    var myTree = null;

		    function CreateTree() {

		        myTree = new ECOTree('myTree', 'myTreeContainer');
              myTree.config.iSubtreeSeparation = <%=TempData["iSubtreeSeparation"] %>;
        myTree.config.iSiblingSeparation = <%=TempData["iSiblingSeparation"] %>;
        myTree.config.iLevelSeparation = 30;
                <%=TempData["jsstr"] %>
                myTree.config.iRootOrientation=3;
		        myTree.UpdateTree();
		    }
			       
    </script>

</head>
<body onload="CreateTree();">
    <div id="myTreeContainer" class="gf_midbody">
    </div>
</body>
</html>
