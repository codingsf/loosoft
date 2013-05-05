<%@ Page Title="" Language="C#" %>

<html>
<head>
    <style>
        .firstNode{ background-color:#eeeeee; height:30px; line-height:30px; border-bottom:solid 1px #ccc; margin-bottom:4px;}
        .topNode{ text-align:center;height:30px; line-height:30px; margin-bottom:10px; background-color:#eeeeee; font-weight:bold;}
        .otherNode{ margin-top:2px;}
       
    </style>
    <script src="../../script/dtree1.js?v=130506" type="text/javascript"></script>
<script>
    function setPara(did,isunit,uid) {
        parent.loadRunData(did);
    }
</script>
    <link href="../../style/dtree1.css?v=0427" rel="stylesheet" type="text/css" />
</head>
<body>

    <script type="text/javascript">
        var curname;
		<!--
        d = new dTree('d');
        d.icon.root="/images/tree/question.gif";
        d.icon.folderOpen="/images/tree/unitopen.gif";
        <%=ViewData["jsstr"] %>
        document.write(d);
        d.s(3);
    </script>

</body>
</html>
