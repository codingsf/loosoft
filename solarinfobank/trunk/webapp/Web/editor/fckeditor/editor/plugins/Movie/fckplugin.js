/*********************************************************************************************************/
/**
 * Movie Player Plugin For Fckeditor (Support: Lajox ; Email: lajox@19www.com)
 */
/*********************************************************************************************************/

// Register the related commands.
FCKCommands.RegisterCommand(
	'Movie',
	new FCKDialogCommand(
		'Movie',
		FCKLang['MoviePlayerDlgTitle'],
		FCKConfig.PluginsPath + 'Movie/movieplayer.html',
		450, 260
	)
);
 
// Create the toolbar button.
var oMoviePlayerItem = new FCKToolbarButton(
	'Movie', 
	FCKLang['MoviePlayerBtn'], 
	FCKLang['MoviePlayerTooltip'],
	null, 
	false, true);
oMoviePlayerItem.IconPath = FCKConfig.PluginsPath + 'Movie/filmreel.gif'; 


FCKToolbarItems.RegisterItem('Movie', oMoviePlayerItem);
