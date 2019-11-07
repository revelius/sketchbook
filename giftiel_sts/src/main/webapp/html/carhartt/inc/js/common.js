if(location.search.indexOf('livereload=true') != -1){
	document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js"></' + 'script>');
	// HTML 구축시만 필요 개발 진행시 이 부분은 삭제
}

// transit.min.js
(function(t,e){if(typeof define==="function"&&define.amd){define(["jquery"],e)}else if(typeof exports==="object"){module.exports=e(require("jquery"))}else{e(t.jQuery)}})(this,function(t){t.transit={version:"0.9.12",propertyMap:{marginLeft:"margin",marginRight:"margin",marginBottom:"margin",marginTop:"margin",paddingLeft:"padding",paddingRight:"padding",paddingBottom:"padding",paddingTop:"padding"},enabled:true,useTransitionEnd:false};var e=document.createElement("div");var n={};function i(t){if(t in e.style)return t;var n=["Moz","Webkit","O","ms"];var i=t.charAt(0).toUpperCase()+t.substr(1);for(var r=0;r<n.length;++r){var s=n[r]+i;if(s in e.style){return s}}}function r(){e.style[n.transform]="";e.style[n.transform]="rotateY(90deg)";return e.style[n.transform]!==""}var s=navigator.userAgent.toLowerCase().indexOf("chrome")>-1;n.transition=i("transition");n.transitionDelay=i("transitionDelay");n.transform=i("transform");n.transformOrigin=i("transformOrigin");n.filter=i("Filter");n.transform3d=r();var a={transition:"transitionend",MozTransition:"transitionend",OTransition:"oTransitionEnd",WebkitTransition:"webkitTransitionEnd",msTransition:"MSTransitionEnd"};var o=n.transitionEnd=a[n.transition]||null;for(var u in n){if(n.hasOwnProperty(u)&&typeof t.support[u]==="undefined"){t.support[u]=n[u]}}e=null;t.cssEase={_default:"ease","in":"ease-in",out:"ease-out","in-out":"ease-in-out",snap:"cubic-bezier(0,1,.5,1)",easeInCubic:"cubic-bezier(.550,.055,.675,.190)",easeOutCubic:"cubic-bezier(.215,.61,.355,1)",easeInOutCubic:"cubic-bezier(.645,.045,.355,1)",easeInCirc:"cubic-bezier(.6,.04,.98,.335)",easeOutCirc:"cubic-bezier(.075,.82,.165,1)",easeInOutCirc:"cubic-bezier(.785,.135,.15,.86)",easeInExpo:"cubic-bezier(.95,.05,.795,.035)",easeOutExpo:"cubic-bezier(.19,1,.22,1)",easeInOutExpo:"cubic-bezier(1,0,0,1)",easeInQuad:"cubic-bezier(.55,.085,.68,.53)",easeOutQuad:"cubic-bezier(.25,.46,.45,.94)",easeInOutQuad:"cubic-bezier(.455,.03,.515,.955)",easeInQuart:"cubic-bezier(.895,.03,.685,.22)",easeOutQuart:"cubic-bezier(.165,.84,.44,1)",easeInOutQuart:"cubic-bezier(.77,0,.175,1)",easeInQuint:"cubic-bezier(.755,.05,.855,.06)",easeOutQuint:"cubic-bezier(.23,1,.32,1)",easeInOutQuint:"cubic-bezier(.86,0,.07,1)",easeInSine:"cubic-bezier(.47,0,.745,.715)",easeOutSine:"cubic-bezier(.39,.575,.565,1)",easeInOutSine:"cubic-bezier(.445,.05,.55,.95)",easeInBack:"cubic-bezier(.6,-.28,.735,.045)",easeOutBack:"cubic-bezier(.175, .885,.32,1.275)",easeInOutBack:"cubic-bezier(.68,-.55,.265,1.55)"};t.cssHooks["transit:transform"]={get:function(e){return t(e).data("transform")||new f},set:function(e,i){var r=i;if(!(r instanceof f)){r=new f(r)}if(n.transform==="WebkitTransform"&&!s){e.style[n.transform]=r.toString(true)}else{e.style[n.transform]=r.toString()}t(e).data("transform",r)}};t.cssHooks.transform={set:t.cssHooks["transit:transform"].set};t.cssHooks.filter={get:function(t){return t.style[n.filter]},set:function(t,e){t.style[n.filter]=e}};if(t.fn.jquery<"1.8"){t.cssHooks.transformOrigin={get:function(t){return t.style[n.transformOrigin]},set:function(t,e){t.style[n.transformOrigin]=e}};t.cssHooks.transition={get:function(t){return t.style[n.transition]},set:function(t,e){t.style[n.transition]=e}}}p("scale");p("scaleX");p("scaleY");p("translate");p("rotate");p("rotateX");p("rotateY");p("rotate3d");p("perspective");p("skewX");p("skewY");p("x",true);p("y",true);function f(t){if(typeof t==="string"){this.parse(t)}return this}f.prototype={setFromString:function(t,e){var n=typeof e==="string"?e.split(","):e.constructor===Array?e:[e];n.unshift(t);f.prototype.set.apply(this,n)},set:function(t){var e=Array.prototype.slice.apply(arguments,[1]);if(this.setter[t]){this.setter[t].apply(this,e)}else{this[t]=e.join(",")}},get:function(t){if(this.getter[t]){return this.getter[t].apply(this)}else{return this[t]||0}},setter:{rotate:function(t){this.rotate=b(t,"deg")},rotateX:function(t){this.rotateX=b(t,"deg")},rotateY:function(t){this.rotateY=b(t,"deg")},scale:function(t,e){if(e===undefined){e=t}this.scale=t+","+e},skewX:function(t){this.skewX=b(t,"deg")},skewY:function(t){this.skewY=b(t,"deg")},perspective:function(t){this.perspective=b(t,"px")},x:function(t){this.set("translate",t,null)},y:function(t){this.set("translate",null,t)},translate:function(t,e){if(this._translateX===undefined){this._translateX=0}if(this._translateY===undefined){this._translateY=0}if(t!==null&&t!==undefined){this._translateX=b(t,"px")}if(e!==null&&e!==undefined){this._translateY=b(e,"px")}this.translate=this._translateX+","+this._translateY}},getter:{x:function(){return this._translateX||0},y:function(){return this._translateY||0},scale:function(){var t=(this.scale||"1,1").split(",");if(t[0]){t[0]=parseFloat(t[0])}if(t[1]){t[1]=parseFloat(t[1])}return t[0]===t[1]?t[0]:t},rotate3d:function(){var t=(this.rotate3d||"0,0,0,0deg").split(",");for(var e=0;e<=3;++e){if(t[e]){t[e]=parseFloat(t[e])}}if(t[3]){t[3]=b(t[3],"deg")}return t}},parse:function(t){var e=this;t.replace(/([a-zA-Z0-9]+)\((.*?)\)/g,function(t,n,i){e.setFromString(n,i)})},toString:function(t){var e=[];for(var i in this){if(this.hasOwnProperty(i)){if(!n.transform3d&&(i==="rotateX"||i==="rotateY"||i==="perspective"||i==="transformOrigin")){continue}if(i[0]!=="_"){if(t&&i==="scale"){e.push(i+"3d("+this[i]+",1)")}else if(t&&i==="translate"){e.push(i+"3d("+this[i]+",0)")}else{e.push(i+"("+this[i]+")")}}}}return e.join(" ")}};function c(t,e,n){if(e===true){t.queue(n)}else if(e){t.queue(e,n)}else{t.each(function(){n.call(this)})}}function l(e){var i=[];t.each(e,function(e){e=t.camelCase(e);e=t.transit.propertyMap[e]||t.cssProps[e]||e;e=h(e);if(n[e])e=h(n[e]);if(t.inArray(e,i)===-1){i.push(e)}});return i}function d(e,n,i,r){var s=l(e);if(t.cssEase[i]){i=t.cssEase[i]}var a=""+y(n)+" "+i;if(parseInt(r,10)>0){a+=" "+y(r)}var o=[];t.each(s,function(t,e){o.push(e+" "+a)});return o.join(", ")}t.fn.transition=t.fn.transit=function(e,i,r,s){var a=this;var u=0;var f=true;var l=t.extend(true,{},e);if(typeof i==="function"){s=i;i=undefined}if(typeof i==="object"){r=i.easing;u=i.delay||0;f=typeof i.queue==="undefined"?true:i.queue;s=i.complete;i=i.duration}if(typeof r==="function"){s=r;r=undefined}if(typeof l.easing!=="undefined"){r=l.easing;delete l.easing}if(typeof l.duration!=="undefined"){i=l.duration;delete l.duration}if(typeof l.complete!=="undefined"){s=l.complete;delete l.complete}if(typeof l.queue!=="undefined"){f=l.queue;delete l.queue}if(typeof l.delay!=="undefined"){u=l.delay;delete l.delay}if(typeof i==="undefined"){i=t.fx.speeds._default}if(typeof r==="undefined"){r=t.cssEase._default}i=y(i);var p=d(l,i,r,u);var h=t.transit.enabled&&n.transition;var b=h?parseInt(i,10)+parseInt(u,10):0;if(b===0){var g=function(t){a.css(l);if(s){s.apply(a)}if(t){t()}};c(a,f,g);return a}var m={};var v=function(e){var i=false;var r=function(){if(i){a.unbind(o,r)}if(b>0){a.each(function(){this.style[n.transition]=m[this]||null})}if(typeof s==="function"){s.apply(a)}if(typeof e==="function"){e()}};if(b>0&&o&&t.transit.useTransitionEnd){i=true;a.bind(o,r)}else{window.setTimeout(r,b)}a.each(function(){if(b>0){this.style[n.transition]=p}t(this).css(l)})};var z=function(t){this.offsetWidth;v(t)};c(a,f,z);return this};function p(e,i){if(!i){t.cssNumber[e]=true}t.transit.propertyMap[e]=n.transform;t.cssHooks[e]={get:function(n){var i=t(n).css("transit:transform");return i.get(e)},set:function(n,i){var r=t(n).css("transit:transform");r.setFromString(e,i);t(n).css({"transit:transform":r})}}}function h(t){return t.replace(/([A-Z])/g,function(t){return"-"+t.toLowerCase()})}function b(t,e){if(typeof t==="string"&&!t.match(/^[\-0-9\.]+$/)){return t}else{return""+t+e}}function y(e){var n=e;if(typeof n==="string"&&!n.match(/^[\-0-9\.]+/)){n=t.fx.speeds[n]||t.fx.speeds._default}return b(n,"ms")}t.transit.getTransitionValue=d;return t});

