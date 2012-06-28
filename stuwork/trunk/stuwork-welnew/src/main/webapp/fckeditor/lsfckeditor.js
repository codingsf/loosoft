/*
Copyright (c) 2003-2009, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/
function createCkEditor(basePath,eidtorName,width,height,toolbar,userId,ym,isDisable,bgpicpos,type){
	this.bgpicpos = bgpicpos;
    var oFCKeditor = new FCKeditor(eidtorName) ;
    oFCKeditor.BasePath = basePath ;
    oFCKeditor.Height = height;
    oFCKeditor.Width = width;
    oFCKeditor.ToolbarSet = toolbar ;
	oFCKeditor.Config['LinkBrowserURL'] = oFCKeditor.BasePath+'editor/filemanager/browser/default/browser.shtml?Connector='+oFCKeditor.BasePath+'editor/filemanager/connectors/connector'+"&UserId="+userId+"&Ym="+ym;
	oFCKeditor.Config['ImageBrowserURL'] = oFCKeditor.BasePath+'editor/filemanager/browser/default/browser.shtml?Type=Image&Connector='+oFCKeditor.BasePath+'editor/filemanager/connectors/connector'+"&UserId="+userId+"&Ym="+ym ;
	oFCKeditor.Config['FlashBrowserURL'] = oFCKeditor.BasePath+'editor/filemanager/browser/default/browser.shtml?Type=Flash&Connector='+oFCKeditor.BasePath+'editor/filemanager/connectors/connector'+"&UserId="+userId+"&Ym="+ym ;
	oFCKeditor.Config['MediaBrowserURL'] = oFCKeditor.BasePath+'editor/filemanager/browser/default/browser.shtml?Type=Media&Connector='+oFCKeditor.BasePath+'editor/filemanager/connectors/connector'+"&UserId="+userId+"&Ym="+ym ;	            
	oFCKeditor.Config['LinkUploadURL'] = oFCKeditor.BasePath+'editor/filemanager/connectors/upload?Type=File'+"&UserId="+userId+"&Ym="+ym;
	oFCKeditor.Config['ImageUploadURL'] = oFCKeditor.BasePath+'editor/filemanager/connectors/upload?Type=Image'+"&UserId="+userId+"&Ym="+ym;
	oFCKeditor.Config['FlashUploadURL'] = oFCKeditor.BasePath+'editor/filemanager/connectors/upload?Type=Flash'+"&UserId="+userId+"&Ym="+ym;
	oFCKeditor.Config['MediaUploadURL'] = oFCKeditor.BasePath+'editor/filemanager/connectors/upload?Type=Media'+"&UserId="+userId+"&Ym="+ym;
     if(type == 'create'){
    	oFCKeditor.Create(); 
    }else
    	oFCKeditor.ReplaceTextarea();
	this.isDisable = isDisable;
}   
/**
 * 取得示实例
 * @param EditorName
 * @return
 */
function getEditorEntance(EditorName){
	
	if(editorInstance1!=null&&editorInstance1.Name==EditorName){
		return editorInstance1;
	}
	if(editorInstance2!=null&&editorInstance2.Name==EditorName){
		return editorInstance2;
	}
}
//获取编辑器中HTML内容
function getEditorHTMLContents(EditorName) {
    var oEditor = FCKeditorAPI.GetInstance(EditorName);
    return(oEditor.GetXHTML(true));
}

// 获取编辑器中文字内容
function getEditorTextContents(EditorName) {
    var oEditor = FCKeditorAPI.GetInstance(EditorName);
    return(oEditor.EditorDocument.body.innerText);
    //editor.EditorDocument.body.innerHTML
}

function constructReply(nick,ContentStr,width){
	return "<br><div style='background:#FFFFF0; border:1px solid #6E96D5; width:"+width+"px;'  >"+nick+"说:&nbsp;&nbsp;<br>"+ContentStr+"</div><p></p><br>";
}

//设置编辑器中内容
function SetEditorContents(EditorName, ContentStr) {
    var oEditor = this.getEditorEntance(EditorName) ;
    oEditor.SetHTML(ContentStr) ;
}

