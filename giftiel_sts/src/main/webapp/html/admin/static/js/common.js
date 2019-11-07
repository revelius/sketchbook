$(function() { 
	// tab
	 var tab = {
	 	init: function() {
	 		var $tabWrap = $('div.tabWrap')
	 			$tabList = $('ul.tabList'),
	 			$tabListLi = $('ul.tabList li'),
	 			$tabAnchor = $tabListLi.find('a'),
	 			$tabConWrap =  $('div.tabConWrap'),
	 			$tabCon = $('div.tabCon'),
	 			currentClass = 'current';
	 		$tabCon.hide();
	 		$tabWrap.each(function() {
	 			var $tgWrap = $(this);
		 		$tgWrap.find($tabListLi).each(function() {
		 			var tgIndex = $(this).index(),
		 				$tgCon = $tabConWrap.find($tabCon);
		 			$(this).find($tabAnchor).on('click', function(e) {
		 				e.preventDefault();
		 				$(this).addClass(currentClass)
		 					.parent().siblings().children($tabAnchor).removeClass(currentClass);
		 				$tgWrap.find($tgCon).hide().eq(tgIndex).show();
		 				
		 			});
		 		}).first().children($tabAnchor).trigger('click');
	 		});
	 	}
	 };

	 // help 
	 var help = {
	 	init: function() {
 			var $btnAbvice = $('.advice'),
 				$abviceBox = $('.helpBox'),
 				$boxClose = $abviceBox.find('a.close');
 			$abviceBox.hide();
 			$btnAbvice.on('click', function(e) {
 				e.preventDefault();
 				$abviceBox.fadeIn();
 			});
 			$boxClose.on('click', function(e) {
 				e.preventDefault();
 				$abviceBox.fadeOut();
 			});
	 	}
	 }; help.init();

	 // Stats
	 var stats = {
	 	statsTbl : $('div[class*="tblStats"]'),
	 	init: function() {
	 		this.sorting();
	 		this.openLayer();
	 	},
	 	sorting: function() {
	 		var $tgWrap = stats.statsTbl,
	 			$tgBtn = $tgWrap.find('.down');
	 		$tgBtn.each(function() {
	 			$(this).on('click', function(e) {
	 				e.preventDefault();
	 				if ( $(this).hasClass('down') ) {
	 					$(this).removeClass().addClass('up').text('▲');
	 				} else if ( $(this).hasClass('up') ) {
	 					$(this).removeClass().addClass('down').text('▼');
	 				};
	 			});
	 		});
	 	},
	 	openLayer: function() {
	 		var $tgLayerAnchor = stats.statsTbl.find('table .btnLayer');
	 		$tgLayerAnchor.parent('td').css('position', 'relative').end()
	 			.bind('mouseenter mouseleave', function(e) {
		 		 	e.preventDefault();
		 		 	var $tgLayer = $(this).next('.listLayer');
		 		 	$tgLayer.fadeToggle();
		 		 });
	 	}
	 }; stats.init();

	 // table DnD
	if ( $(".tbl_DnD").size() !== 0 ) $(".tbl_DnD").tableDnD();

});

