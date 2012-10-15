<%@ Page Title="" Language="C#" %>

<html>
<head>

    <script src="../../script/dtree.js" type="text/javascript"></script>

    <link href="../../style/dtree.css" rel="stylesheet" type="text/css" />
</head>
<body>

    <script type="text/javascript">
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
