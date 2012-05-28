<%@ Page Title="" Language="C#" %>

<html>
<head>
    <title>结构图</title>

    <script type="text/javascript" src="/script/ECOTree.js"></script>

    <link type="text/css" rel="stylesheet" href="/style/ECOTree.css" />
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

    <script src="../../script/jquery-1.3.2.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        var myTree = null;

        function CreateTree() {

            myTree = new ECOTree('myTree', 'myTreeContainer');
                 myTree.config.iSubtreeSeparation = <%=TempData["iSubtreeSeparation"] %>;
        myTree.config.iSiblingSeparation = <%=TempData["iSiblingSeparation"] %>;
        myTree.config.iLevelSeparation = 30;
            <%=ViewData["jsstr"] %>
            myTree.UpdateTree();
        }

        function deleterelations(did,name) {
            name=$(name).attr("ref");
            $.get("/plant/RemoveRelations", { did: did,name:name }, function(data) {
                if (data == "ok")
                    parent.window.location.reload(true);
            });
        }
			       
    </script>

</head>
<body onload="CreateTree();">
    <div id="myTreeContainer">
    </div>
</body>
</html>
