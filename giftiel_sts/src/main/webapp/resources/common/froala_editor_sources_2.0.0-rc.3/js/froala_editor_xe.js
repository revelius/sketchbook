(function($){
	var changeQueue = false;
	var $form = null;
	var upload_target_srl;
	var saved_title = '';
	var saved_content = '';

	$.froalaEditorObj = {
		init: function(cfg){
			cfg = $.extend(cfg, {
				url : request_uri+'index.php',
				sessionName : "PHPSESSID"
			});

			$.froalaEditorObj.froalaEditor(cfg); // Froala Editor 실행
		},
    	translate: function(str){
			if (editor_params.lang[str]) return editor_params.lang[str];
			else return str;
		},
		fileAllowedTypes: function(obj){
			if(obj == "*.*") return ['*'];
			if(typeof $.FroalaEditor.MIME == 'undefined') return;
			var $array = obj.split( ';' );
			var $format_arr = [];
			if($array.length < 1) $array.push(obj);

			$.each($array, function(i, val) {
				var mime = $.FroalaEditor.MIME.formats[val.toLowerCase()];
				if(mime && !$format_arr[mime]) $format_arr.push(mime);
			});

			return $format_arr?$format_arr:['*'];
		},
		imageAllowedTypes: function(obj){
			if(obj == "*.*") return ['jpeg', 'jpg', 'png', 'gif'];
			if(typeof $.FroalaEditor.MIME == 'undefined') return;
			var $array = obj.split( ';' );
			var $format_arr = [];
			if($array.length < 1) $array.push(obj);

			$.each($array, function(i, val) {
				if(val.toLowerCase() == '*.jpeg') $format_arr.push('jpeg','jpg');
				else if(val.toLowerCase() == '*.jpg') $format_arr.push('jpeg','jpg');
				else if(val.toLowerCase() == '*.png') $format_arr.push('png');
				else if(val.toLowerCase() == '*.gif') $format_arr.push('gif');
			});

			return $format_arr?$format_arr:[];
		},
		autoSave: function(){
			if (confirm(saved_doc_message)) {
				var _saved_doc_title = $("input[name=_saved_doc_title]", $form).eq(0).val();
				var _saved_doc_content = $("input[name=_saved_doc_content]", $form).eq(0).val();
				var _saved_doc_document_srl = $("input[name=_saved_doc_document_srl]", $form).eq(0).val();

					$("[name=title]", $form).eq(0).val(_saved_doc_title);
					$("input[name=content]", $form).eq(0).val(_saved_doc_content);
					$("input[name=document_srl]", $form).eq(0).val(_saved_doc_document_srl);

					$(editor_params.editor_id).froalaEditor('events.trigger', 'save.params', [_saved_doc_document_srl]);
					$(editor_params.editor_id).froalaEditor('html.set', _saved_doc_content);
					$('.fr-counter').text($('.fr-element').text().length);

					var act = 'procEditorLoadSavedDocument';
			}
			else {
					var act = 'procEditorRemoveSavedDoc';
			}
			
			
		        $.ajax({
		          type: 'POST',
		          url: editor_params.url,
		          data: {
		          	module: 'editor',
		          	act: act,
		          	mid: current_mid,
		          	editor_sequence: editor_params.editorSequence
		          },
		          dataType: 'json',
				  contentType: 'application/json'
		        });
			
		},
		froalaEditor: function(cfg){

			var options = {
				cfg: cfg,
				charCounterCount: true, // Boolean.false
				charCounterMax: -1, // Number 140
				codeBeautifier: true, // Boolean false
				codeMirror: true, // Boolean false
				codeMirrorOptions: { // Specify the options for CodeMirror.
					indentWithTabs: true,
					lineNumbers: true,
					lineWrapping: true,
					mode: 'text/html',
					tabMode: 'indent',
					tabSize: 4
				},
				colorsBackground: // Array
				[
					'REMOVE', '#61BD6D', '#1ABC9C', '#54ACD2', '#2C82C9', '#9365B8', '#475577',
					'#CCCCCC', '#41A85F', '#00A885', '#3D8EB9', '#2969B0', '#553982', '#28324E',
					'#000000', '#F7DA64', '#FBA026', '#EB6B56', '#E25041', '#A38F84', '#EFEFEF',
					'#FFFFFF', '#FAC51C', '#F37934', '#D14841', '#B8312F', '#7C706B', '#D1D5D8'
				],
				colorsDefaultTab: 'text', // String background
				colorsStep: 7, // Number 7
				colorsText: // Array
				[
					'REMOVE', '#61BD6D', '#1ABC9C', '#54ACD2', '#2C82C9', '#9365B8', '#475577',
					'#CCCCCC', '#41A85F', '#00A885', '#3D8EB9', '#2969B0', '#553982', '#28324E',
					'#000000', '#F7DA64', '#FBA026', '#EB6B56', '#E25041', '#A38F84', '#EFEFEF',
					'#FFFFFF', '#FAC51C', '#F37934', '#D14841', '#B8312F', '#7C706B', '#D1D5D8'
				],
				direction: 'auto', // String auto, ltr, rtl
				disableRightClick: false, // Boolean true
				editInPopup: false, //
				editorClass: '', // String custom-class
				//emoticonsSet: [] // emoticons.js
				emoticonsStep: 8, // Number 10
				enter: $.FroalaEditor.ENTER_P, // String ENTER_P ENTER_BR ENTER_DIV
				//entities: '', // entities.js
				fileAllowedTypes:$.froalaEditorObj.fileAllowedTypes(cfg.allowedFileTypes), // Array ['application/pdf', 'application/msword']
				fileMaxSize: cfg.uploadMaxFileSize, // Number
				fileInsertButtons: ['fileBack', '|'],
				fileUploadMethod: 'POST',
				fileUploadParam: 'Filedata',
				fileUploadParams:{
					PHPSESSID : getCookie(cfg.sessionName),
					editor_sequence : cfg.editorSequence,
					vid : (function() { if(typeof xeVid !== 'undefined') return xeVid; else return ''; })(),
					mid : current_mid,
					act : "procFileUpload",
					upload_target_srl : false
				},
				//fileUploadToS3: {},
				fileUploadURL: cfg.url,
				fileUseSelectedText: false,
				fontFamily: {
					'Arial,Helvetica,sans-serif': 'Arial',
					'Georgia,serif': 'Georgia',
					'Impact,Charcoal,sans-serif': 'Impact',
					'Tahoma,Geneva,sans-serif': 'Tahoma',
					"'Times New Roman',Times,serif": 'Times New Roman',
					'Verdana,Geneva,sans-serif': 'Verdana'
				},
				fontFamilySelection: false,
				fontSize: ['0.6em', '0.8em', '1.0em', '1.2em', '1.5em', '2em', '8px', '9px', '10px', '11px', '12px', '14px', '18px', '24px', '30px', '36px', '48px', '60px', '72px', '96px'],
				fontSizeSelection: false,
				fullPage: false,
//				height: cfg.editor_height,
				heightMin: cfg.editor_height+'px',
//				heightMax: cfg.editor_height+'px',
				htmlAllowComments: true,
				htmlAllowedAttrs: ['*'],
				htmlAllowedEmptyTags: ['textarea', 'i', 'iframe', 'object', 'video', 'style', 'script'],
				htmlAllowedTags: ['a', 'abbr', 'address', 'area', 'article', 'aside', 'audio', 'b', 'base', 'bdi', 'bdo', 'blockquote', 'br', 'button', 'canvas', 'caption', 'cite', 'code', 'col', 'colgroup', 'datalist', 'dd', 'del', 'details', 'dfn', 'dialog', 'div', 'dl', 'dt', 'em', 'embed', 'fieldset', 'figcaption', 'figure', 'footer', 'form', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'header', 'hgroup', 'hr', 'i', 'iframe', 'img', 'input', 'ins', 'kbd', 'keygen', 'label', 'legend', 'li', 'link', 'main', 'map', 'mark', 'menu', 'menuitem', 'meter', 'nav', 'noscript', 'object', 'ol', 'optgroup', 'option', 'output', 'p', 'param', 'pre', 'progress', 'queue', 'rp', 'rt', 'ruby', 's', 'samp', 'script', 'style', 'section', 'select', 'small', 'source', 'span', 'strike', 'strong', 'sub', 'summary', 'sup', 'table', 'tbody', 'td', 'textarea', 'tfoot', 'th', 'thead', 'time', 'title', 'tr', 'track', 'u', 'ul', 'var', 'video', 'wbr'],
				htmlRemoveTags: ['script', 'style', 'link'],
				htmlSimpleAmpersand: false,
				iframe: false,
				iframeStyle: 'html{margin:0px;}body{padding:10px;background:transparent;color:#000000;position:relative;z-index:2;-webkit-user-select:auto;margin:0px}body:after{content:"";clear:both;display:block}hr{clear:both;user-select:none;-o-user-select:none;-moz-user-select:none;-khtml-user-select:none;-webkit-user-select:none;-ms-user-select:none;}pre{white-space:pre-wrap;word-wrap:break-word;}',
				imageAllowedTypes: $.froalaEditorObj.imageAllowedTypes(cfg.allowedFileTypes),
				imageAltButtons: ['imageBack', '|'],
				imageDefaultAlign: 'center', // left right
				imageDefaultDisplay: 'block', // inline
				imageDefaultWidth: '300',
				imageEditButtons: ['imageReplace', 'imageAlign', 'imageRemove', '|', 'imageLink', 'linkOpen', 'linkEdit', 'linkRemove', '-', 'imageDisplay', 'imageStyle', 'imageAlt', 'imageSize'],
				imageIframeStyle: 'body img {max-width:100%;}body img{z-index:3;position:relative;overflow:auto;cursor:pointer}body img.fr-dib{margin:auto;display:block;float:none;vertical-align:top}body img.fr-dib.fr-fil{margin:5px auto 5px 0}body img.fr-dib.fr-fir{margin:5px 0 5px auto}body img.fr-dii{margin:auto;display:inline-block;float:none}body img.fr-dii.fr-fil{margin:5px 5px 5px 0;float:left}body img.fr-dii.fr-fir{margin:5px 0 5px 5px;float:right}',
				imageInsertButtons: ['imageBack', '|', 'imageUpload', 'imageByURL', 'imageManager'],
				imageManagerDeleteMethod: 'POST', // DELETE
				imageManagerDeleteParams: {
					editor_sequence : cfg.editorSequence,
					module : "file",
					act : "procFileDelete",
					upload_target_srl : false
				},
				imageManagerDeleteURL: cfg.url,
				imageManagerLoadMethod: 'POST', // POST
				imageManagerLoadParams: {
					vid : (function() { if(typeof xeVid !== 'undefined') return xeVid; else return ''; })(),
					mid : current_mid,
					module : 'file',
					act : 'getFileList',
					editor_sequence   : cfg.editorSequence
				},
				imageManagerLoadURL: cfg.url,
				imageManagerPageSize: 100,
				imageManagerPreloader: '', // /images/loader.gif
				imageManagerScrollOffset: 0, // 10
				imageMaxSize: cfg.uploadMaxFileSize,
				imageMove: true,
				imageMultipleStyles: true,
				imagePaste: true,
				imageResize: true,
				imageResizeWithPercent: false, // true
				imageSizeButtons: ['imageBack', '|'],
				imageStyles: {
//					rounded: 'Rounded', // class1: 'Class 1'
//					bordered: 'Bordered'
				},
				imageTextNear: true, // false
				imageUploadMethod: 'POST',
				imageUploadParam: 'Filedata',
				imageUploadParams: {
					PHPSESSID : getCookie(cfg.sessionName),
					editor_sequence : cfg.editorSequence,
					vid : (function() { if(typeof xeVid !== 'undefined') return xeVid; else return ''; })(),
					mid : current_mid,
					act : "procFileUpload",
					upload_target_srl : false
				},
				//imageUploadToS3: {},
				imageUploadURL: cfg.url,
				initOnClick: false,
				inlineStyles: {
//					'Big Red': 'font-size: 20px; color: red;',
//					'Small Blue': 'font-size: 14px; color: blue;'
				},
				language: null,
				lineBreakerOffset: 10,
				lineBreakerTags: ['table', 'hr', 'iframe', 'form', 'dl', 'div'],
				linkAlwaysBlank: false,
				linkAlwaysNoFollow: true,
				linkAttributes: {
					title: 'Title'
				},
				linkAutoPrefix: '//', // http:// https://
				linkConvertEmailAddress: true,
				linkEditButtons: ['linkOpen', 'linkStyle', 'linkEdit', 'linkRemove'],
				linkInsertButtons: ['linkBack', '|', 'linkList'],
				linkList: [
					{
				      text: 'Google',
				      href: 'http://google.com',
				      target: '_blank'
				    },
				    {
				      text: 'Froala',
				      href: 'https://froala.com',
				      target: '_blank'
				    },
				    {
				      text : request_uri,
				      href: request_uri,
				      target: '_blank'
				    }
				],
				linkMultipleStyles: false,
				linkStyles: {
//					blue: 'Blue',
//					red: 'Red'
				},
				linkText: true,
				multiLine: true,
				paragraphFormat: {
					N: 'NORMAL',
					H1: 'H1',
					H2: 'H2',
					H3: 'H3',
					H4: 'H4',
					H5: 'H5',
					H6: 'H6',
					DIV: 'DIV',
					P: 'P',
					PRE: 'PRE'
				},
				paragraphFormatSelection: false,
				paragraphMultipleStyles: false,
				paragraphStyles: {
//					class1: 'Class 1',
//					class2: 'Class 2',
//					class3: 'Class 3'
				},
				pasteDeniedAttrs: [],
				pasteDeniedTags: ['script', 'style', 'link'],
				pastePlain: false,
				placeholderText: 'Type Something',
				requestHeaders: {
					//custom_header: 'My custom header data.'
				},
				requestWithCORS: true,
				saveInterval: 10000,
				saveMethod: 'POST',
				saveParam: 'content',
				saveParams: {
					module: 'editor',
					act: 'procEditorSaveDoc',
					mid: current_mid,
				},
				saveURL: cfg.url,
				shortcutsEnabled: ['show', 'bold', 'italic', 'underline', 'strikeThrough', 'indent', 'outdent', 'undo', 'redo', 'insertImage', 'createLink', 'quote'],
				spellcheck: true,
				tabSpaces: 4,
				tableCellMultipleStyles: true,
				tableCellStyles: {
					'normal': 'normal',
					'design-set-white': 'design set(white)',
					'design-set-blue': 'design set(blue)',
				},
				tableColors: 
				[
					'REMOVE', '#61BD6D', '#1ABC9C', '#54ACD2', '#2C82C9', '#9365B8', '#475577',
					'#CCCCCC', '#41A85F', '#00A885', '#3D8EB9', '#2969B0', '#553982', '#28324E',
					'#000000', '#F7DA64', '#FBA026', '#EB6B56', '#E25041', '#A38F84', '#EFEFEF',
					'#FFFFFF', '#FAC51C', '#F37934', '#D14841', '#B8312F', '#7C706B', '#D1D5D8'
				],
				tableColorsButtons: ['tableBack', '|'],
				tableColorsStep: 7,
				tableEditButtons: ['tableHeader', 'tableCells', 'tableVerticalAlign', 'tableCellBackground', 'tableCellStyle', '-', 'tableRows', 'tableColumns', 'align', 'tableDisplay', 'tableRemove'],
				tableIframeStyle: 'body table{border:none;border-collapse:collapse;empty-cells:show;max-width:100%}body table td,body table th{border:1px solid #ddd}body table td:empty,body table th:empty{height:20px}table td.fr-selected-cell,table th.fr-selected-cell{border:1px double #1e88e5}.fr-no-selection table td,.fr-no-selection table th,table tr{user-select:none;-o-user-select:none;-moz-user-select:none;-khtml-user-select:none;-webkit-user-select:none;-ms-user-select:none}table td,table th{user-select:text;-o-user-select:text;-moz-user-select:text;-khtml-user-select:text;-webkit-user-select:text;-ms-user-select:text}',
				tableInsertButtons: ['tableBack', '|'],
				tableInsertMaxSize: 10,
				tableResizerOffset: 5,
				tableResizingLimit: 30,
				theme: null,
				toolbarBottom: false,
				toolbarButtons: ['login', '|', 'bold', 'italic', 'underline', 'strikeThrough', 'subscript', 'superscript', 'fontFamily', 'fontSize', '|','color', 'inlineStyle', 'paragraphStyle', 'sourceCode', '|', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'outdent', 'indent', 'quote', '|', 'insertTable', 'insertHR', '|', 'insertLink', 'insertImage', 'insertVideo', 'insertFile', 'imageManager', '|',  'clearFormatting', 'selectAll', 'undo', 'redo', '|', 'editor_component', 'emoticons', 'blockElement', 'html', 'fullscreen'],
				toolbarButtonsMD: ['bold', 'italic', 'underline', 'strikeThrough', 'fontFamily', 'fontSize', '|','color', 'inlineStyle', 'paragraphStyle', 'sourceCode', '|', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'outdent', 'indent', 'quote', '|', 'insertTable', 'insertHR', '|', 'insertLink', 'insertImage', 'insertVideo', 'insertFile', 'imageManager', '|', 'clearFormatting', 'selectAll', 'undo', 'redo', '|', 'editor_component', '|', 'blockElement', 'html', 'fullscreen'],
				toolbarButtonsSM: ['strikeThrough', 'fontSize', 'color', 'inlineStyle', 'paragraphStyle', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'outdent', 'indent', 'quote', 'insertImage', 'insertVideo', 'selectAll', 'undo', 'redo'],
				toolbarButtonsXS: ['color', 'paragraphFormat', 'align', 'quote', 'insertImage', 'insertVideo', 'selectAll', 'undo', 'redo', 'fullscreen'],
				toolbarButtonsSXS: ['color', 'paragraphFormat', 'align', 'quote', 'insertImage', 'undo', 'redo'],
				toolbarInline: false,
				toolbarVisibleWithoutSelection: false,
				toolbarSticky: true,
				toolbarStickyOffset: 0,
				typingTimer: 500,
				useClasses: true,
				videoDefaultAlign: 'center', // left right
				videoDefaultDisplay: 'block', // inline
				videoEditButtons: ['videoDisplay', 'videoAlign', 'videoSize', 'videoRemove'],
				videoIframeStyle: '.fr-video{text-align:center;position:relative}.fr-video:after{position:absolute;content:"";z-index:1;top:0;left:0;right:0;bottom:0;cursor:pointer}.fr-video.fr-active>*{z-index:2;position:relative}.fr-video.fr-dvb{display:block;clear:both}.fr-video.fr-dvb.fr-fvl{text-align:left}.fr-video.fr-dvb.fr-fvr{text-align:right}.fr-video.fr-dvi{display:inline-block}.fr-video.fr-dvi.fr-fvl{float:left}.fr-video.fr-dvi.fr-fvr{float:right}',
				videoInsertButtons: ['videoBack', '|', 'videoByURL', 'videoEmbed'],
				videoResize: true,
				videoSizeButtons: ['videoBack', '|'],
				videoTextNear: true,
				width: 'auto',
				editorComponents: {
//				    'opt1': 'Option 1',
//				    'opt2': 'Option 2'
			    },
				editorComponentOptions: {
					editorComponentURL: '',
					editorComponentAction: 'dispEditorPopup'
				},
				'\u006B\u0065\u0079': $f()
			};



			if(isMobile()) {
				options.linkAttributes = false;
				options = $.extend(options, {
					toolbarSticky: true,
					heightMin: '100px',
				toolbarButtonsMD: ['strikeThrough', 'fontSize', 'color', 'inlineStyle', 'paragraphStyle', 'sourceCode', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'outdent', 'indent', 'quote', 'insertImage', 'insertVideo', 'clearFormatting', 'selectAll', 'undo', 'redo', 'editor_component', 'blockElement', 'html', 'fullscreen'],
				toolbarButtonsSM: ['strikeThrough', 'fontSize', 'color', 'inlineStyle', 'paragraphStyle', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'outdent', 'indent', 'quote', 'insertImage', 'insertVideo', 'selectAll', 'undo', 'redo'],
				toolbarButtonsXS: ['paragraphFormat', 'align', 'quote', 'insertImage', 'insertVideo', 'undo', 'redo', 'selectAll', 'fullscreen'],
				toolbarButtonsSXS: ['paragraphFormat', 'align', 'quote', 'insertImage', 'insertVideo', 'undo', 'redo'],
				});
			}

			$(cfg.editor_id).froalaEditor(
				$.extend({}, options, cfg.editorOptions)
			)
			// events
			.on('froalaEditor.paste.beforeCleanup', function (e, editor, clipboard_html) { //console.log('beforeCleanup');
				// 다른곳에서 복사해서 붙여넣기를 하는 순간에 처리하기 전에 실시합니다.
			})
			.on('froalaEditor.blur', function (e, editor) { //console.log('blur');
				// 에디터에서 벗어날 때
				//editor.fullscreen.toggle();
				//$(cfg.editor_id).froalaEditor('fullscreen.toggle');
			})
			.on('froalaEditor.buttons.refresh', function (e, editor) { //console.log('buttons.refresh');
				// 에디터 메뉴 버튼의 초기화를 할 경우 발생
			})
			.on('froalaEditor.charCounter.exceeded', function (e, editor) { //console.log('charCounter.exceeded');
				// 입력 글자수가 넘었을때(maxCharNumber) 발생
			})
			.on('froalaEditor.charCounter.update', function (e, editor) { //console.log('charCounter.update');
				// 입력 글자수에 변화가 있을 때 발생
			})
			.on('froalaEditor.commands.before', function (e, editor, cmd, param1, param2) { //console.log('commands.before');
				/* 이 이벤트는 에디터에서 실행되는 모든 버튼 명령을 처리하기 전에 동작하게 됩니다.
				 * 자세한 파라메타 정보는 아래주소를 참고하세요.
				 * https://www.froala.com/wysiwyg-editor/v2.0/docs/events#commands.before 
				*/
				if(cmd == 'align')
				{
					if(param1 == 'left')
					{
						console.log('align.left');
					}
				}
			})
			.on('froalaEditor.commands.after', function (e, editor, cmd, param1, param2) { //console.log('ommands.after');
				/* 이 이벤트는 에디터에서 실행되는 모든 버튼 명령의 처리 후에 동작하게 됩니다.
				 * 자세한 파라메타 정보는 아래주소를 참고하세요.
				 * https://www.froala.com/wysiwyg-editor/v2.0/docs/events#commands.after 
				*/
				if(cmd == 'align')
				{
					if(param1 == 'left')
					{
						console.log('align.left');
					}
				}
			})
			.on('froalaEditor.contentChanged', function (e, editor) { //console.log('contentChanged'); //★
				// 에디터안의 내용물이 변화했을때 발생합니다.
				changeQueue = false;

				if(editor.$el.find('> .fr-element').attr('contenteditable')) {
					editor.html.set(editor.$el.find('.fr-element').html());
				}

				if(typeof editor.image != 'undefined') editor.image.setFigure();
			})
			.on('froalaEditor.contentClean', function (e, editor) { //console.log('contentClean'); //★
				// 에디터안의 내용물에 불필요한 값을 제거 합니다.
				editor.$el.find('div').each(function(i, div){
					if($(div).html().length == 0) $(div).remove();
				});

				editor.$el.find('img').each(function(i, img){
					if($(img).attr('src').match(/act=(dispMember|procMember)/gi)) {
						$(img).remove();
					}
				});
			})
			.on('froalaEditor.destroy', function (e, editor) { //console.log('destroy');
				// 에디터 수행을 완전 종료할때 발생합니다.
				//$(this).froalaEditor(); // 종료 후 제 시작
			})
			.on('froalaEditor.file.beforeUpload', function (e, editor, files) {// console.log('file.beforeUpload');
				// 파일을 첨부하기 전의 트리거
			})
			.on('froalaEditor.file.inserted', function (e, editor, $file, response) { //console.log('file.inserted');
				// 파일 업로드 요청이 완료된 경우 발생
				editor.events.trigger('contentChanged');
			})
			.on('froalaEditor.file.unlink', function (e, editor, link) { //console.log('file.unlink');
				// 파일의 링크를 제거 할때 발생
			})
			.on('froalaEditor.file.uploaded', function (e, editor, data) { //console.log('file.uploaded');
				// 파일 업로드가 완료된 후 발생
				if(!editor.opts.fileUploadParams.upload_target_srl) editor.opts.fileUploadParams.upload_target_srl = data.upload_target_srl;

				if(!$("input[name=document_srl]", $form).eq(0).val()) $("input[name=document_srl]", $form).eq(0).val(data.upload_target_srl);
				else $("input[name=comment_srl]", $form).eq(0).val(data.upload_target_srl);

				if($('.fr-modal').css('display') == 'block') {
					editor.imageManager.hide();
					editor.imageManager.show();
				}

				if(typeof editor.save != 'undefined') editor.save.save();
			})
			.on('froalaEditor.file.error', function (e, editor, error, response) {// console.log('file.error');
				// 파일을 업로드 도중 실패했을때 발생
				var response = $.parseJSON(response);
				if(response == null) var message = $.froalaEditorObj.translate(error.message);
				else if(response.error != -1) var message = $.froalaEditorObj.translate(error.message);
				else var message = response.message;

			      editor.file.showProgressBar();
			      var $popup = editor.popups.get('file.insert');
			      var $layer = $popup.find('.fr-file-progress-bar-layer');
			      $layer.addClass('fr-error');
			      $layer.find('h3').text(message);
			})
			.on('froalaEditor.file.uploadedToS3', function (e, editor, link, key, response) { //console.log('file.uploadedToS3');
				// S3에 파일 업로드가 완료된 후 발생
			})
			.on('froalaEditor.focus', function (e, editor) { //console.log('focus');
				// 에디터에 포커스가 될 경우 발생
				//editor.fullscreen.toggle();
				if(editor.helpers.isMobile()) {
					setTimeout(function () {
						var top = editor.position.getBoundingRect().top;
						var document_scroll = editor.$document.scrollTop();
						var wp_scroll = editor.$wp.scrollTop();
						var limitTop = 60;
						var limitBottom = screen.availHeight - virtualKeyboard();
						if(top > limitBottom) var scroll_top = limitBottom;
						else if(top < limitTop) var scroll_top = limitTop;
						if(scroll_top) {
							if(!editor.$box.hasClass('fr-fullscreen')) {
								if(!editor.opts.ro_scroll) {
									editor.opts.ro_scroll = true;
							        setTimeout(function () {
										$('body').animate({scrollTop: (document_scroll - (scroll_top - top))}, 300);
									editor.opts.ro_scroll = false;
									}, 300);
								}
							}
							else if(editor.$box.hasClass('fr-fullscreen')) {
									editor.$wp.scrollTop(wp_scroll - (scroll_top - top));
							}
						}
					}, 300);
				}
			})
			.on('froalaEditor.html.beforeGet', function (e, editor) { //console.log('html.beforeGet');
				// html.get 메소드가 발생하기 전에 발생
			})
			.on('froalaEditor.html.afterGet', function (e, editor) { //console.log('html.afterGet');
				// html.get 메소드가 발생한 후 발생
			})
			.on('froalaEditor.html.get', function (e, editor, html) {// console.log('html.get'); // ★
				// 에디터의 html이 저장되거나 동기화 될때 사용됩니다. 반환 변수에 새로운 값을 넣으면 그 값을 추가 적용합니다.
				changeQueue = false;
			})
			.on('froalaEditor.html.set', function (e, editor) { //console.log('html.set');
				// HTML가 에디터에 적용된 후에 발생합니다.
				if(editor.helpers.isMobile()) {
					editor.$el.find('iframe').each(function(i, iframe){
						$(iframe).attr('src', $(iframe).attr('src'));
					});
				}
			})
			.on('froalaEditor.image.beforePasteUpload', function (e, editor, img) { //console.log('image.beforePasteUpload');
				// 이미지 업로드 메뉴에서 외부 이미지 URL을 추가할 경우 발생
			})
			.on('froalaEditor.image.beforeRemove', function (e, editor, $img) {// console.log('image.beforeRemove');
				// 이미지 편집 메뉴에서 이미지 삭제 버튼을 누를때 발생
				// 이미지 삭제와 동시에 서버의 첨부파일도 삭제할때에 사용할 수 있음
			})
			.on('froalaEditor.image.beforeUpload', function (e, editor, images) {// console.log('image.beforeUpload');
				// 이미지를 서버에 업로드 하기전에 발생
			})
			.on('froalaEditor.image.error', function (e, editor, error, response) {// console.log('image.error');
				// 이미지를 업로드 도중 실패했을때 발생
				var response = $.parseJSON(response);
				if(response == null) var message = $.froalaEditorObj.translate(error.message);
				else if(response.error != -1) var message = $.froalaEditorObj.translate(error.message);
				else var message = response.message;

			      editor.image.showProgressBar();
			      var $popup = editor.popups.get('image.insert');
			      var $layer = $popup.find('.fr-image-progress-bar-layer');
			      $layer.addClass('fr-error')
			      $layer.find('h3').text(message);
			})
			.on('froalaEditor.image.inserted', function (e, editor, $img, response) { //console.log('image.inserted');
				// 이미지가 업로드 되어 에디터에 추가 될때 발생
				editor.events.trigger('contentChanged');
			})
			.on('froalaEditor.image.loaded', function (e, editor, $img) { //console.log('image.loaded');
				// 업로드 되어 에디터에 첨부된 이미지의 로딩이 완료될 때 밠생
			})
			.on('froalaEditor.image.removed', function (e, editor, $img) { //console.log('image.removed');
				// 이미지 편집 메뉴에서 이미지 삭제 버튼을 누를때 발생
				// 이미지 삭제와 동시에 서버의 첨부파일도 삭제할때에 사용할 수 있음
			})
			.on('froalaEditor.image.replaced', function (e, editor, $img, response) { //console.log('image.replaced');
				// 이미지 교체가 진행 될 경우 발생
			})
			.on('froalaEditor.image.resize', function (e, editor, $img) { //console.log('image.resize');
				// 이미지를 조정하는 동안 발생
			})
			.on('froalaEditor.image.resizeEnd', function (e, editor, $img) { //console.log('image.resizeEnd');
				// 이미지의 조정이 끝났을 때 발생
			})
			.on('froalaEditor.image.uploaded', function (e, editor, data) { //console.log('image.uploaded');
				// 이미지의 업로드가 완료 된 후 발생
				if(!editor.opts.imageUploadParams.upload_target_srl) editor.opts.imageUploadParams.upload_target_srl = data.upload_target_srl;

				if(!$("input[name=document_srl]", $form).eq(0).val()) $("input[name=document_srl]", $form).eq(0).val(data.upload_target_srl);
				else $("input[name=comment_srl]", $form).eq(0).val(data.upload_target_srl);

				if($('.fr-modal').css('display') == 'block') {
					editor.imageManager.hide();
					editor.imageManager.show();
				}

				if(typeof editor.save != 'undefined') editor.save.save();
			})
			.on('froalaEditor.image.uploadedToS3', function (e, editor, link, key, response) { //console.log('image.uploadedToS3');
				// S3에 이미지의 업로드가 완료 된 후 발생
			})
			.on('froalaEditor.imageManager.beforeDeleteImage', function (e, editor, $img) { //console.log('imageManager.beforeDeleteImage');
				// 이미지 관리 메뉴에서 이미지를 삭제하기 전에 발생
			})
			.on('froalaEditor.imageManager.error', function (e, editor, error, response) {// console.log('imageManager.error');
				// 이미지 관리 메뉴에서 처리 중 문제가 발생활 경우 발생
			})
			.on('froalaEditor.imageManager.imageDeleted', function (e, editor, data) {// console.log('imageManager.imageDeleted');
				// 이미지 관리 메뉴에서 이미지 삭제가 완료 된 후 발생
			})
			.on('froalaEditor.imageManager.imageLoaded', function (e, editor, $img) {// console.log('imageManager.imageLoaded');
				// 이미지 관리 메뉴에서 이미지 로드가 완료된 경우 발생
			})
			.on('froalaEditor.imageManager.imagesLoaded', function (e, editor, data) { //console.log('imageManager.imagesLoaded');
				// 이미지 관리 메뉴에서 이미지 로드가 완료된 경우 발생(전체)
			})
			.on('froalaEditor.initialized', function (e, editor) {// console.log('initialized');
				// 에디터 편집기의 초기화가 왼료 되면 발생(의미상 있을뿐 동작하지 않음 ready()를 이용바람)
			})
			.on('froalaEditor.link.bad', function (e, editor, original_href) {// console.log('link.bad');
				// 잘못된 형식의 link 주소가 입력될 때 발생
			})
			.on('froalaEditor.paste.after', function (e, editor) { //console.log('paste.after');
				// 본문 붙여넣기가 완료 된 후 발생
			})
			.on('froalaEditor.paste.afterCleanup', function (e, editor, clipboard_html) { //console.log('paste.afterCleanup');
				// 다른곳에서 복사해서 붙여넣기를 처리한 후에 실시합니다.
			})
			.on('froalaEditor.paste.before', function (e, editor, event) { //console.log('paste.before');
				// 본문 붙여넣기가 완료 된 후 발생
			})
			.on('froalaEditor.popups.hide.[id]', function (e, editor) { //console.log('popups.hide.[id]');
				// 팝업형 버튼이 화면에서 사라질때 발생
				// 해당 팝업 id는 값을 입력(id="id" 요거 아님, 버튼 아이디임)
			})
			.on('froalaEditor.save.params', function (e, editor, document_srl) { //console.log('save.params');
				if(!document_srl) return false;
				editor.opts = $.extend(editor.opts, {
					imageUploadParams : $.extend(editor.opts.imageUploadParams, {				
						upload_target_srl: document_srl
					}),
					fileUploadParams : $.extend(editor.opts.fileUploadParams, {
						upload_target_srl: document_srl					
					}),
					imageManagerLoadParams : $.extend(editor.opts.imageManagerLoadParams, {
						upload_target_srl: document_srl
					}),
					imageManagerDeleteParams : $.extend(editor.opts.imageManagerDeleteParams, {
						upload_target_srl: document_srl
					})
				});
			})
			.on('froalaEditor.save.before', function (e, editor) { //console.log('save.before');
				saved_title = $("[name=title]", $form).eq(0).val();
				saved_content = $("input[name=content]", $form).eq(0).val($(cfg.editor_id).froalaEditor('html.get', true).replace("FROALA-EMFROALA-SM",""));

				if(!saved_title && !saved_content.eq(0).val() && !$("input[name=document_srl]", $form).val()) return false;

				// 저장 수행을 하기 전에 발생
				editor.opts.saveParams = $.extend(editor.opts.saveParams, {
					title : saved_title,
					content : saved_content.eq(0).val(),
					document_srl : editor.opts.imageUploadParams.upload_target_srl,
				});
			})
			.on('froalaEditor.save.after', function (e, editor, data) {// console.log('save.after');
				// 저장 수행이 완료 된 후 발생
			})
			.on('froalaEditor.save.error', function (e, editor, error) {// console.log('save.error');
				// 저장이 수행 중에 에러 발생시 발생
			})
			.on('froalaEditor.snapshot.before', function (e, editor) {// console.log('snapshot.before');
				// 스냅샷 처리 전에 발생
			})
			.on('froalaEditor.snapshot.after', function (e, editor) {// console.log('snapshot.after');
				// 스냅샷 처리 후에 발생
			})
			.on('froalaEditor.toolbar.hide', function (e, editor) { //console.log('toolbar.hide');
				// 툴바가 사라질때 발생
			})
			.on('froalaEditor.toolbar.show', function (e, editor) { //console.log('toolbar.show');
				// 툴바가 보여질때 발생
			})
			.on('froalaEditor.video.codeError', function (e, editor, code) {// console.log('video.codeError');
				// 비디오 태그를 삽입때 에러가 발생때 수행
			})
			.on('froalaEditor.video.inserted', function (e, editor, $video) {// console.log('video.inserted');
				// 비디오 태그 삽입이 완료 된 후 발생
				if(editor.helpers.isMobile()) {
					$($video).find('iframe').attr('src', $($video).find('iframe').attr('src'));
				}

				editor.events.trigger('contentChanged');
			})
			.on('froalaEditor.video.linkError', function (e, editor, link) {// console.log('video.linkError');
				// 비디오 태그의 링크 주소에 문제가 있을시 발생
			})
			.on('froalaEditor.video.removed', function (e, editor, $video) { //console.log('video.removed');
				// 비디오 태그를 제거한 후 발생
			})
			.on('froalaEditor.video.beforeRemove', function (e, editor, $video) { //console.log('video.beforeRemove');
				// 비디오 태그를 제거하기 전에 발생
			})
			.on('froalaEditor.keyup', function (e, editor, event) {// console.log('keydown');
				// 키를 누른 후 발생
				changeQueue = true;
				if(editor.helpers.isMobile()) {
					var top = editor.position.getBoundingRect().top;
					var document_scroll = editor.$document.scrollTop();
					var wp_scroll = editor.$wp.scrollTop();
					var limitTop = 60;
					var limitBottom = screen.availHeight - virtualKeyboard();
					if(top > limitBottom) var scroll_top = limitBottom;
					else if(top < limitTop) var scroll_top = limitTop;
					if(scroll_top) {
						if(!editor.$box.hasClass('fr-fullscreen')) {
							if(!editor.opts.ro_scroll) {
								editor.opts.ro_scroll = true;
						        setTimeout(function () {
									$('body').animate({scrollTop: (document_scroll - (scroll_top - top))}, 300);
								editor.opts.ro_scroll = false;
								}, 300);
							}
						}
						else if(editor.$box.hasClass('fr-fullscreen')) {
								editor.$wp.scrollTop(wp_scroll - (scroll_top - top));
						}
					}
				}
			})
			.on('froalaEditor.mousedown', function (e, editor, e) {// console.log('keydown');
				if(isIOS() && !editor.$box.hasClass('fr-fullscreen')) {
//					editor.fullscreen.toggle();
//					editor.selection.focus();
				}
			})
			.on('froalaEditor.ready', function (e, editor, e) {// console.log('keydown');
				if(editor.helpers.isMobile()) {
					editor.opts.roSticky = editor.$tb.offset().top;
				}

				$('.fr-dropdown-content').css('max-height','205px');
			})
			.ready(function() {
				$(cfg.editor_id).froalaEditor('events.trigger', 'ready');

				//$(cfg.editor_id).froalaEditor('fullscreen.toggle');
				if(typeof autoSaveCheck != 'undefined' && autoSaveCheck == true) $.froalaEditorObj.autoSave();

				$form = $(cfg.editor_id).parent();
				while(!$form.attr('method') && $form[0].tagName != 'BODY') {
					$form = $form.parent();
				}

				if($("input[name=content]", $form).size()>0&&$("input[name=content]", $form).val().length>0) {
//					saved_content = $("input[name=content]", $form).eq(0).val().replace(/src=\"files\/attach/g,'src="'+request_uri+'files/attach');
					saved_content = $("input[name=content]", $form).eq(0).val();
					saved_content = $(cfg.editor_id).froalaEditor('clean.html', saved_content, options.pasteDeniedTags, options.pasteDeniedAttrs);
					$(cfg.editor_id).froalaEditor('html.set', saved_content);

					$(cfg.editor_id).froalaEditor('events.focus');
					$(cfg.editor_id).froalaEditor('events.trigger', 'contentChanged');
				}

				if($("input[name=content]", $form).length==0) {
					$form.append('<input type="hidden" name="content" value="" />');
					if(isMobile()) $form.append('<input type="hidden" name="use_html" value="Y" />');
				}

				$("input[type=submit],button[type=submit]", $form).on("click", function(e){
				$(cfg.editor_id).froalaEditor('events.trigger', 'contentClean');
				
					$("input[name=content]", $form).eq(0).val($(cfg.editor_id).froalaEditor('html.get', true).replace("FROALA-EMFROALA-SM",""));
					$("input[name=content]", $form).eq(0).val($(cfg.editor_id).froalaEditor('html.get', true).replace("FROALA-EMFROALA-SM",""));

					if(changeQueue == true) {
						e.preventDefault();
						e.stopPropagation();

						$(cfg.editor_id).on('froalaEditor.contentChanged', function (e, editor, html) {

							$form.trigger("submit");
						});
					}
				});
			});
		},
	};

/* 게시글 저장 */
window.doDocumentSave = _doDocumentSave;
function _doDocumentSave(obj) {
	if(!$("[name=title]", obj.form).eq(0).val() && !saved_content && !$("input[name=document_srl]", obj.form).eq(0).val()) {
		alert('There is nothing to save content.');
		return false;
	}

	var content = $("input[name=content]", obj.form).eq(0).val($(editor_params.editor_id).froalaEditor('html.get', true).replace("FROALA-EMFROALA-SM",""));
	var params = {};
	var elms = obj.form.elements;
	var data = $(obj.form).serializeArray();

	jQuery.each(data, function(i, field){
		var val = $.trim(field.value);
		if(!val) return true;
		if(/\[\]$/.test(field.name)) field.name = field.name.replace(/\[\]$/, '');
		if(params[field.name]) params[field.name] += '|@|'+val;
		else params[field.name] = field.value;
	});

	exec_json(
		'document.procDocumentTempSave',
		params,
		function(data) {
			if(data.error != 0) return;

			$('input[name=document_srl]', obj.form).eq(0).val(data.document_srl);
			$(editor_params.editor_id).froalaEditor('events.trigger', 'save.after', [data]);
		}
	);

	return false;
}

/* 저장된 게시글 불러오기 */
window.objForSavedDoc = null;
window.doDocumentLoad = _doDocumentLoad;
function _doDocumentLoad(obj) {
	// 저장된 게시글 목록 불러오기
	objForSavedDoc = obj.form;

	popopen(request_uri.setQuery('module','document').setQuery('act','dispTempSavedList'));
}

window.reloadFileList = _reloadFileList;
function _reloadFileList(cfg)
{
//	fnObj.upload.getFileList(cfg);
//	myUpload.custom.reloadFileList(uploadSettingObj[cfg.editorSequence]);
}

window.filesize = _filesize;

function _filesize(size)
{
	if(!size)
	{
		return '0Byte';
	}

	if(size === 1)
	{
		return '1Byte';
	}

	if(size < 1024)
	{
		return size+'Bytes';
	}

	if(size >= 1024 && size < 1024 * 1024)
	{
		return sprintf("%0.1fKB", size / 1024);
	}

	return sprintf("%0.2fMB", size / (1024 * 1024));
}

window.virtualKeyboard = _virtualKeyboard;
function _virtualKeyboard() {
	var height = 0;
	
	if(_isMobile()) {
		if(window.innerWidth > 767) { // ipad
			height = (window.innerWidth > window.innerHeight)? 502 : 164;
		}
		else {
			height = (window.innerWidth > window.innerHeight)? 488 : 363;
		}
	}

	return height;
}


window.isIOS = _isIOS;
function _isIOS () { return /(iPad|iPhone|iPod)/g.test(navigator.userAgent) && !_isWindowsPhone(); }
window.isAndroid = _isAndroid;
function _isAndroid () { return /(Android)/g.test(navigator.userAgent) && !_isWindowsPhone(); }
window.isBlackberry = _isBlackberry;
function _isBlackberry () { return /(Blackberry)/g.test(navigator.userAgent); }
window.isWindowsPhone = _isWindowsPhone;
function _isWindowsPhone () { return /(Windows Phone)/gi.test(navigator.userAgent); }
window.isMobile = _isMobile;
function _isMobile () { return _isAndroid() || _isIOS() || _isBlackberry(); }

/*!{id:"uupaa.js",ver:0.7,license:"MIT",author:"uupaa.js@gmail.com"}*/
window.sprintf || (function() {
	var _BITS = { i: 0x8011, d: 0x8011, u: 0x8021, o: 0x8161, x: 0x8261,
				X: 0x9261, f: 0x92, c: 0x2800, s: 0x84 },
		_PARSE = /%(?:(\d+)\$)?(#|0)?(\d+)?(?:\.(\d+))?(l)?([%iduoxXfcs])/g;

	window.sprintf = _sprintf;
	function _sprintf(format) {
		function _fmt(m, argidx, flag, width, prec, size, types) {
			if (types === "%") { return "%"; }
			var v = "", w = _BITS[types], overflow, pad;

			idx = argidx ? parseInt(argidx) : next++;

			w & 0x400 || (v = (av[idx] === void 0) ? "" : av[idx]);
			w & 3 && (v = (w & 1) ? parseInt(v) : parseFloat(v), v = isNaN(v) ? "": v);
			w & 4 && (v = ((types === "s" ? v : types) || "").toString());
			w & 0x20  && (v = (v >= 0) ? v : v % 0x100000000 + 0x100000000);
			w & 0x300 && (v = v.toString(w & 0x100 ? 8 : 16));
			w & 0x40  && (flag === "#") && (v = ((w & 0x100) ? "0" : "0x") + v);
			w & 0x80  && prec && (v = (w & 2) ? v.toFixed(prec) : v.slice(0, prec));
			w & 0x6000 && (overflow = (typeof v !== "number" || v < 0));
			w & 0x2000 && (v = overflow ? "" : String.fromCharCode(v));
			w & 0x8000 && (flag = (flag === "0") ? "" : flag);
			v = w & 0x1000 ? v.toString().toUpperCase() : v.toString();

			if (!(w & 0x800 || width === void 0 || v.length >= width)) {
			pad = Array(width - v.length + 1).join(!flag ? " " : flag === "#" ? " " : flag);
			v = ((w & 0x10 && flag === "0") && !v.indexOf("-"))
				? ("-" + pad + v.slice(1)) : (pad + v);
			}
			return v;
		}
		var next = 1, idx = 0, av = arguments;

		return format.replace(_PARSE, _fmt);
	}
});





  $.FroalaEditor.MODULES.clean = function (editor) {
    var $iframe, body;
    var allowedTagsRE, removeTagsRE, allowedAttrsRE;

    function _removeInvisible (node) {
      if (node.className && node.className.indexOf('fr-marker') >= 0) return false;

      var contents = editor.node.contents(node);
      var markers = [];
      var i;

      // Get markers.
      for (i = 0; i < contents.length; i++) {
        if (contents[i].className && contents[i].className.indexOf('fr-marker') >= 0) {
          markers.push(contents[i]);
        }
      }

      // Reasess contents.
      if (contents.length - markers.length == 1 && node.textContent.replace(/\u200b/g, '').length === 0) {
        for (i = 0; i < markers.length; i++) {
          node.parentNode.insertBefore(markers[i].cloneNode(true), node);
        }
        node.parentNode.removeChild(node);
        return false;
      }

      for (i = 0; i < contents.length; i++) {
        if (contents[i].nodeType == Node.ELEMENT_NODE) {
          if (contents[i].textContent.replace(/\u200b/g, '').length != contents[i].textContent.length) {
            _removeInvisible(contents[i]);
          }
        }
        else if (contents[i].nodeType == Node.TEXT_NODE) {
          contents[i].textContent = contents[i].textContent.replace(/\u200b/g, '');
        }
      }
    }

    function invisibleSpaces (dirty_html) {
      if (dirty_html.replace(/\u200b/g, '').length == dirty_html.length) return dirty_html;

      dirty_html = _encode(dirty_html);

      if (!editor.opts.fullPage) dirty_html = '<html><head></head><body>' + dirty_html + '</body></html>';

      $iframe = $('<iframe style="width:0; height:0; position: absolute; left: -2000px; display: none;">');
      $('body').append($iframe);
      $iframe.get(0).contentWindow.document.open();
      $iframe.get(0).contentWindow.document.write(dirty_html);
      $iframe.get(0).contentWindow.document.close();

      if (editor.opts.fullPage) {
        html = $iframe.contents().find('html').get(0);

        // Run the cleaning process.
        _removeInvisible(html);

        var doctype = editor.html.getDoctype($iframe.get(0).contentWindow.document);

        dirty_html = doctype +
                '<html' + editor.node.attributes(html) + '>' +
                html.innerHTML +
                '</html>';

        $iframe.remove();

        return _decode(dirty_html);
      }
      else {
        body = $iframe.get(0).contentDocument.getElementsByTagName('body')[0];

        // Run the cleaning process.
        _removeInvisible(body);

        // Get clean html.
        dirty_html = body.innerHTML;

        $iframe.remove();

        return _decode(dirty_html);
      }
    }

    function _encode (dirty_html) {
      // Replace script tag with comments.
      scripts = [];
      dirty_html = dirty_html.replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, function (str) {
        scripts.push(str);
        return '<!--[FROALA.EDITOR.SCRIPT ' + (scripts.length - 1) + ']-->';
      });

      dirty_html = dirty_html.replace(/<img((?:[\w\W]*?)) src="/g, '<img$1 data-src="');

      return dirty_html;
    }

    function _decode (dirty_html) {
      // Replace script comments with the original script.
      dirty_html = dirty_html.replace(/<!--\[FROALA\.EDITOR\.SCRIPT ([\d]*)]-->/gi, function (str, a1) {
        return scripts[parseInt(a1, 10)];
      });

      if (editor.opts.htmlRemoveTags.indexOf('script') >= 0) {
        dirty_html = dirty_html.replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '');
      }

      dirty_html = dirty_html.replace(/<img((?:[\w\W]*?)) data-src="/g, '<img$1 src="');

      return dirty_html;
    }

    function toHTML5 () {
      var $els = editor.$el.find(Object.keys($.FroalaEditor.HTML5Map).join(',')).filter(function () {
        return editor.node.attributes(this) === '';
      })

      if ($els.length) {
        editor.selection.save();
        $els.each (function () {
          $(this).replaceWith('<' + $.FroalaEditor.HTML5Map[this.tagName] + '>' + $(this).html() + '</' + $.FroalaEditor.HTML5Map[this.tagName] + '>');
        })
        editor.selection.restore();
      }
    }

    function _node (node) {
      if (node.tagName == 'PRE') _cleanPre(node);

      if (node.nodeType == Node.TEXT_NODE) {
//        node.textContent = node.textContent.replace(/^ {2,}/, '').replace(/ {2,}$/, '');
      }
      else if (node.nodeType == Node.ELEMENT_NODE) {
        if (node.getAttribute('src')) node.setAttribute('src', editor.helpers.sanitizeURL(node.getAttribute('src')));
        if (node.getAttribute('href')) node.setAttribute('href', editor.helpers.sanitizeURL(node.getAttribute('href')));

        if (['TABLE', 'TBODY', 'TFOOT', 'TR'].indexOf(node.tagName) >= 0) {
          node.innerHTML = node.innerHTML.trim();
        }
      }

      if (node.nodeType == Node.ELEMENT_NODE && $.FroalaEditor.HTML5Map[node.tagName] && editor.node.attributes(node) === '') {
        var tg = $.FroalaEditor.HTML5Map[node.tagName];
        var new_node = '<' + tg + '>' + node.innerHTML + '</' + tg + '>';
        node.insertAdjacentHTML('beforebegin', new_node);
        node = node.previousSibling;
        node.parentNode.removeChild(node.nextSibling);
      }

      if (!editor.opts.htmlAllowComments && node.nodeType == Node.COMMENT_NODE) {
        // Do not remove FROALA.EDITOR comments.
        if (node.data.indexOf('[FROALA.EDITOR') !== 0) {
          node.parentNode.removeChild(node);
        }
      }

      // Remove completely tags in denied tags.
      else if (node.tagName && node.tagName.match(removeTagsRE)) {
        node.parentNode.removeChild(node);
      }

      // Unwrap tags not in allowed tags.
      else if (node.tagName && !node.tagName.match(allowedTagsRE)) {
        node.outerHTML = node.innerHTML;
      }

      // Check denied attributes.
      else {
        var attrs = node.attributes;
        var asterist = ($.inArray('*',editor.opts.htmlAllowedAttrs)!=-1)?true:false; // ★largeden

        if (attrs) {
          for (var i = attrs.length - 1; i >= 0; i--) {
            var attr = attrs[i];
            if (!attr.nodeName.match(allowedAttrsRE) && asterist == false) {  // ★largeden
              node.removeAttribute(attr.nodeName);
            }
            else if (attr.nodeName.match(allowedAttrsRE) && asterist == true) {  // ★largeden
              node.removeAttribute(attr.nodeName);             // ★largeden
            } // ★largeden

            if (attr.nodeName.match(/^on/gi)) {             // ★largeden            
              node.removeAttribute(attr.nodeName);             // ★largeden            
            }             // ★largeden     
          }
        }
      }
    }

    function _run (node) {
      var contents = editor.node.contents(node);
      for (var i = 0; i < contents.length; i++) {
        if (contents[i].nodeType != Node.TEXT_NODE) {
          _run(contents[i]);
        }
        else {
          _node(contents[i]);
        }
      }

      if (node.tagName != 'BODY' || editor.opts.fullPage) _node(node);
    }

    /**
     * Clean pre.
     */
    function _cleanPre (pre) {
      var content = pre.innerHTML;
      if (content.indexOf('\n') >= 0) {
        pre.innerHTML = content.replace(/\n/g, '<br>');
      }
    }

    /**
     * Clean the html input.
     */
    var scripts = [];
    function html (dirty_html, denied_tags, denied_attrs, full_page) {
      if (typeof denied_tags == 'undefined') denied_tags = [];
      if (typeof denied_attrs == 'undefined') denied_attrs = [];
      if (typeof full_page == 'undefined') full_page = false;

      // Strip tabs.
      dirty_html = dirty_html.replace(/\u0009/g, '');

      var allowed_tags = $.merge([], editor.opts.htmlAllowedTags);
      var i;
      for (i = 0; i < denied_tags.length; i++) {
        if (allowed_tags.indexOf(denied_tags[i]) >= 0) {
          allowed_tags.splice(allowed_tags.indexOf(denied_tags[i]), 1);
        }
      }

      var allowed_attrs = $.merge([], editor.opts.htmlAllowedAttrs);
      for (i = 0; i < denied_attrs.length; i++) {
        if (allowed_attrs.indexOf(denied_attrs[i]) >= 0) {
          allowed_attrs.splice(allowed_attrs.indexOf(denied_attrs[i]), 1);
        }
      }

      // Generate cleaning RegEx.
      allowedTagsRE = new RegExp('^' + allowed_tags.join('$|^') + '$', 'gi');
      allowedAttrsRE = new RegExp('^' + (($.inArray('*',allowed_attrs)!=-1)?denied_attrs:allowed_attrs).join('$|^') + '$|^on', 'gi');  // ★largeden
      removeTagsRE = new RegExp('^' + editor.opts.htmlRemoveTags.join('$|^') + '$', 'gi');

      dirty_html = _encode(dirty_html);

      if (!editor.opts.fullPage) dirty_html = '<html><head></head><body>' + dirty_html + '</body></html>';

      $iframe = $('<iframe style="width:0; height:0; position: absolute; left: -2000px; display: none;">');
      $('body').append($iframe);
      $iframe.get(0).contentWindow.document.open();
      $iframe.get(0).contentWindow.document.write(dirty_html);
      $iframe.get(0).contentWindow.document.close();

      if (editor.opts.fullPage && full_page) {
        var html_el = $iframe.contents().find('html').get(0);

        // Run the cleaning process.
        _run(html_el);

        var doctype = editor.html.getDoctype($iframe.get(0).contentWindow.document);

        dirty_html = doctype +
                '<html' + editor.node.attributes(html_el) + '>' +
                html_el.innerHTML +
                '</html>';

        $iframe.remove();

        return _decode(dirty_html);
      }
      else {
        body = $iframe.get(0).contentDocument.getElementsByTagName('body')[0];

        // Run the cleaning process.
        _run(body);

        // Get clean html.
        dirty_html = body.innerHTML;

        $iframe.remove();

        return _decode(dirty_html);
      }
    }

    /**
     * Clean quotes.
     */
    function quotes () {
      // Join quotes.
      var sibling_quotes = editor.$el.find('blockquote + blockquote');
      for (var k = 0; k < sibling_quotes.length; k++) {
        var $quote = $(sibling_quotes[k]);
        if (editor.node.attributes(sibling_quotes[k]) == editor.node.attributes($quote.prev().get(0))) {
          $quote.prev().append($quote.html());
          $quote.remove();
        }
      }
    }

    /**
     * Clean tables.
     */
    function tables () {
      var trs = editor.$el.find('tr').filter(function () {
        return $(this).find('th').length > 0;
      })

      for (var i = 0; i < trs.length; i++) {
        var $thead = $(trs[i]).closest('table').find('thead');
        if ($thead.length === 0) {
          $thead = $('<thead>');
          $(trs[i]).closest('table').prepend($thead);
        }

        $thead.append(trs[i]);
      }

      // Make sure we have a br before tables.
      editor.$el.find('table').filter(function () {
        var prev_node = this.previousSibling;
        if (prev_node && !editor.node.isBlock(prev_node) && prev_node.tagName != 'BR') {
          return true;
        }
        else {
          return false;
        }
      }).before('<br>');

      // Remove P from TH and TH.
      editor.$el.find('td > p, th > p').each (function () {
        $(this).replaceWith(this.innerHTML + '<br>');
      });
    }

    /**
     * Clean lists.
     */
    function lists () {
      // Join lists.
      var sibling_lists = editor.$el.find('ol + ol, ul + ul');
      for (var k = 0; k < sibling_lists.length; k++) {
        var $list = $(sibling_lists[k]);
        if (editor.node.attributes(sibling_lists[k]) == editor.node.attributes($list.prev().get(0))) {
          $list.prev().append($list.html());
          $list.remove();
        }
      }

      // Find missplaced list items.
      var $lis = [];
      var filterListItem = function () {
        return !editor.node.isList(this.parentNode);
      };

      do {
        if ($lis.length) {
          var li = $lis.get(0);
          var $ul = $('<ul></ul>').insertBefore($(li));
          do {
            var tmp = li;
            li = li.nextSibling;
            $ul.append($(tmp));
          } while (li && li.tagName == 'LI');
        }

        $lis = editor.$el.find('li').filter(filterListItem);
      } while ($lis.length > 0);

      var do_remove;
      var removeEmptyList = function (index, lst) {
        var $lst = $(lst);
        if ($lst.find('LI').length === 0) {
          do_remove = true;
          $lst.remove();
        }
      };

      do {
        do_remove = false;

        // Remove empty li.
        editor.$el.find('li:empty').remove();

        // Remove empty ul and ol.
        editor.$el.find('ul, ol').each (removeEmptyList);
      } while (do_remove === true);

      // Do not allow list directly inside another list.
      var direct_lists = editor.$el.find('ol, ul').find('> ul, > ol');
      for (var i = 0; i < direct_lists.length; i++) {
        var list = direct_lists[i];
        var prev_li = list.previousSibling;
        if (prev_li) {
          if (prev_li.tagName == 'LI') {
            $(prev_li).append(list);
          }
          else {
            $(list).wrap('<li></li>');
          }
        }
      }

      // Check if nested lists don't have HTML after them.
      editor.$el.find('li > ul, li > ol').each (function (idx, lst) {
        if (lst.nextSibling) {
          var node = lst.nextSibling;
          var $new_li = $('<li>');
          $(lst.parentNode).after($new_li);
          do {
            var tmp = node;
            node = node.nextSibling;
            $new_li.append(tmp);
          } while (node);
        }
      });

      // Make sure we can type in nested list.
      editor.$el.find('li > ul, li > ol').each (function (idx, lst) {
        // List is the first in the LI.
        if (editor.node.isFirstSibling(lst)) {
          $(lst).before('<br/>');
        }

        // Make sure we don't leave BR before list.
        else if (lst.previousSibling && lst.previousSibling.tagName == 'BR') {
          var prev_node = lst.previousSibling.previousSibling;

          // Skip markers.
          while (prev_node && $(prev_node).hasClass('fr-marker')) {
            prev_node = prev_node.previousSibling;
          }

          // Remove BR only if there is something else than BR.
          if (prev_node && prev_node.tagName != 'BR') {
            $(lst.previousSibling).remove();
          }
        }
      });

      // Remove empty li.
      editor.$el.find('li:empty').remove();
    }

    /**
     * Initialize
     */
    function _init () {
      // If fullPage is on allow head and title.
      if (editor.opts.fullPage) {
        $.merge(editor.opts.htmlAllowedTags, ['head', 'title', 'style', 'link', 'base', 'body', 'html']);
      }
    }

    return {
      require: ['node'],
      _init: _init,
      html: html,
      toHTML5: toHTML5,
      tables: tables,
      lists: lists,
      quotes: quotes,
      invisibleSpaces: invisibleSpaces
    }
  };


  $.FroalaEditor.MODULES.toolbar = function (editor) {
    var _document, _window;

    /**
     * Add buttons to the toolbar.
     */
    function _addButtons () {
      var buttons_list = editor.button.buildList(editor.opts.toolbarButtons);
      editor.$tb.append(buttons_list);
      editor.button.bindCommands(editor.$tb);
    }

    /**
     * Set the buttons visibility based on screen size.
     */
    function _setVisibility () {
      editor.$tb.find('> .fr-command').each (function (i, el) {
        if (editor.opts.toolbarButtonsSXS.indexOf($(el).data('cmd')) >= 0) $(el).addClass('fr-visible-sxs');
        if (editor.opts.toolbarButtonsXS.indexOf($(el).data('cmd')) >= 0) $(el).addClass('fr-visible-xs');
        if (editor.opts.toolbarButtonsSM.indexOf($(el).data('cmd')) >= 0) $(el).addClass('fr-visible-sm');
        if (editor.opts.toolbarButtonsMD.indexOf($(el).data('cmd')) >= 0) $(el).addClass('fr-visible-md');
      });

      if (editor.opts.toolbarButtonsSXS.indexOf('-') >=0) editor.$tb.find('.fr-separator.fr-hs').addClass('fr-visible-sxs');
      if (editor.opts.toolbarButtonsXS.indexOf('-') >=0) editor.$tb.find('.fr-separator.fr-hs').addClass('fr-visible-xs');
      if (editor.opts.toolbarButtonsSM.indexOf('-') >=0) editor.$tb.find('.fr-separator.fr-hs').addClass('fr-visible-sm');
      if (editor.opts.toolbarButtonsMD.indexOf('-') >=0) editor.$tb.find('.fr-separator.fr-hs').addClass('fr-visible-md');

      if (editor.opts.toolbarButtonsSXS.indexOf('|') >=0) editor.$tb.find('.fr-separator.fr-vs').addClass('fr-visible-sxs');
      if (editor.opts.toolbarButtonsXS.indexOf('|') >=0) editor.$tb.find('.fr-separator.fr-vs').addClass('fr-visible-xs');
      if (editor.opts.toolbarButtonsSM.indexOf('|') >=0) editor.$tb.find('.fr-separator.fr-vs').addClass('fr-visible-sm');
      if (editor.opts.toolbarButtonsMD.indexOf('|') >=0) editor.$tb.find('.fr-separator.fr-vs').addClass('fr-visible-md');
    }

    function showInline (e, force) {
      if (editor.helpers.isMobile()) {
        editor.toolbar.show();
      }
      else {
        setTimeout(function () {
          if (e && e.which == $.FroalaEditor.KEYCODE.ESC) {
            // Nothing.
          }
          else if (editor.selection.inEditor() && editor.core.hasFocus() && !editor.popups.areVisible()) {
            if (editor.opts.toolbarVisibleWithoutSelection || editor.selection.text() !== '' || force) {
              // Check if we should actually show the toolbar.
              if (editor.events.trigger('toolbar.show') == false) return false;

              if (!editor.helpers.isMobile()) {
                editor.position.forSelection(editor.$tb);
              }

              editor.$tb.show();
            }
          }
        }, 0);
      }
    }

    function hide () {
      // Check if we should actually hide the toolbar.
      if (editor.events.trigger('toolbar.hide') == false) return false;

      editor.$tb.hide();
    }

    function show () {
      // Check if we should actually hide the toolbar.
      if (editor.events.trigger('toolbar.show') == false) return false;

      editor.$tb.show();
    }

    /**
     * Set the events for show / hide toolbar.
     */
    function _initInlineBehavior () {
      // Window mousedown.
      editor.events.on('window.mousedown', hide);

      // Element keydown.
      editor.events.on('keydown', hide);

      // Element blur.
      editor.events.on('blur', hide);

      // Window mousedown.
      editor.events.on('window.mouseup', showInline);
      editor.events.on('keyup', showInline);

      // Hide editor on ESC.
      editor.events.on('keydown', function (e) {
        if (e && e.which == $.FroalaEditor.KEYCODE.ESC) {
          hide();
        }
      });

      editor.$wp.on('scroll.toolbar', showInline);
      editor.events.on('commands.after', showInline);
    }

    /**
     * Set the events for show / hide toolbar when on mobile.
     */
    function _initInlineMobileBehavior () {
      editor.events.on('focus', showInline, true);

      editor.events.on('blur', hide, true)
    }

    function _initPositioning () {
      // Toolbar is inline.
      if (editor.opts.toolbarInline) {
        editor.$box.addClass('fr-inline');

        // Mobile should handle this as regular.
        if (!editor.helpers.isMobile()) {
          $(editor.opts.scrollableContainer).append(editor.$tb);

          // Add toolbar to body.
          editor.$tb.data('container', $(editor.opts.scrollableContainer));

          // Add inline class.
          editor.$tb.addClass('fr-inline');

          // Init mouse behavior.
          _initInlineBehavior();

          editor.opts.toolbarBottom = false;
        }
        else {
          if (editor.helpers.isIOS()) {
            $('body').append(editor.$tb);
            editor.position.addSticky(editor.$tb);
          }
          else {
            editor.$tb.addClass('fr-bottom');
            editor.$box.append(editor.$tb);
            editor.position.addSticky(editor.$tb);
            editor.opts.toolbarBottom = true;
          }

          editor.$tb.addClass('fr-inline');
          _initInlineMobileBehavior();

          editor.opts.toolbarInline = false;
        }
      }

      // Toolbar is normal.
      else {
        // Won't work on iOS.
        if (editor.opts.toolbarBottom && !editor.helpers.isIOS()) {
          editor.$box.append(editor.$tb);
          editor.$tb.addClass('fr-bottom');
          editor.$box.addClass('fr-bottom');
        }
        else {
          editor.opts.toolbarBottom = false;
          editor.$box.prepend(editor.$tb);
          editor.$tb.addClass('fr-top');
          editor.$box.addClass('fr-top');
        }

        editor.$box.addClass('fr-basic');
        editor.$tb.addClass('fr-basic');

        if (editor.opts.toolbarSticky) {
          if (editor.opts.toolbarStickyOffset) {
            if (editor.opts.toolbarBottom) {
              editor.$tb.css('bottom', editor.opts.toolbarStickyOffset);
            }
            else {
              editor.$tb.css('top', editor.opts.toolbarStickyOffset);
            }
          }

          editor.position.addSticky(editor.$tb);
        }
      }
    }

    /**
     * Destroy.
     */
    function _destroy () {
      editor.$box.removeClass('fr-top fr-bottom fr-inline fr-basic');
      editor.$box.find('.fr-sticky-dummy').remove();
      editor.$tb.off(editor._mousedown + ' ' + editor._mouseup);
      editor.$tb.html('').removeData().remove();
    }

    /**
     * Initialize
     */
    function _init () {
      if (!editor.$wp) return false;

      // Create toolbar object.
      editor.$tb = $('<div class="fr-toolbar"></div>');

      if (editor.opts.theme) {
        editor.$tb.addClass(editor.opts.theme + '-theme');
      }

      if (editor.opts.zIndex > 1) {
        editor.$tb.css('z-index', editor.opts.zIndex + 1);
      }

      // Set direction.
      if (editor.opts.direction != 'auto') {
        editor.$tb.removeClass('fr-ltr fr-rtl').addClass('fr-' + editor.opts.direction);
      }

      // Mark toolbar for desktop / mobile.
      if (!editor.helpers.isMobile()) {
        editor.$tb.addClass('fr-desktop');
      }
      else {
        editor.$tb.addClass('fr-mobile');
      }

      // Set the toolbar specific position inline / normal.
      _initPositioning();

      // Set documetn and window for toolbar.
      _document = editor.$tb.get(0).ownerDocument;
      _window = 'defaultView' in _document ? _document.defaultView : _document.parentWindow;

      // Add buttons to the toolbar.
      // Set their visibility for different screens.
      // Asses commands to the butttons.
      _addButtons();
      _setVisibility();

      // Make sure we don't trigger blur.
      editor.$tb.on(editor._mousedown + ' ' + editor._mouseup, function (e) {
        var originalTarget = e.originalEvent ? (e.originalEvent.target || e.originalEvent.originalTarget) : null;
        if (originalTarget && originalTarget.tagName != 'INPUT') {
          e.stopPropagation();
          e.preventDefault();
          return false;
        }
      });

      // Destroy.
      editor.events.on('destroy', _destroy, true);
    }

    var disabled = false;
    function disable () {
      if (!disabled && editor.$tb) {
        editor.$tb.find('> .fr-command').addClass('fr-disabled');
        disabled = true;
      }
    }

    function enable () {
      if (disabled && editor.$tb) {
        editor.$tb.find('> .fr-command').removeClass('fr-disabled');
        disabled = false;
      }

      editor.button.bulkRefresh();
    }

    return {
      require: ['events', 'tooltip', 'button', 'icon', 'core', 'language'],
      _init: _init,
      hide: hide,
      show: show,
      showInline: showInline,
      disable: disable,
      enable: enable
    }
  };


// Plugin


  $.FroalaEditor.PLUGINS.blockElement = function (editor) {
    function _toggle() {
      var $btn = editor.$tb.find('.fr-command[data-cmd="blockElement"]');
        editor.$el.toggleClass('fr-block');
     }
    
    function _refresh($btn) {
  		if(editor.$el.hasClass('fr-block')) $btn.addClass('fr-active');
    }

    return {
      toggle: _toggle,
      refresh: _refresh
    }
  }

  $.FroalaEditor.DefineIcon('blockElement', {NAME: 'object-group'});
  $.FroalaEditor.RegisterCommand('blockElement', {
    title: 'Block Elements',
    undo: false,
    focus: false,
    forcedRefresh: true,
    callback: function () {
      this.blockElement.toggle();
    },
	// Callback on refresh.
	refresh: function ($btn) {
      this.blockElement.refresh($btn);
	}
  })

  $.FroalaEditor.PLUGINS.sourceCode = function (editor) {

    /**
     * Refresh list buttons.
     */
    function _refresh($btn, tag_name) {
      var $el = $(editor.selection.element());
      if ($el.get(0) != editor.$el.get(0)) {
        var code = $el.get(0);
        if (code.tagName != 'CODE') {
          code = $el.parents('code').get(0);
        }

        if (code && code.tagName == tag_name) {
          $btn.addClass('fr-active');
        }
      }
    }

    function _toggle() {
		// Wrap.
		editor.selection.save();
		editor.html.wrap(true, true);
		editor.selection.restore();
		
		var blocks = editor.selection.element();

		if(blocks.tagName == 'CODE') {
			editor.selection.save();

		var string = $(blocks).text();
				string = string.replace(/&/g,"&amp;");
				string = string.replace(/"/g,"&quot;");
				string = string.replace(/'/g,"&#039;");
				string = string.replace(/</g,"&lt;");
				string = string.replace(/>/g,"&gt;");
				
			$(blocks).replaceWith(string);
		}
		else {
			if (editor.selection.text() !== '') {
				var string = editor.selection.text();
				string = string.replace(/&/g,"&amp;");
				string = string.replace(/"/g,"&quot;");
				string = string.replace(/'/g,"&#039;");
				string = string.replace(/</g,"&lt;");
				string = string.replace(/>/g,"&gt;");
				editor.html.insert($.FroalaEditor.START_MARKER + '<code>' + string + '</code>' + $.FroalaEditor.END_MARKER);
			}
		}
		// Unwrap temp divs.
		editor.html.unwrap();
		
		editor.selection.restore();
	}

    return {
      toggle: _toggle,
      refresh: _refresh,
    }
  }

  $.FroalaEditor.DefineIcon('sourceCode', {NAME: 'terminal'});
  $.FroalaEditor.RegisterCommand('sourceCode', {
    title: 'Code',
    forcedRefresh: true,
    callback: function () {
      this.sourceCode.toggle();
    },
    refresh: function ($btn) {
      this.sourceCode.refresh($btn, 'CODE');
    }
  });


})(jQuery); // End froalaEditorObj

// Froala Editor 실행
window.froalaEditorInit = jQuery.froalaEditorObj.init;