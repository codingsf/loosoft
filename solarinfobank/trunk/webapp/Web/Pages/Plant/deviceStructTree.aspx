<%@ Page Title="" Language="C#" %>

<html>
<head>

    <script src="../../script/dtree.js" type="text/javascript"></script>

    <link href="../../style/dtree.css" rel="stylesheet" type="text/css" />
</head>
<body>
<script>
    function setPara(_did, _isunit, _unitid) {
        parent.loadRunData(_did)
    }
</script>
    <script type="text/javascript">
    
		<!--
        d = new dTree('d');

        <%=ViewData["jsstr"] %>
        
        document.write(d);
		//-->
    </script>

</body>
</html>
