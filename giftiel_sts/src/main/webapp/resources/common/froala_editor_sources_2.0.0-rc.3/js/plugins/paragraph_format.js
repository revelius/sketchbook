/*!
 * froala_editor v2.0.0-rc.3 (https://www.froala.com/wysiwyg-editor/v2.0)
 * License http://editor.froala.com/license
 * Copyright 2014-2015 Froala Labs
 */

(function ($) {
  'use strict';

  $.extend($.FroalaEditor.DEFAULTS, {
    paragraphFormat: {
      N: 'Normal',
      H1: 'Heading 1',
      H2: 'Heading 2',
      H3: 'Heading 3',
      H4: 'Heading 4',
      PRE: 'Code'
    },
    paragraphFormatSelection: false
  })

  $.FroalaEditor.PLUGINS.paragraphFormat = function (editor) {

    /**
     * Style content inside LI when LI is selected.
     * This case happens only when the LI contains a nested list or when it has no block tag inside.
     */
    function _styleLiWithoutBlocks($li, val) {
      var defaultTag = editor.html.defaultTag();

      // If val is null or default tag already do nothing.
      if (val && val.toLowerCase() != defaultTag) {
        // Deal with nested lists.
        if ($li.find('ul, ol').length > 0) {
          var $el = $('<' + val + '>');
          $li.prepend($el);
          var node = editor.node.contents($li.get(0))[0];
          while (node && ['UL', 'OL'].indexOf(node.tagName) < 0) {
            var next_node = node.nextSibling;
            $el.append(node);
            node = next_node;
          }
        }

        // Wrap list content.
        else {
          $li.html('<' + val + '>' + $li.html() + '</' + val + '>');
        }
      }
    }

    /**
     * Style content inside LI.
     */
    function _styleLiWithBlocks($blk, val) {
      var defaultTag = editor.html.defaultTag();

      // Prepare a temp div.
      if (!val) val = 'div class="fr-temp-div" data-empty="true"';

      // In list we don't have P so just unwrap content.
      if (val.toLowerCase() == defaultTag) {
        $blk.replaceWith($blk.html());
      }

      // Replace the current block with the new one.
      else {
        $blk.replaceWith($('<' + val + '>').html($blk.html()));
      }
    }

    /**
     * Style content inside TD.
     */
    function _styleTdWithBlocks($blk, val) {
      var defaultTag = editor.html.defaultTag();

      // Prepare a temp div.
      if (!val) val = 'div class="fr-temp-div"' + (editor.node.isEmpty($blk.get(0), true) ? ' data-empty="true"' : '');

      // Return to the regular case. We don't use P inside TD/TH.
      if (val.toLowerCase() == defaultTag) {
        // If node is not empty, then add a BR.
        if (!editor.node.isEmpty($blk.get(0), true)) {
          $blk.append('<br/>');
        }

        $blk.replaceWith($blk.html());
      }

      // Replace with the new tag.
      else {
        $blk.replaceWith($('<' + val  + '>').html($blk.html()));
      }
    }

    /**
     * Basic style.
     */
    function _style($blk, val) {
      if (!val) val = 'div class="fr-temp-div"' + (editor.node.isEmpty($blk.get(0), true) ? ' data-empty="true"' : '');
      $blk.replaceWith($('<' + val  + ' ' + editor.node.attributes($blk.get(0)) + '>').html($blk.html()));
    }

    /**
     * Apply style.
     */
    function apply (val) {
      // Normal.
      if (val == 'N') val = editor.html.defaultTag();

      // Wrap.
      editor.selection.save();
      editor.html.wrap(true, true, true);
      editor.selection.restore();

      // Get blocks.
      var blocks = editor.selection.blocks();

      // Save selection to restore it later.
      editor.selection.save();

      editor.$el.find('pre').attr('skip', true);

      // Go through each block and apply style to it.
      for (var i = 0; i < blocks.length; i++) {
        if (blocks[i].tagName != val) {
          var $blk = $(blocks[i]);

          // Style the content inside LI when there is selection right in LI.
          if (blocks[i].tagName == 'LI') {
            _styleLiWithoutBlocks($blk, val);
          }

          // Style the content inside LI when we have other tag in LI.
          else if (blocks[i].parentNode.tagName == 'LI') {
            _styleLiWithBlocks($blk, val);
          }

          // Style the content inside TD/TH.
          else if (['TD', 'TH'].indexOf(blocks[i].parentNode.tagName) >= 0) {
            _styleTdWithBlocks($blk, val);
          }

          // Regular case.
          else {
            _style($blk, val);
          }
        }
      }

      // Join PRE together.
      editor.$el.find('pre:not([skip="true"]) + pre:not([skip="true"])').each(function () {
        $(this).prev().append('<br>' + $(this).html());
        $(this).remove();
      });
      editor.$el.find('pre').removeAttr('skip');

      // Unwrap temp divs.
      editor.html.unwrap();

      // Restore selection.
      editor.selection.restore();
    }

    function refreshOnShow($btn, $dropdown) {
      var blocks = editor.selection.blocks();

      if (blocks.length) {
        var blk = blocks[0];
        var tag = 'N';
        var default_tag = editor.html.defaultTag();
        if (blk.tagName.toLowerCase() != default_tag && blk != editor.$el.get(0)) {
          tag = blk.tagName;
        }

        $dropdown.find('.fr-command[data-param1="' + tag + '"]').addClass('fr-active');
      }
      else {
        $dropdown.find('.fr-command[data-param1="N"]').addClass('fr-active');
      }
    }

    function refresh ($btn, $dropdown) {
      var blocks = editor.selection.blocks();

      if (blocks.length) {
        var blk = blocks[0];
        var tag = 'N';
        var default_tag = editor.html.defaultTag();
        if (blk.tagName.toLowerCase() != default_tag && blk != editor.$el.get(0)) {
          tag = blk.tagName;
        }

        if (['LI', 'TD', 'TH'].indexOf(tag) >= 0) {
          tag = 'N';
        }

        $btn.find('> span').text($dropdown.find('.fr-command[data-param1="' + tag + '"]').text())
      }
      else {
        $btn.find('> span').text($dropdown.find('.fr-command[data-param1="N"]').text());
      }
    }

    return {
      apply: apply,
      refreshOnShow: refreshOnShow,
      refresh: refresh
    }
  }

  // Register the font size command.
  $.FroalaEditor.RegisterCommand('paragraphFormat', {
    type: 'dropdown',
    displaySelection: function (editor) {
      return editor.opts.paragraphFormatSelection;
    },
    defaultSelection: 'Normal',
    displaySelectionWidth: 100,
    html: function () {
      var c = '<ul class="fr-dropdown-list">';
      var options =  this.opts.paragraphFormat;
      for (var val in options) {
        c += '<li><' + val + ' style="padding: 0; margin: 0;"><a class="fr-command" data-cmd="paragraphFormat" data-param1="' + val + '" title="' + this.language.translate(options[val]) + '">' + this.language.translate(options[val]) + '</a></' + val + '></li>';
      }
      c += '</ul>';

      return c;
    },
    title: 'Paragraph Format',
    callback: function (cmd, val) {
      this.paragraphFormat.apply(val);
    },
    refresh: function ($btn, $dropdown) {
      this.paragraphFormat.refresh($btn, $dropdown);
    },
    refreshOnShow: function ($btn, $dropdown) {
      this.paragraphFormat.refreshOnShow($btn, $dropdown);
    }
  })

  // Add the font size icon.
  $.FroalaEditor.DefineIcon('paragraphFormat', {
    NAME: 'paragraph'
  });

})(jQuery);
