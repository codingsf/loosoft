﻿<%@ Page Title="" Language="C#" %>

<html>
<head>
    <style>
        .firstNode{ background-color:#ccc; height:35px; line-height:35px; border-bottom:solid 1px #666666;}
        .topNode{ text-align:center;height:35px; line-height:35px; margin-bottom:10px; background-color:#ccc; font-weight:bold;}
        .otherNode{ margin-top:2px;}
    </style>
    <script src="../../script/dtree1.js" type="text/javascript"></script>

    <link href="../../style/dtree1.css" rel="stylesheet" type="text/css" />
</head>
<body>
<script>
    function setPara(_did, _isunit, _unitid) {
    if(!_isunit)
        parent.loadRunData(_did)
    }
</script>
    <script type="text/javascript">
    
		<!--
        d = new dTree('d');

        <%=ViewData["jsstr"] %>
        
        document.write(d);
        d.openTo(2,true);
		//-->
    </script>

</body>
</html>