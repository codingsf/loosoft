/**
This Plugin allows you to retrieve the value of a query string.

$.getQueryString({id:"query"}) - returns the value of a query sting called "query"
$.getQueryString({id:"query", defaultvalue:"hello"}) - returns the value of a query sting called "query" unless it doesn't exsist in which case it returns "hello"


**/

// QueryString Engine v1.0.1
//By James Campbell
(function($) {
	$.querystringvalues = $.queryStringValues = $.QueryStringValues = $.QueryStringvalues = $.queryStringValues = $.queryStringvalues = $.querystringValues = $.getqueryString = $.queryString = $.querystring = $.QueryString = $.Querystring = $.getQueryString = $.getquerystring = $.getQuerystring  = function(options)
	{
		defaults = {defaultvalue:"null"} ;
		options = $.extend(defaults , options);
		qs = location.search.substring(1, location.search.length);
		if (qs.length == 0) return options.defaultvalue;
			qs = qs.replace(/\+/g, ' ');
			var args = qs.split('&');
			for (var i = 0; i < args.length; i ++ )
			{
				var value;
				var pair = args[i].split('=');
				var name = unescape(pair[0]);

			if (pair.length == 2)
			{	
				value = unescape(pair[1]);
			}
			else
			{
				value = name;
			}
			if (name == options.id || i == options.id-1)
			{
					return value;
			}
			}
		return options.defaultvalue
	};
})(jQuery);
