/*列表页面通用操作js函数，基于jquery*/
function delOneRecord(id,url){
   if(confirm('您确定要删除吗?')){
   $.ajax({
            type: "post",
            dataType: "html",
            url: url,
            data: "id=" + id,
            success: function (msg) {
            if (msg!=""){
                    alert(msg);
                    location.reload();
                    }
            },
            error: function() {
                 alert("删除失败,请联系管理员");
            }
        });
    }
}