/* 
Native FullScreen JavaScript API
-------------
Assumes Mozilla naming conventions instead of W3C for now
*/

(function() {
    var 
		fullScreenApi = {
		    supportsFullScreen: false,
		    isFullScreen: function() { return false; },
		    requestFullScreen: function() { },
		    cancelFullScreen: function() { },
		    fullScreenEventName: '',
		    prefix: ''
		},
		browserPrefixes = 'webkit moz o ms khtml'.split(' ');

    // check for native support
    if (typeof document.cancelFullScreen != 'undefined') {
        fullScreenApi.supportsFullScreen = true;
    } else {
        // check for fullscreen support by vendor prefix
        for (var i = 0, il = browserPrefixes.length; i < il; i++) {
            fullScreenApi.prefix = browserPrefixes[i];

            if (typeof document[fullScreenApi.prefix + 'CancelFullScreen'] != 'undefined') {
                fullScreenApi.supportsFullScreen = true;

                break;
            }
        }
    }

    // update methods to do something useful
    if (fullScreenApi.supportsFullScreen) {
        fullScreenApi.fullScreenEventName = fullScreenApi.prefix + 'fullscreenchange';
        fullScreenApi.isFullScreen = function() {
            switch (this.prefix) {
                case '':
                    return document.fullScreen;
                case 'webkit':
                    return document.webkitIsFullScreen;
                default:
                    return document[this.prefix + 'FullScreen'];
            }
        }
        fullScreenApi.requestFullScreen = function(el) {
            return (this.prefix === '') ? el.requestFullScreen() : el[this.prefix + 'RequestFullScreen']();
        }
        fullScreenApi.cancelFullScreen = function(el) {
            return (this.prefix === '') ? document.cancelFullScreen() : document[this.prefix + 'CancelFullScreen']();
        }
    }

    // jQuery plugin
    if (typeof jQuery != 'undefined') {
        jQuery.fn.requestFullScreen = function() {

            return this.each(function() {
                var el = jQuery(this);
                if (fullScreenApi.supportsFullScreen) {
                    fullScreenApi.requestFullScreen(el[0]);
                }
            });
        };
    }

    // export api
    window.fullScreenApi = fullScreenApi;
})();

$().ready(function() {
    $('#linkfullscreen').click(function() {
        if (fullScreenApi.supportsFullScreen)
            $("#bigscreen").requestFullScreen();
        else if (confirm("当前浏览器不支持自动全屏功能，打开页面后请按F11键进入全屏功能。推荐使用firefox、谷歌、Safari 等浏览器。是否继续？")) {
            window.open($('#linkfullscreen').attr("rel"));
        }
    });

    $().bind(fullScreenApi.fullScreenEventName, function() {
        if (fullScreenApi.isFullScreen()) {
            $("#bigscreen").append('<iframe src="' + $('#linkfullscreen').attr("rel") + '" id="bigscreeniframe" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>');
        } else {
            $("#bigscreen").empty();
        }
    });

})