/*! iScroll v5.1.3 ~ (c) 2008-2015 Matteo Spinelli ~ http://cubiq.org/license */
!function(t,i,s){function e(t,s){this.wrapper="string"==typeof t?i.querySelector(t):t,this.scroller=this.wrapper.children[0],this.scrollerStyle=this.scroller.style,this.options={startX:0,startY:0,scrollY:!0,directionLockThreshold:5,momentum:!0,bounce:!0,bounceTime:600,bounceEasing:"",preventDefault:!0,preventDefaultException:{tagName:/^(INPUT|TEXTAREA|BUTTON|SELECT)$/},HWCompositing:!0,useTransition:!0,useTransform:!0};for(var e in s)this.options[e]=s[e];this.translateZ=this.options.HWCompositing&&o.hasPerspective?" translateZ(0)":"",this.options.useTransition=o.hasTransition&&this.options.useTransition,this.options.useTransform=o.hasTransform&&this.options.useTransform,this.options.eventPassthrough=this.options.eventPassthrough===!0?"vertical":this.options.eventPassthrough,this.options.preventDefault=!this.options.eventPassthrough&&this.options.preventDefault,this.options.scrollY="vertical"==this.options.eventPassthrough?!1:this.options.scrollY,this.options.scrollX="horizontal"==this.options.eventPassthrough?!1:this.options.scrollX,this.options.freeScroll=this.options.freeScroll&&!this.options.eventPassthrough,this.options.directionLockThreshold=this.options.eventPassthrough?0:this.options.directionLockThreshold,this.options.bounceEasing="string"==typeof this.options.bounceEasing?o.ease[this.options.bounceEasing]||o.ease.circular:this.options.bounceEasing,this.options.resizePolling=void 0===this.options.resizePolling?60:this.options.resizePolling,this.options.tap===!0&&(this.options.tap="tap"),this.x=0,this.y=0,this.directionX=0,this.directionY=0,this._events={},this._init(),this.refresh(),this.scrollTo(this.options.startX,this.options.startY),this.enable()}var n=t.requestAnimationFrame||t.webkitRequestAnimationFrame||t.mozRequestAnimationFrame||t.oRequestAnimationFrame||t.msRequestAnimationFrame||function(i){t.setTimeout(i,1e3/60)},o=function(){function e(t){return r===!1?!1:""===r?t:r+t.charAt(0).toUpperCase()+t.substr(1)}var n={},o=i.createElement("div").style,r=function(){for(var t,i=["t","webkitT","MozT","msT","OT"],s=0,e=i.length;e>s;s++)if(t=i[s]+"ransform",t in o)return i[s].substr(0,i[s].length-1);return!1}();n.getTime=Date.now||function(){return(new Date).getTime()},n.extend=function(t,i){for(var s in i)t[s]=i[s]},n.addEvent=function(t,i,s,e){t.addEventListener(i,s,!!e)},n.removeEvent=function(t,i,s,e){t.removeEventListener(i,s,!!e)},n.prefixPointerEvent=function(i){return t.MSPointerEvent?"MSPointer"+i.charAt(9).toUpperCase()+i.substr(10):i},n.momentum=function(t,i,e,n,o,r){var h,a,c=t-i,l=s.abs(c)/e;return r=void 0===r?6e-4:r,h=t+l*l/(2*r)*(0>c?-1:1),a=l/r,n>h?(h=o?n-o/2.5*(l/8):n,c=s.abs(h-t),a=c/l):h>0&&(h=o?o/2.5*(l/8):0,c=s.abs(t)+h,a=c/l),{destination:s.round(h),duration:a}};var h=e("transform");return n.extend(n,{hasTransform:h!==!1,hasPerspective:e("perspective")in o,hasTouch:"ontouchstart"in t,hasPointer:t.PointerEvent||t.MSPointerEvent,hasTransition:e("transition")in o}),n.isBadAndroid=/Android /.test(t.navigator.appVersion)&&!/Chrome\/\d/.test(t.navigator.appVersion),n.extend(n.style={},{transform:h,transitionTimingFunction:e("transitionTimingFunction"),transitionDuration:e("transitionDuration"),transitionDelay:e("transitionDelay"),transformOrigin:e("transformOrigin")}),n.hasClass=function(t,i){var s=new RegExp("(^|\\s)"+i+"(\\s|$)");return s.test(t.className)},n.addClass=function(t,i){if(!n.hasClass(t,i)){var s=t.className.split(" ");s.push(i),t.className=s.join(" ")}},n.removeClass=function(t,i){if(n.hasClass(t,i)){var s=new RegExp("(^|\\s)"+i+"(\\s|$)","g");t.className=t.className.replace(s," ")}},n.offset=function(t){for(var i=-t.offsetLeft,s=-t.offsetTop;t=t.offsetParent;)i-=t.offsetLeft,s-=t.offsetTop;return{left:i,top:s}},n.preventDefaultException=function(t,i){for(var s in i)if(i[s].test(t[s]))return!0;return!1},n.extend(n.eventType={},{touchstart:1,touchmove:1,touchend:1,mousedown:2,mousemove:2,mouseup:2,pointerdown:3,pointermove:3,pointerup:3,MSPointerDown:3,MSPointerMove:3,MSPointerUp:3}),n.extend(n.ease={},{quadratic:{style:"cubic-bezier(0.25, 0.46, 0.45, 0.94)",fn:function(t){return t*(2-t)}},circular:{style:"cubic-bezier(0.1, 0.57, 0.1, 1)",fn:function(t){return s.sqrt(1- --t*t)}},back:{style:"cubic-bezier(0.175, 0.885, 0.32, 1.275)",fn:function(t){var i=4;return(t-=1)*t*((i+1)*t+i)+1}},bounce:{style:"",fn:function(t){return(t/=1)<1/2.75?7.5625*t*t:2/2.75>t?7.5625*(t-=1.5/2.75)*t+.75:2.5/2.75>t?7.5625*(t-=2.25/2.75)*t+.9375:7.5625*(t-=2.625/2.75)*t+.984375}},elastic:{style:"",fn:function(t){var i=.22,e=.4;return 0===t?0:1==t?1:e*s.pow(2,-10*t)*s.sin(2*(t-i/4)*s.PI/i)+1}}}),n.tap=function(t,s){var e=i.createEvent("Event");e.initEvent(s,!0,!0),e.pageX=t.pageX,e.pageY=t.pageY,t.target.dispatchEvent(e)},n.click=function(t){var s,e=t.target;/(SELECT|INPUT|TEXTAREA)/i.test(e.tagName)||(s=i.createEvent("MouseEvents"),s.initMouseEvent("click",!0,!0,t.view,1,e.screenX,e.screenY,e.clientX,e.clientY,t.ctrlKey,t.altKey,t.shiftKey,t.metaKey,0,null),s._constructed=!0,e.dispatchEvent(s))},n}();e.prototype={version:"5.1.3",_init:function(){this._initEvents()},destroy:function(){this._initEvents(!0),this._execEvent("destroy")},_transitionEnd:function(t){t.target==this.scroller&&this.isInTransition&&(this._transitionTime(),this.resetPosition(this.options.bounceTime)||(this.isInTransition=!1,this._execEvent("scrollEnd")))},_start:function(t){if(!(1!=o.eventType[t.type]&&0!==t.button||!this.enabled||this.initiated&&o.eventType[t.type]!==this.initiated)){!this.options.preventDefault||o.isBadAndroid||o.preventDefaultException(t.target,this.options.preventDefaultException)||t.preventDefault();var i,e=t.touches?t.touches[0]:t;this.initiated=o.eventType[t.type],this.moved=!1,this.distX=0,this.distY=0,this.directionX=0,this.directionY=0,this.directionLocked=0,this._transitionTime(),this.startTime=o.getTime(),this.options.useTransition&&this.isInTransition?(this.isInTransition=!1,i=this.getComputedPosition(),this._translate(s.round(i.x),s.round(i.y)),this._execEvent("scrollEnd")):!this.options.useTransition&&this.isAnimating&&(this.isAnimating=!1,this._execEvent("scrollEnd")),this.startX=this.x,this.startY=this.y,this.absStartX=this.x,this.absStartY=this.y,this.pointX=e.pageX,this.pointY=e.pageY,this._execEvent("beforeScrollStart")}},_move:function(t){if(this.enabled&&o.eventType[t.type]===this.initiated){this.options.preventDefault&&t.preventDefault();var i,e,n,r,h=t.touches?t.touches[0]:t,a=h.pageX-this.pointX,c=h.pageY-this.pointY,l=o.getTime();if(this.pointX=h.pageX,this.pointY=h.pageY,this.distX+=a,this.distY+=c,n=s.abs(this.distX),r=s.abs(this.distY),!(l-this.endTime>300&&10>n&&10>r)){if(this.directionLocked||this.options.freeScroll||(n>r+this.options.directionLockThreshold?this.directionLocked="h":r>=n+this.options.directionLockThreshold?this.directionLocked="v":this.directionLocked="n"),"h"==this.directionLocked){if("vertical"==this.options.eventPassthrough)t.preventDefault();else if("horizontal"==this.options.eventPassthrough)return void(this.initiated=!1);c=0}else if("v"==this.directionLocked){if("horizontal"==this.options.eventPassthrough)t.preventDefault();else if("vertical"==this.options.eventPassthrough)return void(this.initiated=!1);a=0}a=this.hasHorizontalScroll?a:0,c=this.hasVerticalScroll?c:0,i=this.x+a,e=this.y+c,(i>0||i<this.maxScrollX)&&(i=this.options.bounce?this.x+a/3:i>0?0:this.maxScrollX),(e>0||e<this.maxScrollY)&&(e=this.options.bounce?this.y+c/3:e>0?0:this.maxScrollY),this.directionX=a>0?-1:0>a?1:0,this.directionY=c>0?-1:0>c?1:0,this.moved||this._execEvent("scrollStart"),this.moved=!0,this._translate(i,e),l-this.startTime>300&&(this.startTime=l,this.startX=this.x,this.startY=this.y)}}},_end:function(t){if(this.enabled&&o.eventType[t.type]===this.initiated){this.options.preventDefault&&!o.preventDefaultException(t.target,this.options.preventDefaultException)&&t.preventDefault();var i,e,n=(t.changedTouches?t.changedTouches[0]:t,o.getTime()-this.startTime),r=s.round(this.x),h=s.round(this.y),a=s.abs(r-this.startX),c=s.abs(h-this.startY),l=0,p="";if(this.isInTransition=0,this.initiated=0,this.endTime=o.getTime(),!this.resetPosition(this.options.bounceTime))return this.scrollTo(r,h),this.moved?this._events.flick&&200>n&&100>a&&100>c?void this._execEvent("flick"):(this.options.momentum&&300>n&&(i=this.hasHorizontalScroll?o.momentum(this.x,this.startX,n,this.maxScrollX,this.options.bounce?this.wrapperWidth:0,this.options.deceleration):{destination:r,duration:0},e=this.hasVerticalScroll?o.momentum(this.y,this.startY,n,this.maxScrollY,this.options.bounce?this.wrapperHeight:0,this.options.deceleration):{destination:h,duration:0},r=i.destination,h=e.destination,l=s.max(i.duration,e.duration),this.isInTransition=1),r!=this.x||h!=this.y?((r>0||r<this.maxScrollX||h>0||h<this.maxScrollY)&&(p=o.ease.quadratic),void this.scrollTo(r,h,l,p)):void this._execEvent("scrollEnd")):(this.options.tap&&o.tap(t,this.options.tap),this.options.click&&o.click(t),void this._execEvent("scrollCancel"))}},_resize:function(){var t=this;clearTimeout(this.resizeTimeout),this.resizeTimeout=setTimeout(function(){t.refresh()},this.options.resizePolling)},resetPosition:function(t){var i=this.x,s=this.y;return t=t||0,!this.hasHorizontalScroll||this.x>0?i=0:this.x<this.maxScrollX&&(i=this.maxScrollX),!this.hasVerticalScroll||this.y>0?s=0:this.y<this.maxScrollY&&(s=this.maxScrollY),i==this.x&&s==this.y?!1:(this.scrollTo(i,s,t,this.options.bounceEasing),!0)},disable:function(){this.enabled=!1},enable:function(){this.enabled=!0},refresh:function(){this.wrapper.offsetHeight;this.wrapperWidth=this.wrapper.clientWidth,this.wrapperHeight=this.wrapper.clientHeight,this.scrollerWidth=this.scroller.offsetWidth,this.scrollerHeight=this.scroller.offsetHeight,this.maxScrollX=this.wrapperWidth-this.scrollerWidth,this.maxScrollY=this.wrapperHeight-this.scrollerHeight,this.hasHorizontalScroll=this.options.scrollX&&this.maxScrollX<0,this.hasVerticalScroll=this.options.scrollY&&this.maxScrollY<0,this.hasHorizontalScroll||(this.maxScrollX=0,this.scrollerWidth=this.wrapperWidth),this.hasVerticalScroll||(this.maxScrollY=0,this.scrollerHeight=this.wrapperHeight),this.endTime=0,this.directionX=0,this.directionY=0,this.wrapperOffset=o.offset(this.wrapper),this._execEvent("refresh"),this.resetPosition()},on:function(t,i){this._events[t]||(this._events[t]=[]),this._events[t].push(i)},off:function(t,i){if(this._events[t]){var s=this._events[t].indexOf(i);s>-1&&this._events[t].splice(s,1)}},_execEvent:function(t){if(this._events[t]){var i=0,s=this._events[t].length;if(s)for(;s>i;i++)this._events[t][i].apply(this,[].slice.call(arguments,1))}},scrollBy:function(t,i,s,e){t=this.x+t,i=this.y+i,s=s||0,this.scrollTo(t,i,s,e)},scrollTo:function(t,i,s,e){e=e||o.ease.circular,this.isInTransition=this.options.useTransition&&s>0,!s||this.options.useTransition&&e.style?(this._transitionTimingFunction(e.style),this._transitionTime(s),this._translate(t,i)):this._animate(t,i,s,e.fn)},scrollToElement:function(t,i,e,n,r){if(t=t.nodeType?t:this.scroller.querySelector(t)){var h=o.offset(t);h.left-=this.wrapperOffset.left,h.top-=this.wrapperOffset.top,e===!0&&(e=s.round(t.offsetWidth/2-this.wrapper.offsetWidth/2)),n===!0&&(n=s.round(t.offsetHeight/2-this.wrapper.offsetHeight/2)),h.left-=e||0,h.top-=n||0,h.left=h.left>0?0:h.left<this.maxScrollX?this.maxScrollX:h.left,h.top=h.top>0?0:h.top<this.maxScrollY?this.maxScrollY:h.top,i=void 0===i||null===i||"auto"===i?s.max(s.abs(this.x-h.left),s.abs(this.y-h.top)):i,this.scrollTo(h.left,h.top,i,r)}},_transitionTime:function(t){t=t||0,this.scrollerStyle[o.style.transitionDuration]=t+"ms",!t&&o.isBadAndroid&&(this.scrollerStyle[o.style.transitionDuration]="0.001s")},_transitionTimingFunction:function(t){this.scrollerStyle[o.style.transitionTimingFunction]=t},_translate:function(t,i){this.options.useTransform?this.scrollerStyle[o.style.transform]="translate("+t+"px,"+i+"px)"+this.translateZ:(t=s.round(t),i=s.round(i),this.scrollerStyle.left=t+"px",this.scrollerStyle.top=i+"px"),this.x=t,this.y=i},_initEvents:function(i){var s=i?o.removeEvent:o.addEvent,e=this.options.bindToWrapper?this.wrapper:t;s(t,"orientationchange",this),s(t,"resize",this),this.options.click&&s(this.wrapper,"click",this,!0),this.options.disableMouse||(s(this.wrapper,"mousedown",this),s(e,"mousemove",this),s(e,"mousecancel",this),s(e,"mouseup",this)),o.hasPointer&&!this.options.disablePointer&&(s(this.wrapper,o.prefixPointerEvent("pointerdown"),this),s(e,o.prefixPointerEvent("pointermove"),this),s(e,o.prefixPointerEvent("pointercancel"),this),s(e,o.prefixPointerEvent("pointerup"),this)),o.hasTouch&&!this.options.disableTouch&&(s(this.wrapper,"touchstart",this),s(e,"touchmove",this),s(e,"touchcancel",this),s(e,"touchend",this)),s(this.scroller,"transitionend",this),s(this.scroller,"webkitTransitionEnd",this),s(this.scroller,"oTransitionEnd",this),s(this.scroller,"MSTransitionEnd",this)},getComputedPosition:function(){var i,s,e=t.getComputedStyle(this.scroller,null);return this.options.useTransform?(e=e[o.style.transform].split(")")[0].split(", "),i=+(e[12]||e[4]),s=+(e[13]||e[5])):(i=+e.left.replace(/[^-\d.]/g,""),s=+e.top.replace(/[^-\d.]/g,"")),{x:i,y:s}},_animate:function(t,i,s,e){function r(){var u,f,d,m=o.getTime();return m>=p?(h.isAnimating=!1,h._translate(t,i),void(h.resetPosition(h.options.bounceTime)||h._execEvent("scrollEnd"))):(m=(m-l)/s,d=e(m),u=(t-a)*d+a,f=(i-c)*d+c,h._translate(u,f),void(h.isAnimating&&n(r)))}var h=this,a=this.x,c=this.y,l=o.getTime(),p=l+s;this.isAnimating=!0,r()},handleEvent:function(t){switch(t.type){case"touchstart":case"pointerdown":case"MSPointerDown":case"mousedown":this._start(t);break;case"touchmove":case"pointermove":case"MSPointerMove":case"mousemove":this._move(t);break;case"touchend":case"pointerup":case"MSPointerUp":case"mouseup":case"touchcancel":case"pointercancel":case"MSPointerCancel":case"mousecancel":this._end(t);break;case"orientationchange":case"resize":this._resize();break;case"transitionend":case"webkitTransitionEnd":case"oTransitionEnd":case"MSTransitionEnd":this._transitionEnd(t);break;case"wheel":case"DOMMouseScroll":case"mousewheel":this._wheel(t);break;case"keydown":this._key(t);break;case"click":t._constructed||(t.preventDefault(),t.stopPropagation())}}},e.utils=o,"undefined"!=typeof module&&module.exports?module.exports=e:t.IScroll=e}(window,document,Math);

