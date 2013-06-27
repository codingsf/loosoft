<%@ Page Title="" Language="C#" %>

<html>
<head>
    <style>
        .firstNode{ background-color:#eeeeee; height:30px; line-height:30px; border-bottom:solid 1px #ccc; margin-bottom:4px;}
        .topNode{ text-align:center;height:30px; line-height:30px; margin-bottom:10px; background-color:#eeeeee; font-weight:bold;}
        .otherNode{ margin-top:2px;}
       
    </style>
    <script src="../../script/dtree1.js?v=130506" type="text/javascript"></script>
    <link href="../../style/dtree1.css" rel="stylesheet" type="text/css" />
</head>
<body>
<script>
    function setPara(_did, _isunit, _unitid) {
        if (!_isunit)
            parent.loadRunData(_did);
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
