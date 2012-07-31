/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function(config) {
    // Define changes to default configuration here. For example:
    // config.language = 'fr';
    // config.uiColor = '#AADC6E';
    var ckfinderPath = "/ckfinder"; //ckfinder路径
    config.filebrowserBrowseUrl = ckfinderPath + '/ckfinder.html';
    config.filebrowserImageBrowseUrl = ckfinderPath + '/ckfinder.html?type=Images';
    config.filebrowserFlashBrowseUrl = ckfinderPath + '/ckfinder.html?type=Flash';
    config.filebrowserUploadUrl = ckfinderPath + '/core/connector/aspx/connector.aspx?command=QuickUpload&type=Files';
    config.filebrowserImageUploadUrl = ckfinderPath + '/core/connector/aspx/connector.aspx?command=QuickUpload&type=Images';
    config.filebrowserFlashUploadUrl = ckfinderPath + '/core/connector/aspx/connector.aspx?command=QuickUpload&type=Flash';
    config.width = 620;
    config.toolbar =
    [
    ['Source', '-', 'Save', 'NewPage', 'Preview', '-', 'Templates'],
    ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Print', 'SpellChecker', 'Scayt'],
     ['Undo', 'Redo', '-', 'Find', 'Replace', '-', 'SelectAll', 'RemoveFormat'],
    ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
    ['Bold', 'Italic', 'Underline', 'Strike', '-', 'Subscript', 'Superscript'],
    ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', 'Blockquote'],
    ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
    ['Link', 'Unlink', 'Anchor'],
    ['Image', 'Flash', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar', 'PageBreak'],
    ['Styles', 'Format', 'Font', 'FontSize'],
    ['TextColor', 'BGColor'],
    ['Maximize', 'ShowBlocks', '-', 'About']
    ];
};