//jQuery.noConflict();
(function($){
	var textPlaceHolderInit = function(){

		var havePlaceholder = false;
		var input = document.createElement("input");
		havePlaceholder = ("placeholder" in input);

		if(!havePlaceholder){
			$("input[type=text], textarea, input[type=password], textarea").each(function(idx, obj){
				var _this = $(this);
				var placeholderAttr = "placeholder";

				var placeholderText = _this.attr(placeholderAttr);

				/*
				if(_this.val() == ""){
					_this.val(placeholderText);
				}
				*/
				if(_this.prev(".placeholder_guidetext").length <= 0){
					_this.wrap("<span class='placeholder_wrap' style='display:block;position:relative'></span>");	// 20140423 최수빈
					_this.before("<span class=\"placeholder_guidetext\"></span>");
					var prevGuideText = _this.prev(".placeholder_guidetext");
					prevGuideText.css({"position":"absolute","top":"50%","left":"5px","margin-top":"-8px"}).text(placeholderText);
					prevGuideText.hide();
					if(_this.val() == ""){
						prevGuideText.show();
					}

					prevGuideText.addClass("placeholder_text");

					_this.bind("mousedown focus", function(e){
						prevGuideText.hide();
					}).bind("blur", function(e){
						if($(this).val() == ""){
							prevGuideText.show();
						}
					});

					prevGuideText.bind("mousedown", function(e){
						$(this).hide();
						setTimeout(function(){
							_this.focus();
						}, 100);
					});
				}
			});
		}
	};
	window.textPlaceHolderInit = textPlaceHolderInit;









	var agreement01 = (function(){
		var el;

		function init(){
			el = $('#join_agreement_load01');

			if(el.children().length <= 0){
				window.agreement01 = $.get('/html/carhartt/inc/layout/agreement01.html');
				window.agreement01.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			familysite등의 snbMain에 속한 스크립트는 snbMain안에서 서술
			*/
		}

		return {init: init};
	})();
	var agreement02 = (function(){
		var el;

		function init(){
			el = $('#join_agreement_load02');

			if(el.children().length <= 0){
				window.agreement02 = $.get('/html/carhartt/inc/layout/agreement02.html');
				window.agreement02.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			familysite등의 snbMain에 속한 스크립트는 snbMain안에서 서술
			*/
		}

		return {init: init};
	})();
	var agreement03 = (function(){
		var el;

		function init(){
			el = $('#join_agreement_load03');

			if(el.children().length <= 0){
				window.agreement03 = $.get('/html/carhartt/inc/layout/agreement03.html');
				window.agreement03.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			familysite등의 snbMain에 속한 스크립트는 snbMain안에서 서술
			*/
		}

		return {init: init};
	})();
	var agreement04 = (function(){
		var el;

		function init(){
			el = $('#join_agreement_load04');

			if(el.children().length <= 0){
				window.agreement04 = $.get('/html/carhartt/inc/layout/agreement04.html');
				window.agreement04.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			familysite등의 snbMain에 속한 스크립트는 snbMain안에서 서술
			*/
		}

		return {init: init};
	})();














	var header = (function(){
		var el;

		function init(){
			el = $('#header');

			if(el.children().length <= 0){
				window.header = $.get('/html/carhartt/inc/layout/header.html');
				window.header.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			gnb등의 header에 속한 스크립트는 header안에서 서술
			*/

			utilMenu.init();
		}

		return {init: init};
	})();

	var footer = (function(){
		var el;

		function init(){
			el = $('#footer');

			if(el.children().length <= 0){
				window.footer = $.get('/html/carhartt/inc/layout/footer.html');
				window.footer.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			familysite등의 footer에 속한 스크립트는 footer안에서 서술
			*/

			footerNewsLetter.init();
		}

		return {init: init};
	})();

	var snbMain = (function(){
		var el;

		function init(){
			el = $('#snb_main_area');

			if(el.children().length <= 0){
				window.snbMain = $.get('/html/carhartt/inc/layout/snb_main.html');
				window.snbMain.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			familysite등의 snbMain에 속한 스크립트는 snbMain안에서 서술
			*/
		}

		return {init: init};
	})();

	var snbShop = (function(){
		var el;

		function init(){
			el = $('#snb_shop_area');

			if(el.children().length <= 0){
				window.snbShop = $.get('/html/carhartt/inc/layout/snb_shop.html');
				window.snbShop.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			familysite등의 snbMain에 속한 스크립트는 snbMain안에서 서술
			*/

			allMenu.init();
			allMenu02.init();

			shopSelect.init();
		}

		return {init: init};
	})();

	var snbNews = (function(){
		var el;

		function init(){
			el = $('#snb_news_area');

			if(el.children().length <= 0){
				window.snbNews = $.get('/html/carhartt/inc/layout/snb_news.html');
				window.snbNews.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			familysite등의 snbMain에 속한 스크립트는 snbMain안에서 서술
			*/
		}

		return {init: init};
	})();

	var snbStoreInfo = (function(){
		var el;

		function init(){
			el = $('#snb_store_info_area');

			if(el.children().length <= 0){
				window.snbStoreInfo = $.get('/html/carhartt/inc/layout/snb_store_info.html');
				window.snbStoreInfo.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			familysite등의 snbMain에 속한 스크립트는 snbMain안에서 서술
			*/
		}

		return {init: init};
	})();

	var snbLookBook = (function(){
		var el;

		function init(){
			el = $('#snb_lookbook_area');

			if(el.children().length <= 0){
				window.snbLookBook = $.get('/html/carhartt/inc/layout/snb_lookbook.html');
				window.snbLookBook.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			familysite등의 snbMain에 속한 스크립트는 snbMain안에서 서술
			*/
		}

		return {init: init};
	})();



	var snbJoin = (function(){
		var el;

		function init(){
			el = $('#snb_join_area');

			if(el.children().length <= 0){
				window.snbJoin = $.get('/html/carhartt/inc/layout/snb_join.html');
				window.snbJoin.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			familysite등의 snbMain에 속한 스크립트는 snbMain안에서 서술
			*/
		}

		return {init: init};
	})();


	var snbMypage = (function(){
		var el;

		function init(){
			el = $('#snb_mypage_area');

			if(el.children().length <= 0){
				window.snbMypage = $.get('/html/carhartt/inc/layout/snb_mypage.html');
				window.snbMypage.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			familysite등의 snbMain에 속한 스크립트는 snbMain안에서 서술
			*/
		}

		return {init: init};
	})();




	var snbCart = (function(){
		var el;

		function init(){
			el = $('#snb_cart_area');

			if(el.children().length <= 0){
				window.snbCart = $.get('/html/carhartt/inc/layout/snb_cart.html');
				window.snbCart.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			familysite등의 snbMain에 속한 스크립트는 snbMain안에서 서술
			*/
		}

		return {init: init};
	})();





	var snbOrder = (function(){
		var el;

		function init(){
			el = $('#snb_order_area');

			if(el.children().length <= 0){
				window.snbOrder = $.get('/html/carhartt/inc/layout/snb_order.html');
				window.snbOrder.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			familysite등의 snbMain에 속한 스크립트는 snbMain안에서 서술
			*/
		}

		return {init: init};
	})();




	var snbContactUs = (function(){
		var el;

		function init(){
			el = $('#snb_contact_us_area');

			if(el.children().length <= 0){
				window.snbContactUs = $.get('/html/carhartt/inc/layout/snb_contact_us.html');
				window.snbContactUs.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			familysite등의 snbMain에 속한 스크립트는 snbMain안에서 서술
			*/
		}

		return {init: init};
	})();




	var snbWorkWithUs = (function(){
		var el;

		function init(){
			el = $('#snb_work_with_us_area');

			if(el.children().length <= 0){
				window.snbWorkWithUs = $.get('/html/carhartt/inc/layout/snb_work_with_us.html');
				window.snbWorkWithUs.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			familysite등의 snbMain에 속한 스크립트는 snbMain안에서 서술
			*/
		}

		return {init: init};
	})();




	var snbSearch = (function(){
		var el;

		function init(){
			el = $('#snb_search_area');

			if(el.children().length <= 0){
				window.snbSearch = $.get('/html/carhartt/inc/layout/snb_search.html');
				window.snbSearch.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			familysite등의 snbMain에 속한 스크립트는 snbMain안에서 서술
			*/
		}

		return {init: init};
	})();




	var snbAboutUs = (function(){
		var el;

		function init(){
			el = $('#snb_about_us');

			if(el.children().length <= 0){
				window.snbSearch = $.get('/html/carhartt/inc/layout/snb_about_us.html');
				window.snbSearch.done(function(data){
					el.html(data);

					setTimeout(function(){
						complete();
					}, 0);
				});
			}else{
				complete();
			}
		}

		function complete(){
			/*
			ex)

			familysite등의 snbMain에 속한 스크립트는 snbMain안에서 서술
			*/
		}

		return {init: init};
	})();




	var overImg = (function(){
		var el;

		function init(){
			el = $('.main_visual > li');

			setGrayscale();

			el.on('mouseenter_effect', '> a', function(e){
				var $this = $(this);
				var imgWidth = $this.find('img').width();
				var imgHeight = $this.find('img').height();

				if($this.data('active')){
					return;
				}

				$this.data('active', true);

				$this.css({position:'relative', width: imgWidth, height: imgHeight});

				if($this.find('img').length <= 1){
					$this.append($this.find('img').eq(0).clone());
					$this.find('img').css({position: 'absolute', left: 0, top: 0, zIndex: 1, opacity: 1});
					$this.find('img').eq(1).removeClass('grayscale').css({zIndex: 2});
				}

				$this.find('img').eq(0).css({zIndex: 1, opacity: 1});
				$this.find('img').eq(1).removeClass('grayscale')
					.css({opacity: 0})
					// .attr('src', $this.find('img').eq(1).attr('src').replace('_off.jpg', '_on.jpg'))
					.stop().animate({opacity: 1}, 1400);


			}).on('mouseleave_effect', '> a', function(e){
				var $this = $(this);

				$this.data('active', false);

				$this.find('img').eq(1)//.addClass('grayscale')
					.stop().animate({opacity: 0}, 800, function(){
						$(this).remove();
					});
				// $this.find('img').eq(0).removeAttr('style');

				// $this.removeAttr('style');
			});
		}

		function setGrayscale(){
			$(document).ready(function() {

				// Grayscale images on Safari and Opera browsers
				if(getBrowser()=='opera' || getBrowser()=='safari'){
					var $images = $(".grayscale")
					, imageCount = $images.length
					, counter = 0;

					// One instead of on, because it need only fire once per image
					$images.one("load",function(){
						// increment counter every time an image finishes loading
						counter++;
						if (counter == imageCount) {
							// do stuff when all have loaded
							grayscale($('.grayscale'));
						}
					}).each(function () {
					if (this.complete) {
						// manually trigger load event in
						// event of a cache pull
							$(this).trigger("load");
						}
					});
				};


				// Grayscale images only on browsers IE10+ since they removed support for CSS grayscale filter
				if (getInternetExplorerVersion() >= 10){
					$('.grayscale').each(function(){
						var el = $(this);
						el.css({"position":"absolute"}).wrap("<div class='img_wrapper' style='display: inline-block'>").clone().addClass('img_grayscale').css({"position":"absolute","z-index":"1","opacity":"1"}).insertBefore(el).queue(function(){
							var el = $(this);
							el.parent().css({"width":this.width,"height":this.height});
							el.dequeue();
						});
						this.src = grayscaleIE10(this.src);
					});

					function grayscaleIE10(src){
						var canvas = document.createElement('canvas');
						var ctx = canvas.getContext('2d');
						var imgObj = new Image();
						imgObj.src = src;
						canvas.width = imgObj.width;
						canvas.height = imgObj.height;
						ctx.drawImage(imgObj, 0, 0);
						var imgPixels = ctx.getImageData(0, 0, canvas.width, canvas.height);
						for(var y = 0; y < imgPixels.height; y++){
							for(var x = 0; x < imgPixels.width; x++){
								var i = (y * 4) * imgPixels.width + x * 4;
								var avg = (imgPixels.data[i] + imgPixels.data[i + 1] + imgPixels.data[i + 2]) / 3;
								imgPixels.data[i] = avg;
								imgPixels.data[i + 1] = avg;
								imgPixels.data[i + 2] = avg;
							}
						}
						ctx.putImageData(imgPixels, 0, 0, 0, 0, imgPixels.width, imgPixels.height);
						return canvas.toDataURL();
					};
				};

				// This block simply ads a corresponding class to the body tag so that we can target browsers with CSS classes
				if(getBrowser()=='mozilla'){
					// Mozilla
					$('body').addClass('mozilla');
				}
				else if(getBrowser()=='ie'){
					// IE Favourite
					$('body').addClass('ie');
				}
				else if(getBrowser()=='opera'){
					// Opera
					$('body').addClass('opera');
				}
				else if (getBrowser()=='safari'){ // safari
					// Safari
					$('body').addClass('safari');
				}
				else if(getBrowser()=='chrome'){
					// Chrome
					$('body').addClass('chrome');
				};
				if (getInternetExplorerVersion() >= 10){
					$('body').addClass('ie11');
				};

				// Detection function to tell what kind of browser is used
				function getBrowser(){
					var userAgent = navigator.userAgent.toLowerCase();
					var chrome = /chrome/.test(userAgent);
					var safari= /webkit/.test(userAgent);
					var opera=/opera/.test(userAgent);
					var msie=/msie/.test( userAgent ) && !/opera/.test( userAgent );
					var mozilla= /mozilla/.test( userAgent ) && !/(compatible|webkit)/.test( userAgent ) || /firefox/.test(userAgent);

					if(chrome) return "chrome";
					if(mozilla) return "mozilla";
					if(opera) return "opera";
					if(safari) return "safari";
					if(msie) return "ie";
				};

				// Since IE11 can not be detected like this because the new user agent on IE11 is trying to hide as Mozilla
				// we detect IE11 with this function
				function getInternetExplorerVersion(){
					var rv = -1;
					if (navigator.appName == 'Microsoft Internet Explorer'){
						var ua = navigator.userAgent;
						var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
						if (re.exec(ua) != null)
						rv = parseFloat( RegExp.$1 );
					}
					else if (navigator.appName == 'Netscape'){
						var ua = navigator.userAgent;
						var re  = new RegExp("Trident/.*rv:([0-9]{1,}[\.0-9]{0,})");
						if (re.exec(ua) != null)
						rv = parseFloat( RegExp.$1 );
					}
					return rv;
				};
			});
		}

		return {init: init};
	})();

	var fullScroll = (function(){
		var el;
		var list;
		var imgHeight;
		var paddingTop;
		var liHeight;
		var scrollAnimated;
		var currentId = -1;

		function init(){
			el = $('.main_visual');
			list = el.find('> li');
			scrollAnimated = false;

			if(el.length > 0){
				if($(window).width() <= 1024){
					$(window).on('load', function(e){
						tabletNPhone();
					});

					return;
				}
				if(list.eq(0).find('>a').height() > 0){
					bindEvents();
				}else{
					$(window).on('load', function(e){
						bindEvents();
					});
				}
			}
		}

		function tabletNPhone(){
			$(window).on('resize', function(e){
				//list.find('>a').trigger('mouseleave_effect');

				imgHeight = list.eq(0).find('>a').height();

				// paddingTop = Math.ceil((window.innerHeight - imgHeight)/2);
				paddingTop = 115;
				// liHeight = window.innerHeight - paddingTop;
				el.css({position: 'relative', top: -115});
				list.css({height: liHeight, paddingTop: paddingTop, borderBottom: '0px solid #f00'});
			}).triggerHandler("resize");

			$(window).on('scroll', function(e){
				list.each(function(idx, obj){
					var top = $(window).scrollTop() < $(this).find('a').offset().top - 50;
					var bottom = $(window).scrollTop() + window.innerHeight > $(this).find('a').offset().top + $(this).find('a').height() + 50;

					if(top && bottom){
						list.eq(idx).find('>a').trigger('mouseenter_effect');
						currentId = idx;
					}else{
						list.eq(idx).find('>a').trigger('mouseleave_effect');
					}
				});
			});

			list.eq(0).find('>a').trigger('mouseenter_effect');
		}

		function bindEvents(){
			$(window).on('resize', function(e){
				list.find('>a').trigger('mouseleave_effect');

				imgHeight = list.eq(0).find('>a').height();

				// paddingTop = Math.ceil((window.innerHeight - imgHeight)/2);
				paddingTop = 115;
				liHeight = window.innerHeight - paddingTop;
				el.css({position: 'relative', top: -115});
				list.css({height: liHeight, paddingTop: paddingTop, borderBottom: '0px solid #f00'});
			}).triggerHandler("resize");

			$(window).on('scroll', function(e){
				e.preventDefault();
				e.stopPropagation();
				return false;
			});

			list.eq(0).find('>a').trigger('mouseenter_effect');

			$(window).on('mousewheel', function(e){
				if(scrollAnimated){
					e.preventDefault();
					return;
				}
				scrollAnimated = true;
				var windowHeight = window.innerHeight;
				// console.log($(window).scrollTop(), window.innerHeight, $(window).scrollTop()/window.innerHeight);
				currentId = Math.ceil($(window).scrollTop()/window.innerHeight);

				if(e.deltaY < 0){
					$('html, body').stop().animate({scrollTop: (currentId + 1) * windowHeight}, 800, function(){
						scrollAnimated = false;
// console.log(currentId + 1);
						list.find('>a').trigger('mouseleave_effect');
						list.eq(currentId + 1).find('>a').trigger('mouseenter_effect');
					});
				}else{
					$('html, body').stop().animate({scrollTop: (currentId - 1) * windowHeight}, 800, function(){
						scrollAnimated = false;
// console.log(currentId - 1);
						list.find('>a').trigger('mouseleave_effect');
						list.eq(currentId - 1).find('>a').trigger('mouseenter_effect');
					});
				}
			});
		}

		return {init: init};
	})();

	window.utilMenu = (function(){
		var el;
		var pastHeight;
		var currentHeight;
		var mouseLeaveTimer = -1;

		function init(){
			el = $('.util_menu');
			pastHeight = 55;

			if(el.length <= 0){
				return;
			}
			bindEvents();

			$('.cart_slide_area').each(function(idx, obj){
				new utilCartRolling().init(obj);
			});
		}

		function bindEvents(){
			el.find('> li').on('mouseenter', function(e){
				var $this = $(this);

				clearTimeout(mouseLeaveTimer);

				el.find('> li').removeClass('on');
				$this.addClass('on');

				el.find('> li').find('.util_add').hide();
				$this.find('.util_add').show();
				currentHeight = $this.find('.add_content').outerHeight(true);

				$this.find('.util_add').css({height: pastHeight, overflow: 'hidden'});
				pastHeight = currentHeight;
				$this.find('.util_add').animate({height: currentHeight}, 200);
			}).on('mouseleave', function(e){
				mouseLeaveTimer = setTimeout(mouseLeaveAction, 300);
			});
		}

		function mouseLeaveAction(){
			el.find('> li.on').find('.util_add').animate({opacity: 0}, 100, function(){
				el.find('> li').find('.util_add').each(function(idx, obj){
					$(this).removeAttr('style')
					pastHeight = 55;
				});
			});
		}

		function refresh(){
			el.find('> li.on').trigger('mouseenter');
		}

		return {
			init: init
			, refresh: refresh
		}
	})();

	var utilCartRolling = function(){
		var el;
		var btnUp;
		var btnDown;
		var rollingWrap;
		var rollingWrapHeight;
		var rollingBody;
		var pageSize;
		var totalCount;
		var currentId;


		function init(_el){
			el = $(_el);

			if(el.length <= 0){
				return;
			}

			btnUp = el.find('.btn_cart_up');
			btnDown = el.find('.btn_cart_down');

			rollingWrap = el.find('.cart_slide_container');
			rollingBody = el.find('.cart_slide');

			currentId = 0;
			rollingWrapHeight = rollingWrap.height() - btnDown.height();
			totalCount = rollingBody.find('>div').length;
			pageSize = Math.ceil(totalCount/3);

			bindEvents();

			return this;
		}

		function bindEvents(){
			btnUp.on('click', function(e){
				e.preventDefault();

				--currentId;

				if(currentId < 0){
					// currentId = pageSize - 1;
					currentId = 0;
					return;
				}

				moveRolling();
			});

			btnDown.on('click', function(e){
				e.preventDefault();

				++currentId;

				if(currentId > pageSize - 1){
					//currentId = 0;
					currentId = pageSize - 1;
					return;
				}

				moveRolling();
			});
		}

		function moveRolling(){
			rollingBody.animate({marginTop: -currentId * rollingWrapHeight}, 500);
		}

		return {init: init};
	};

	var allMenu = (function(){
		var el;
		var menuPanel;
		var menuPanelBtnClose;

		function init(){
			el = $('.btn_all_menu:not(.close)');
			menuPanel = $('.all_menu_wrap');
			menuPanelBtnClose = menuPanel.find('.btn_all_menu');

			el.find('img').css({opacity: 0.3, position:'absolute', top:0, left:0});
			TweenMax.set(el.find('rect:eq(0)'), {y: 5});
			TweenMax.set(el.find('rect:eq(1)'), {y: 45});
			TweenMax.set(el.find('rect:eq(2)'), {y: 85});

			bindEvents();
		}

		function bindEvents(){
			el.on('click', function(e){
				e.preventDefault();

				if($(this).hasClass('active')){
					$(this).removeClass('active');
					$('.header_content').css({zIndex: 1});
					menuPanel.stop().css({opacity: 1}).show().animate({opacity: 0}, 300, function(){
						$(this).hide();
						// menuPanelBtnClose.off('click').on('click', function(e){
						// 	menuPanel.animate({opacity: 0}, 300, function(){
						// 		$(this).hide();
						// 	});
						// 	menuPanelBtnClose.off('click');
						// });
					});

					TweenMax.to(el.find('rect:eq(0)'), 0.5, {y: 5, x: 0, rotation: 0});
					TweenMax.to(el.find('rect:eq(1)'), 0.5, {y: 45, rotation: 0});
					TweenMax.to(el.find('rect:eq(2)'), 0.5, {y: 85, x:0, rotation: 0});
					return;
				}

				$(this).addClass('active');

				$('.header_content').css({zIndex: 60});
				menuPanel.stop().css({opacity: 0}).show().animate({opacity: 1}, 300, function(){
					// menuPanelBtnClose.off('click').on('click', function(e){
					// 	menuPanel.animate({opacity: 0}, 300, function(){
					// 		$(this).hide();
					// 	});
					// 	menuPanelBtnClose.off('click');
					// });
				});

				TweenMax.to(el.find('rect:eq(0)'), 0.5, {y: 85, x: 10, rotation: -45});
				TweenMax.to(el.find('rect:eq(1)'), 0.5, {y: 45, rotation: -180});
				TweenMax.to(el.find('rect:eq(2)'), 0.5, {y: 15, x: 15, rotation: 45});

			});
		}

		return {init: init};
	})();

	// 20150827 allMenu02함수 내 소스 수정
	//- 임시 모바일, 태블릿용 allMenu02
	var allMenu02 = (function(){
		var el;
		var menuPanel;
		var menuPanelBtnClose;
		// var isWeb;
		var iscroll;
		var cartIscroll;

		function init(){
			el = $('.btn_all_menu02:not(.close)');
			menuPanel = $('.all_menu_wrap02');
			menuPanelBtnClose = menuPanel.find('.btn_all_menu02');
			// isWeb = $('.btn_all_menu02').is(':visible');
			// console.log(el.find('rect:eq(0)'));
			el.find('img').css({opacity: 0.3, position:'absolute', top:0, left:0});
			TweenMax.set(el.find('rect:eq(0)'), {y: 0});
			TweenMax.set(el.find('rect:eq(1)'), {y: 30});
			TweenMax.set(el.find('rect:eq(2)'), {y: 60});

			bindEvents();
		}

		function bindEvents(){
			el.on('click', function(e){
				e.preventDefault();

				if($(this).hasClass('active')){
					// console.log('close');

					menuPanel.transition({x: -275}, 300, function(){
						$(this).hide();
					});
					$('.header_content').transition({x: 0}, 500);
					$('#container').transition({x: 0}, 500);
					el.find('img').show();
					// menuPanelBtnClose.hide().off('click');
					$('body').css({overflow: 'auto'});
					$(document).off('.iscroll');

					menuPanel.find('.util_menu02>li>a').off('click');
					iscroll.destroy();
					$(this).removeClass('active');

					TweenMax.to(el.find('rect:eq(0)'), 0.5, {rotation: 0, y:0, attr: {width: 100}});
					TweenMax.to(el.find('rect:eq(1)'), 0.5, {y: 30});
					TweenMax.to(el.find('rect:eq(2)'), 0.5, {rotation: 0, y: 60, x: 0, attr: {width: 100}});
					return;
				}

				$(this).addClass('active');
				$('body').css({overflow: 'hidden'});
				$(document).on('touchmove.iscroll', function(e){e.preventDefault();});

				el.find('img').hide();
				// menuPanelBtnClose.show();

				menuPanel.stop().css({x: -275}).show().transition({x: 0}, 300, function(){
					TweenMax.to(el.find('rect:eq(0)'), 0.5, {rotation: -45, y:30, attr: {width: 46}});
					TweenMax.to(el.find('rect:eq(1)'), 0.5, {y: 30});
					TweenMax.to(el.find('rect:eq(2)'), 0.5, {rotation: 45, y: 35, x: 7, attr: {width: 46}});

					iscroll = new IScroll(menuPanel.get(0), {click: true});
					// console.log(menuPanel.find('.util_menu02>li>a'));
					menuPanel.find('.util_menu02>li>a').off('click').on('click', function(e){
						e.preventDefault();

						menuPanel.find('.util_menu02>li .util_add').hide();
						var utilAdd = $(this).closest('li').find('.util_add');
						utilAdd.show();

						if($(this).closest('li').is(':last-child')){
							$('.all_menu_list02').hide();
							$('.cart_ctr').hide();
							$('.cart_slide_area').css({paddingTop: 0});
							$('.cart_slide_container:visible').css({height: 0});
							$('.cart_slide_container:visible').height(window.innerHeight - $('.add_content:visible').outerHeight(true));

							menuPanel.find('.util_menu_area02').height(window.innerHeight);

							iscroll.destroy();
							cartIscroll = new IScroll($('.cart_slide_container:visible').get(0), {
								click: true
								, scrollbars: true
							});
							cartIscroll.refresh();
							window.cartIscroll = cartIscroll;
						}else{
							$('.all_menu_list02').show();
							menuPanel.find('.util_menu_area02').height(utilAdd.height());
						}

						iscroll.refresh();
					});

					// menuPanelBtnClose.off('click').on('click', function(e){
					// 	e.preventDefault();

					// 	menuPanel.transition({x: -275}, 300, function(){
					// 		$(this).hide();
					// 	});
					// 	$('.header_content').transition({x: 0}, 500);
					// 	$('#container').transition({x: 0}, 500);
					// 	el.find('img').show();
					// 	menuPanelBtnClose.hide().off('click');
					// 	$('body').css({overflow: 'auto'});
					// 	$(document).off('.iscroll');

					// 	menuPanel.find('.util_menu02>li>a').off('click');
					// 	iscroll.destroy();
					// });
				});

				$('.header_content').transition({x: 275}, 500);
				$('#container').transition({x: 275}, 500);
			});
		}

		return {init: init};
	})();

	var shopSelect = (function(){
		var el;
		var iscroll;
		var pastIndex = -1;

		function init(){
			el = $('.snb_mobile_container');

			if(el.length <= 0){
				return;
			}

			bindEvents();
		}

		function bindEvents(){
			el.find('.snb_mobile_menu>li>a').on('click', function(e){
				e.preventDefault();

				var index = $(this).closest('li').index();

				if(pastIndex == index){
					el.find('.snb_mobile_menu>li>a').removeClass('on');
					el.find('.snb_mobile_sub_menu').hide();
					el.find('.snb_mobile_sub_menu>div>div>div').hide();
					iscroll.destroy();
					iscroll = undefined;
					$(document).off('.iscroll');
					pastIndex = -1;
					return;
				}
				pastIndex = index;

				el.find('.snb_mobile_menu>li>a').removeClass('on').eq(index).addClass('on');
				el.find('.snb_mobile_sub_menu').css({opacity: 0}).show();
				var containerHeight = (window.innerHeight || $(window).height()) - el.find('.snb_mobile_sub_menu').offset().top + 25;
				el.find('.snb_mobile_sub_menu').css({height: containerHeight, opacity: 1, overflow: 'hidden'});
				el.find('.snb_mobile_sub_menu>div>div>div').hide().eq(index).show();

				$(document).on('touchmove.iscroll', function(e){e.preventDefault();});
				if(!iscroll){
					iscroll = new IScroll(el.find('.snb_mobile_sub_menu').get(0), {});
				}

				iscroll.refresh();
			});
		}

		return {init: init};
	})();

	var productDetailTab = (function(){
		var el;

		function init(){
			el = $('.product_detail_type');

			if(el.length <= 0){
				return;
			}

			bindEvents();
		}

		function bindEvents(){
			$(window).on('orientationchange', function(e){
				el.find('>a').removeClass('on');
				el.find('>div, >ul').hide();
			});

			el.find('>a').on('click', function(e){
				e.preventDefault();

				if($(this).hasClass('on')){
					el.find('>a').removeClass('on');
					el.find('>div, >ul').hide();
				}else{
					el.find('>a').removeClass('on');
					$(this).addClass('on');
					el.find('>div, >ul').hide();
					$(this).next().show();
				}
			});
		}

		return {init: init};
	})();

	var contactUsExpand = (function(){
		var el;

		function init(){
			el = $('.contact_us_unit');

			if(el.length <= 0){
				return;
			}

			bindEvents();
		}

		function bindEvents(){
			el.find('.contact_us_tit').on('click', function(e){
				e.preventDefault();

				if($(this).hasClass('on')){
					el.find('.contact_us_tit').removeClass('on');
					el.find('.contact_us_content').hide();
				}else{
					el.find('.contact_us_tit').removeClass('on');
					$(this).addClass('on');
					el.find('.contact_us_content').hide();
					$(this).next().show();
				}
			});
		}

		return {init: init};
	})();

	var footerNewsLetter = (function(){
		var el;

		function init(){
			el = $('.ui_btn_news_letter');

			if(el.length <= 0){
				return;
			}

			bindEvents();
		}

		function bindEvents(){
			el.on('click', function(e){
				e.preventDefault();

				$('.footer_newsletter_area').show();

				setTimeout(function(){
					$(document).on('click.news_letter', function(e){
						if($(e.target).closest('.footer_newsletter_area').length <= 0){
							$('.footer_newsletter_area').hide();
							$(document).off('.news_letter');
						}
					}).on('keyup.news_letter', function(e){
						if(e.keyCode == 27){
							$(document).triggerHandler('click');
						}
					});
				}, 10);
			});
		}

		return {init: init};
	})();

	var lookBook = (function(){
		var el;
		var detail;
		var list;
		var pastElWidth;
		var objSwipeDetail;
		var objSwipeList;
		var btnDetailPrev;
		var btnDetailNext;
		var detailInfoList;
		var detailWrap;
		var count;
		var totalCount;
		var currentCount;
		var btnDetailViewType;
		var btnListViewType;
		var listBody;

		function init(){
			el = $('.ui_lookbook');

			if(el.length <= 0){
				return;
			}

			detail = el.find('.ui_lookbook_detail');
			list = el.find('.ui_lookbook_list');

			listBody = list.find('.ui_lookbook_list_body');

			detailWrap = el.find('.ui_lookbook_detail_wrap');

			btnDetailPrev = el.find('.ui_btn_prev');
			btnDetailNext = el.find('.ui_btn_next');

			btnDetailViewType = el.find('.ui_btn_detail_view_type');
			btnListViewType = el.find('.ui_btn_list_view_type');

			count = el.find('.count');

			detailInfoList = el.find('.lookbook_item_info_list');

			totalCount = detailWrap.find('.lookbook_item').length;
			currentCount = 0;
			viewDetailText(0);
			setCount();
			bindEvents();
		}

		function imgVerticalAlign(){
			detailWrap.css({height: detailWrap.find('>div>div img').eq(currentCount).height()});
			// detailWrap.find('>div>div').each(function(idx, obj){
			// 	$(this).find('img').css({marginTop: Math.ceil((detailWrap.height() - $(this).find('img').height())/2)});
			// });
		}

		function bindEvents(){
			$(window).on('resize', function(e){
				if(pastElWidth == $(window).width()){
					return;
				}
				detail.css({width: el.width()});
				list.css({width: el.width()});

				pastElWidth = $(window).width();

				//imgVerticalAlign();
			}).trigger('resize');

			$(window).on('load', function(e){
				e.preventDefault();

				imgVerticalAlign();
			});


			objSwipeDetail = Swipe(detailWrap.get(0), {
			// startSlide: 4,
			// auto: 3000,
			// continuous: true,
			// disableScroll: true,
			// stopPropagation: true,
				// callback: function(index, element) {

				// },
				transitionEnd: function(index, element) {
					currentCount = index;

					viewDetailText();
					setCount();
					imgVerticalAlign();
				}
			});

			btnDetailPrev.on('click', function(e){
				e.preventDefault();

				objSwipeDetail.prev();
			});

			btnDetailNext.on('click', function(e){
				e.preventDefault();

				objSwipeDetail.next();
			});

			btnDetailViewType.on('click', function(e){
				e.preventDefault();

				if(detail.hasClass('active')){
					showList();

					listBody.on('click', '>a', function(e){
						e.preventDefault();

						var index = $(this).index();

						if(index >= 0 && index < 5){
							currentCount = index;

							objSwipeDetail.slide(index);
							viewDetailText();
							setCount();

							showDetail();
						}else{
							alert('테스트 기능이므로 1~5만 테스트 가능\n개발할 시 모든 번호 작동 ');
						}
					});
				}
			});

			btnListViewType.on('click', function(e){
				e.preventDefault();

				if(list.hasClass('active')){
					showDetail();
				}
			});
		}

		function showDetail(){
			detail.addClass('active').show();
			list.removeClass('active').hide();

			var windowHeight = window.innerHeight || $(window).height();
			var wrapperHeight = windowHeight - list.outerHeight();

			$('#container').height(wrapperHeight + detail.outerHeight());

			listBody.off('click');
		}

		function showList(){
			detail.removeClass('active').hide();
			list.addClass('active').show();

			var windowHeight = window.innerHeight || $(window).height();
			var wrapperHeight = windowHeight - detail.outerHeight();

			$('#container').height(wrapperHeight + list.outerHeight());
		}

		function viewDetailText(){
			var obj = detailWrap.find('.lookbook_item').eq(currentCount);

			$(obj).find('ul>li').each(function(idx, obj){
				detailInfoList.find('li').eq(idx).text($(obj).text());
			});
		}

		function setCount(){
			count.text((currentCount+1) + '/' + totalCount);
		}

		return {init: init};
	})();

	var snbShopFolding = (function(){
		var el;

		function init(){
			window.snbShop.done(function(){
				el = $('.ui_snb_shop');

				if(el.length <= 0){
					return;
				}

				bindEvents();
			});
		}

		function bindEvents(){
			el.find('.ico_arrow').each(function(){
				var $this = $(this);

				$this.on('click', function(e){
					e.preventDefault();

					if($(this).closest('.snb_depth01').hasClass('on')){
						$(this).closest('.snb_depth01').removeClass('on');
						$(this).next().hide();
					}else{
						el.find('.snb_depth01').removeClass('on');
						el.find('.snb_depth02_area').hide();
						$(this).closest('.snb_depth01').addClass('on');
						$(this).next().show();
					}
				});
			});
		}

		return {init: init};
	})();

	var mypageBtnGrade = (function(){
		var el;
		var layer;
		var dimm;
		var btnClose;

		function init(){
			el = $('.ui_btn_grade');

			if(el.length <= 0){
				return;
			}

			layer = $('.ui_layer_grade');
			dimm = $('.dimm');
			btnClose = layer.find('.layer_btn_close');

			bindEvents();
		}

		function bindEvents(){
			el.on('click', function(e){
				e.preventDefault();

				if(!layer.hasClass('active')){
					layer.addClass('active').show();
					dimm.css({opacity: 0}).show().animate({opacity: 0.6}, 300);

					window.focusBtnLayer = this;

					layer.attr({tabindex: 0}).focus();

					btnClose.on('click', function(e){
						e.preventDefault();

						layer.removeClass('active').hide();
						dimm.hide();

						window.focusBtnLayer.focus();
						btnClose.off('click');
					});
				}
			});
		}

		return {init: init};
	})();

	var responsibleTableType01 = (function(){
		var el;
		var setTh;

		function init(){
			el = $('.ui_reponsible_table_type01');

			if(el.length <= 0){
				return;
			}

			bindEvents();
		}

		function bindEvents(){
			//- 테이블 안에서 .mobile_th 가 발견되면
			//- thead 의 th 에서 텍스트를 가져와서 .mobile_th 에 꼽아 준다.
			//- 모바일 디바이스 분기태워서 꼽을 필요 없음.
			//- 무조건 꼽아 놓으면 미디어쿼리로 보이고 안보이게 함.
			el.each(function(idx, obj){
				setTh = $(obj).find('thead th');

				$(obj).find('.mobile_th').each(function(){
					var index = $(this).closest('td').index();

					$(this).text(setTh.eq(index).text());
				});
			});
		}

		return {init: init};
	})();

	// var expandUI = (function(){
	// 	var el;

	// 	function init(){
	// 		el = $('.ui_expand');

	// 		if(el.length <= 0){
	// 			return;
	// 		}

	// 		bindEvents();
	// 	}

	// 	function bindEvents(){
	// 		el.each(function(idx, obj){
	// 			setTh = $(obj).find('thead th');

	// 			$(obj).find('.mobile_th').each(function(){
	// 				var index = $(this).closest('td').index();

	// 				$(this).text(setTh.eq(index).text());
	// 			});
	// 		});
	// 	}

	// 	return {init: init};
	// })();

	var expandMypageBtn = (function(){
		var el;
		var expandBody;

		function init(){
			el = $('.ui_expand_btn_mypage');

			if(el.length <= 0){
				return;
			}

			expandBody = $('.ui_expand_body_mypage');
			bindEvents();
		}

		function bindEvents(){
			el.on('click', function(e){
				e.preventDefault();

				if(expandBody.hasClass('off')){
					expandBody.removeClass('off');
					el.removeClass('off');
				}else{
					expandBody.addClass('off');
					el.addClass('off');
				}
			});
		}

		return {init: init};
	})();

	var layerPopupUI = (function(){
		var el;
		var options;

		function init(){
			el = $('.ui_btn_popup');

			if(el.length <= 0){
				return;
			}

			bindEvents();
		}

		function bindEvents(){
			el.on('click', function(e){
				e.preventDefault();

				var $this = $(this);
				window.focusBtnLayer = this;

				options = {
					template: $this.data('template') || ''
					, callback: $this.data('callback') || function(){}
				};
				loadPopup(options.template, options.callback);
			});
		}

		function loadPopup(template){
			$.get('/html/carhartt/inc/layout/layer_common.html').done(function(data){
				var content = $(data).find('.' + template).html();

				var htmlEl = '';
				htmlEl += '<div class="layer_popup_wrap" style="display:none;">';
				htmlEl += content;
				htmlEl += '<div class="dimm" style="z-index:29"></div>';
				htmlEl += '</div>';

				$('#container').append(htmlEl);

				$('.layer_popup_wrap').css({opacity: 0}).show();
				var layerPopup = $('.layer_popup_wrap .layer_popup');
				layerPopup.css({top: '50%', marginTop: -Math.ceil(layerPopup.outerHeight()/2)});
				$('.layer_popup_wrap').css({opacity: 1});
				$('.layer_popup_wrap .dimm').css({opacity: 0}).show();

				$('body').css({overflow: 'hidden'});
				$('.layer_popup_wrap').attr({tabindex: 0}).focus();

				if($.isFunction(window[options.callback])){
					window[options.callback]();
				}

				$('.layer_popup_wrap .layer_btn_close').on('click', function(e){
					e.preventDefault();

					$('.layer_popup_wrap').remove();
					$('body').css({overflow: 'inherit'});
					window.focusBtnLayer.focus();
					$('.layer_popup_wrap .layer_btn_close').off('click');
				});

				$('.layer_popup_wrap .btn02').off('click').on('click', function(e){
					e.preventDefault();

					$('.layer_popup_wrap .layer_btn_close').trigger('click');
					$('.layer_popup_wrap .btn02').off('click');
				});

				$(document).on('keyup', function(e) {
					if(e.keyCode == 27){
						$('.layer_popup_wrap .layer_btn_close').trigger('click');
						$(document).off('keyup');
					}
				});
			});
		}

		return {init: init};
	})();

	var personalQNAUI = (function(){
		var el;

		function init(){
			el = $('.ui_personal_qna');

			if(el.length <= 0){
				return;
			}

			bindEvents();
		}

		function bindEvents(){
			el.on('click', '.ui_title', function(e){
				e.preventDefault();

				var nextTr = $(this).closest('tr').next('.reply_section');

				if(nextTr.length > 0){
					if(nextTr.is(':visible')){
						nextTr.hide();
					}else{
						nextTr.show();
					}
				}
			});

			el.on('click', '.ui_add_reply_btn', function(e){
				e.preventDefault();

				var replyArea = $(this).closest('td').find('.ui_add_reply_area');

				if(!replyArea.is(':visible')){
					replyArea.show();

					$(this).hide();
				}
			});

			el.on('click', '.ui_add_reply_return', function(e){
				e.preventDefault();

				var replyArea = $(this).closest('td').find('.ui_add_reply_area');

				if(replyArea.is(':visible')){
					replyArea.hide();

					$(this).closest('td').find('.ui_add_reply_btn').show();
				}
			});
		}

		return {init: init};
	})();

	var orderOverviewUI = (function(){
		var el;

		function init(){
			el = $('.btn_order_overview');

			if(el.length <= 0){
				return;
			}

			bindEvents();
		}

		function bindEvents(){
			el.on('click', function(e){
				e.preventDefault();

				$('.b2b_order_overview').show();
			});
		}

		return {init: init};
	})();


	var btnFilterCtr = (function(){
		var el;

		function init(){
			el = $('.btn_select');

			bindEvents();
		}

		function bindEvents(){
			el.on('click', function(e){
				e.preventDefault();

				$(this).parent().toggleClass('on');
			});
		}

		return {init: init};
	})();


	$(function(){
		textPlaceHolderInit(); // ie7,8 가능한 placeholder

		header.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
		footer.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
		snbMain.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
		snbShop.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
		snbNews.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
		snbStoreInfo.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
		snbLookBook.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
		snbJoin.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
		snbMypage.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
		snbCart.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
		snbOrder.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
		snbContactUs.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
		snbWorkWithUs.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
		snbSearch.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
		snbAboutUs.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)


		agreement01.init(); // 약관 로드
		agreement02.init(); // 약관 로드
		agreement03.init(); // 약관 로드
		agreement04.init(); // 약관 로드

		overImg.init();
		fullScroll.init();

		snbShopFolding.init();

		// /lookbook/lookbook_detail.html
		lookBook.init();

		// /mypage/mypage.html
		mypageBtnGrade.init();
		responsibleTableType01.init();

		productDetailTab.init();

		expandMypageBtn.init();

		layerPopupUI.init();

		// 1:1 문의 내역
		personalQNAUI.init();

		contactUsExpand.init();

		orderOverviewUI.init();

		btnFilterCtr.init();
	});



})(jQuery);

// test popup callback
function callback_test01(){
	console.log(1);
}