var editorInstance1 = null;
var editorInstance2 = null;
var isDisable = true;
//编辑框背景图片位置
var bgpicpos = 80;
/** 
 * FCKEditor初始化完成将调用此方法 
* @param {Object} editorInstance 
*/  
/*
function FCKeditor_OnComplete( oEditor ) {  
	if(!editorInstance1){
		editorInstance1 = oEditor;
	}else 
		editorInstance2 = oEditor;
	
	oEditor.EditorDocument.body.style.cssText += 'background:url(http://image.lansin.com/bjq_bg.jpg)  center 80px no-repeat; ' ;
	//alert(oEditor.EditorDocument.body.style.cssText);
	//oEditor.SwitchEditMode();//转变编辑模式	
	if(isDisable){
		disableToolbar(oEditor);
		oEditor.Events.AttachEvent( 'OnFocus', dofocus ) ;		
		oEditor.Events.AttachEvent( 'OnSelectionChange', dofocus ) ;
	}
	//oEditor.Commands.GetCommand('Source').Execute()
	
}
*/

/** 
 * FCKEditor初始化完成将调用此方法 
* @param {Object} editorInstance 
*/  
function FCKeditor_OnComplete( oEditor ) { 
	if(editorInstance1 == null){
		editorInstance1 = oEditor;
	}else 
		editorInstance2 = oEditor;
	
    editorInstance=oEditor;  
	//var oEditor = FCKeditorAPI.GetInstance('content');			
	//oEditor.EditorDocument.body.style.cssText += 'background:url(http://image.lansin.com/bjq_bg.jpg)  center '+bgpicpos+'px no-repeat; ' ;
	//alert(oEditor.EditorDocument.body.style.cssText);
	//oEditor.SwitchEditMode();//转变编辑模式
	if(!isDisable){
		disableToolbar(oEditor);
		if(editorInstance1 != null){
			editorInstance1.Events.AttachEvent( 'OnFocus', dofocus ) ;		
			editorInstance1.Events.AttachEvent( 'OnSelectionChange',  dofocus) ;
		}else {
			editorInstance2.Events.AttachEvent( 'OnFocus', dofocus ) ;		
			editorInstance2.Events.AttachEvent( 'OnSelectionChange',  dofocus) ;
		}
	}	
}


function dofocus(){
	if(editorInstance1 != null)
		disableToolbar(editorInstance1);
	if(editorInstance2 != null)
		disableToolbar(editorInstance2);
}

function disableToolbar(oEditor){
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["DocProps"].Disable()
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Preview"].Disable() 
	
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Cut"].Disable()
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Copy"].Disable() 
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Paste"].Disable()
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["PasteText"].Disable() 
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["PasteWord"].Disable()
	
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Undo"].Disable() 
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Redo"].Disable()
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Find"].Disable() 
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Replace"].Disable()
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["SelectAll"].Disable() 
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["RemoveFormat"].Disable()
	
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Bold"].Disable() 
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Italic"].Disable()
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Underline"].Disable() 
	
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["OrderedList"].Disable()
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["UnorderedList"].Disable() 
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Outdent"].Disable()
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Indent"].Disable()
	
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["JustifyLeft"].Disable() 
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["JustifyCenter"].Disable()
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["JustifyRight"].Disable() 
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["JustifyFull"].Disable()
	
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Link"].Disable() 
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Unlink"].Disable()
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Anchor"].Disable() 
	
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Image"].Disable() 
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Flash"].Disable()
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Rule"].Disable() 
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Smiley"].Disable()		
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["SpecialChar"].Disable()
	
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["Style"].Disable() 
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["FontFormat"].Disable()		
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["FontName"].Disable() 
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["FontSize"].Disable()	
										
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["TextColor"].Disable() 
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["BGColor"].Disable()		
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["FitWindow"].Disable() 
	oEditor.EditorWindow.parent.FCKToolbarItems.LoadedItems["ShowBlocks"].Disable()		
}