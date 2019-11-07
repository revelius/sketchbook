if(location.search.indexOf('livereload=true') != -1){
    document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] + ':35729/livereload.js"></' + 'script>');
    // HTML 구축시만 필요 개발 진행시 이 부분은 삭제
}

// transit.min.js
(function(t,e){if(typeof define==="function"&&define.amd){define(["jquery"],e)}else if(typeof exports==="object"){module.exports=e(require("jquery"))}else{e(t.jQuery)}})(this,function(t){t.transit={version:"0.9.12",propertyMap:{marginLeft:"margin",marginRight:"margin",marginBottom:"margin",marginTop:"margin",paddingLeft:"padding",paddingRight:"padding",paddingBottom:"padding",paddingTop:"padding"},enabled:true,useTransitionEnd:false};var e=document.createElement("div");var n={};function i(t){if(t in e.style)return t;var n=["Moz","Webkit","O","ms"];var i=t.charAt(0).toUpperCase()+t.substr(1);for(var r=0;r<n.length;++r){var s=n[r]+i;if(s in e.style){return s}}}function r(){e.style[n.transform]="";e.style[n.transform]="rotateY(90deg)";return e.style[n.transform]!==""}var s=navigator.userAgent.toLowerCase().indexOf("chrome")>-1;n.transition=i("transition");n.transitionDelay=i("transitionDelay");n.transform=i("transform");n.transformOrigin=i("transformOrigin");n.filter=i("Filter");n.transform3d=r();var a={transition:"transitionend",MozTransition:"transitionend",OTransition:"oTransitionEnd",WebkitTransition:"webkitTransitionEnd",msTransition:"MSTransitionEnd"};var o=n.transitionEnd=a[n.transition]||null;for(var u in n){if(n.hasOwnProperty(u)&&typeof t.support[u]==="undefined"){t.support[u]=n[u]}}e=null;t.cssEase={_default:"ease","in":"ease-in",out:"ease-out","in-out":"ease-in-out",snap:"cubic-bezier(0,1,.5,1)",easeInCubic:"cubic-bezier(.550,.055,.675,.190)",easeOutCubic:"cubic-bezier(.215,.61,.355,1)",easeInOutCubic:"cubic-bezier(.645,.045,.355,1)",easeInCirc:"cubic-bezier(.6,.04,.98,.335)",easeOutCirc:"cubic-bezier(.075,.82,.165,1)",easeInOutCirc:"cubic-bezier(.785,.135,.15,.86)",easeInExpo:"cubic-bezier(.95,.05,.795,.035)",easeOutExpo:"cubic-bezier(.19,1,.22,1)",easeInOutExpo:"cubic-bezier(1,0,0,1)",easeInQuad:"cubic-bezier(.55,.085,.68,.53)",easeOutQuad:"cubic-bezier(.25,.46,.45,.94)",easeInOutQuad:"cubic-bezier(.455,.03,.515,.955)",easeInQuart:"cubic-bezier(.895,.03,.685,.22)",easeOutQuart:"cubic-bezier(.165,.84,.44,1)",easeInOutQuart:"cubic-bezier(.77,0,.175,1)",easeInQuint:"cubic-bezier(.755,.05,.855,.06)",easeOutQuint:"cubic-bezier(.23,1,.32,1)",easeInOutQuint:"cubic-bezier(.86,0,.07,1)",easeInSine:"cubic-bezier(.47,0,.745,.715)",easeOutSine:"cubic-bezier(.39,.575,.565,1)",easeInOutSine:"cubic-bezier(.445,.05,.55,.95)",easeInBack:"cubic-bezier(.6,-.28,.735,.045)",easeOutBack:"cubic-bezier(.175, .885,.32,1.275)",easeInOutBack:"cubic-bezier(.68,-.55,.265,1.55)"};t.cssHooks["transit:transform"]={get:function(e){return t(e).data("transform")||new f},set:function(e,i){var r=i;if(!(r instanceof f)){r=new f(r)}if(n.transform==="WebkitTransform"&&!s){e.style[n.transform]=r.toString(true)}else{e.style[n.transform]=r.toString()}t(e).data("transform",r)}};t.cssHooks.transform={set:t.cssHooks["transit:transform"].set};t.cssHooks.filter={get:function(t){return t.style[n.filter]},set:function(t,e){t.style[n.filter]=e}};if(t.fn.jquery<"1.8"){t.cssHooks.transformOrigin={get:function(t){return t.style[n.transformOrigin]},set:function(t,e){t.style[n.transformOrigin]=e}};t.cssHooks.transition={get:function(t){return t.style[n.transition]},set:function(t,e){t.style[n.transition]=e}}}p("scale");p("scaleX");p("scaleY");p("translate");p("rotate");p("rotateX");p("rotateY");p("rotate3d");p("perspective");p("skewX");p("skewY");p("x",true);p("y",true);function f(t){if(typeof t==="string"){this.parse(t)}return this}f.prototype={setFromString:function(t,e){var n=typeof e==="string"?e.split(","):e.constructor===Array?e:[e];n.unshift(t);f.prototype.set.apply(this,n)},set:function(t){var e=Array.prototype.slice.apply(arguments,[1]);if(this.setter[t]){this.setter[t].apply(this,e)}else{this[t]=e.join(",")}},get:function(t){if(this.getter[t]){return this.getter[t].apply(this)}else{return this[t]||0}},setter:{rotate:function(t){this.rotate=b(t,"deg")},rotateX:function(t){this.rotateX=b(t,"deg")},rotateY:function(t){this.rotateY=b(t,"deg")},scale:function(t,e){if(e===undefined){e=t}this.scale=t+","+e},skewX:function(t){this.skewX=b(t,"deg")},skewY:function(t){this.skewY=b(t,"deg")},perspective:function(t){this.perspective=b(t,"px")},x:function(t){this.set("translate",t,null)},y:function(t){this.set("translate",null,t)},translate:function(t,e){if(this._translateX===undefined){this._translateX=0}if(this._translateY===undefined){this._translateY=0}if(t!==null&&t!==undefined){this._translateX=b(t,"px")}if(e!==null&&e!==undefined){this._translateY=b(e,"px")}this.translate=this._translateX+","+this._translateY}},getter:{x:function(){return this._translateX||0},y:function(){return this._translateY||0},scale:function(){var t=(this.scale||"1,1").split(",");if(t[0]){t[0]=parseFloat(t[0])}if(t[1]){t[1]=parseFloat(t[1])}return t[0]===t[1]?t[0]:t},rotate3d:function(){var t=(this.rotate3d||"0,0,0,0deg").split(",");for(var e=0;e<=3;++e){if(t[e]){t[e]=parseFloat(t[e])}}if(t[3]){t[3]=b(t[3],"deg")}return t}},parse:function(t){var e=this;t.replace(/([a-zA-Z0-9]+)\((.*?)\)/g,function(t,n,i){e.setFromString(n,i)})},toString:function(t){var e=[];for(var i in this){if(this.hasOwnProperty(i)){if(!n.transform3d&&(i==="rotateX"||i==="rotateY"||i==="perspective"||i==="transformOrigin")){continue}if(i[0]!=="_"){if(t&&i==="scale"){e.push(i+"3d("+this[i]+",1)")}else if(t&&i==="translate"){e.push(i+"3d("+this[i]+",0)")}else{e.push(i+"("+this[i]+")")}}}}return e.join(" ")}};function c(t,e,n){if(e===true){t.queue(n)}else if(e){t.queue(e,n)}else{t.each(function(){n.call(this)})}}function l(e){var i=[];t.each(e,function(e){e=t.camelCase(e);e=t.transit.propertyMap[e]||t.cssProps[e]||e;e=h(e);if(n[e])e=h(n[e]);if(t.inArray(e,i)===-1){i.push(e)}});return i}function d(e,n,i,r){var s=l(e);if(t.cssEase[i]){i=t.cssEase[i]}var a=""+y(n)+" "+i;if(parseInt(r,10)>0){a+=" "+y(r)}var o=[];t.each(s,function(t,e){o.push(e+" "+a)});return o.join(", ")}t.fn.transition=t.fn.transit=function(e,i,r,s){var a=this;var u=0;var f=true;var l=t.extend(true,{},e);if(typeof i==="function"){s=i;i=undefined}if(typeof i==="object"){r=i.easing;u=i.delay||0;f=typeof i.queue==="undefined"?true:i.queue;s=i.complete;i=i.duration}if(typeof r==="function"){s=r;r=undefined}if(typeof l.easing!=="undefined"){r=l.easing;delete l.easing}if(typeof l.duration!=="undefined"){i=l.duration;delete l.duration}if(typeof l.complete!=="undefined"){s=l.complete;delete l.complete}if(typeof l.queue!=="undefined"){f=l.queue;delete l.queue}if(typeof l.delay!=="undefined"){u=l.delay;delete l.delay}if(typeof i==="undefined"){i=t.fx.speeds._default}if(typeof r==="undefined"){r=t.cssEase._default}i=y(i);var p=d(l,i,r,u);var h=t.transit.enabled&&n.transition;var b=h?parseInt(i,10)+parseInt(u,10):0;if(b===0){var g=function(t){a.css(l);if(s){s.apply(a)}if(t){t()}};c(a,f,g);return a}var m={};var v=function(e){var i=false;var r=function(){if(i){a.unbind(o,r)}if(b>0){a.each(function(){this.style[n.transition]=m[this]||null})}if(typeof s==="function"){s.apply(a)}if(typeof e==="function"){e()}};if(b>0&&o&&t.transit.useTransitionEnd){i=true;a.bind(o,r)}else{window.setTimeout(r,b)}a.each(function(){if(b>0){this.style[n.transition]=p}t(this).css(l)})};var z=function(t){this.offsetWidth;v(t)};c(a,f,z);return this};function p(e,i){if(!i){t.cssNumber[e]=true}t.transit.propertyMap[e]=n.transform;t.cssHooks[e]={get:function(n){var i=t(n).css("transit:transform");return i.get(e)},set:function(n,i){var r=t(n).css("transit:transform");r.setFromString(e,i);t(n).css({"transit:transform":r})}}}function h(t){return t.replace(/([A-Z])/g,function(t){return"-"+t.toLowerCase()})}function b(t,e){if(typeof t==="string"&&!t.match(/^[\-0-9\.]+$/)){return t}else{return""+t+e}}function y(e){var n=e;if(typeof n==="string"&&!n.match(/^[\-0-9\.]+/)){n=t.fx.speeds[n]||t.fx.speeds._default}return b(n,"ms")}t.transit.getTransitionValue=d;return t});

/*! iScroll v5.1.3 ~ (c) 2008-2015 Matteo Spinelli ~ http://cubiq.org/license */
!function(t,i,s){function e(t,s){this.wrapper="string"==typeof t?i.querySelector(t):t,this.scroller=this.wrapper.children[0],this.scrollerStyle=this.scroller.style,this.options={startX:0,startY:0,scrollY:!0,directionLockThreshold:5,momentum:!0,bounce:!0,bounceTime:600,bounceEasing:"",preventDefault:!0,preventDefaultException:{tagName:/^(INPUT|TEXTAREA|BUTTON|SELECT)$/},HWCompositing:!0,useTransition:!0,useTransform:!0};for(var e in s)this.options[e]=s[e];this.translateZ=this.options.HWCompositing&&o.hasPerspective?" translateZ(0)":"",this.options.useTransition=o.hasTransition&&this.options.useTransition,this.options.useTransform=o.hasTransform&&this.options.useTransform,this.options.eventPassthrough=this.options.eventPassthrough===!0?"vertical":this.options.eventPassthrough,this.options.preventDefault=!this.options.eventPassthrough&&this.options.preventDefault,this.options.scrollY="vertical"==this.options.eventPassthrough?!1:this.options.scrollY,this.options.scrollX="horizontal"==this.options.eventPassthrough?!1:this.options.scrollX,this.options.freeScroll=this.options.freeScroll&&!this.options.eventPassthrough,this.options.directionLockThreshold=this.options.eventPassthrough?0:this.options.directionLockThreshold,this.options.bounceEasing="string"==typeof this.options.bounceEasing?o.ease[this.options.bounceEasing]||o.ease.circular:this.options.bounceEasing,this.options.resizePolling=void 0===this.options.resizePolling?60:this.options.resizePolling,this.options.tap===!0&&(this.options.tap="tap"),this.x=0,this.y=0,this.directionX=0,this.directionY=0,this._events={},this._init(),this.refresh(),this.scrollTo(this.options.startX,this.options.startY),this.enable()}var n=t.requestAnimationFrame||t.webkitRequestAnimationFrame||t.mozRequestAnimationFrame||t.oRequestAnimationFrame||t.msRequestAnimationFrame||function(i){t.setTimeout(i,1e3/60)},o=function(){function e(t){return r===!1?!1:""===r?t:r+t.charAt(0).toUpperCase()+t.substr(1)}var n={},o=i.createElement("div").style,r=function(){for(var t,i=["t","webkitT","MozT","msT","OT"],s=0,e=i.length;e>s;s++)if(t=i[s]+"ransform",t in o)return i[s].substr(0,i[s].length-1);return!1}();n.getTime=Date.now||function(){return(new Date).getTime()},n.extend=function(t,i){for(var s in i)t[s]=i[s]},n.addEvent=function(t,i,s,e){t.addEventListener(i,s,!!e)},n.removeEvent=function(t,i,s,e){t.removeEventListener(i,s,!!e)},n.prefixPointerEvent=function(i){return t.MSPointerEvent?"MSPointer"+i.charAt(9).toUpperCase()+i.substr(10):i},n.momentum=function(t,i,e,n,o,r){var h,a,c=t-i,l=s.abs(c)/e;return r=void 0===r?6e-4:r,h=t+l*l/(2*r)*(0>c?-1:1),a=l/r,n>h?(h=o?n-o/2.5*(l/8):n,c=s.abs(h-t),a=c/l):h>0&&(h=o?o/2.5*(l/8):0,c=s.abs(t)+h,a=c/l),{destination:s.round(h),duration:a}};var h=e("transform");return n.extend(n,{hasTransform:h!==!1,hasPerspective:e("perspective")in o,hasTouch:"ontouchstart"in t,hasPointer:t.PointerEvent||t.MSPointerEvent,hasTransition:e("transition")in o}),n.isBadAndroid=/Android /.test(t.navigator.appVersion)&&!/Chrome\/\d/.test(t.navigator.appVersion),n.extend(n.style={},{transform:h,transitionTimingFunction:e("transitionTimingFunction"),transitionDuration:e("transitionDuration"),transitionDelay:e("transitionDelay"),transformOrigin:e("transformOrigin")}),n.hasClass=function(t,i){var s=new RegExp("(^|\\s)"+i+"(\\s|$)");return s.test(t.className)},n.addClass=function(t,i){if(!n.hasClass(t,i)){var s=t.className.split(" ");s.push(i),t.className=s.join(" ")}},n.removeClass=function(t,i){if(n.hasClass(t,i)){var s=new RegExp("(^|\\s)"+i+"(\\s|$)","g");t.className=t.className.replace(s," ")}},n.offset=function(t){for(var i=-t.offsetLeft,s=-t.offsetTop;t=t.offsetParent;)i-=t.offsetLeft,s-=t.offsetTop;return{left:i,top:s}},n.preventDefaultException=function(t,i){for(var s in i)if(i[s].test(t[s]))return!0;return!1},n.extend(n.eventType={},{touchstart:1,touchmove:1,touchend:1,mousedown:2,mousemove:2,mouseup:2,pointerdown:3,pointermove:3,pointerup:3,MSPointerDown:3,MSPointerMove:3,MSPointerUp:3}),n.extend(n.ease={},{quadratic:{style:"cubic-bezier(0.25, 0.46, 0.45, 0.94)",fn:function(t){return t*(2-t)}},circular:{style:"cubic-bezier(0.1, 0.57, 0.1, 1)",fn:function(t){return s.sqrt(1- --t*t)}},back:{style:"cubic-bezier(0.175, 0.885, 0.32, 1.275)",fn:function(t){var i=4;return(t-=1)*t*((i+1)*t+i)+1}},bounce:{style:"",fn:function(t){return(t/=1)<1/2.75?7.5625*t*t:2/2.75>t?7.5625*(t-=1.5/2.75)*t+.75:2.5/2.75>t?7.5625*(t-=2.25/2.75)*t+.9375:7.5625*(t-=2.625/2.75)*t+.984375}},elastic:{style:"",fn:function(t){var i=.22,e=.4;return 0===t?0:1==t?1:e*s.pow(2,-10*t)*s.sin(2*(t-i/4)*s.PI/i)+1}}}),n.tap=function(t,s){var e=i.createEvent("Event");e.initEvent(s,!0,!0),e.pageX=t.pageX,e.pageY=t.pageY,t.target.dispatchEvent(e)},n.click=function(t){var s,e=t.target;/(SELECT|INPUT|TEXTAREA)/i.test(e.tagName)||(s=i.createEvent("MouseEvents"),s.initMouseEvent("click",!0,!0,t.view,1,e.screenX,e.screenY,e.clientX,e.clientY,t.ctrlKey,t.altKey,t.shiftKey,t.metaKey,0,null),s._constructed=!0,e.dispatchEvent(s))},n}();e.prototype={version:"5.1.3",_init:function(){this._initEvents()},destroy:function(){this._initEvents(!0),this._execEvent("destroy")},_transitionEnd:function(t){t.target==this.scroller&&this.isInTransition&&(this._transitionTime(),this.resetPosition(this.options.bounceTime)||(this.isInTransition=!1,this._execEvent("scrollEnd")))},_start:function(t){if(!(1!=o.eventType[t.type]&&0!==t.button||!this.enabled||this.initiated&&o.eventType[t.type]!==this.initiated)){!this.options.preventDefault||o.isBadAndroid||o.preventDefaultException(t.target,this.options.preventDefaultException)||t.preventDefault();var i,e=t.touches?t.touches[0]:t;this.initiated=o.eventType[t.type],this.moved=!1,this.distX=0,this.distY=0,this.directionX=0,this.directionY=0,this.directionLocked=0,this._transitionTime(),this.startTime=o.getTime(),this.options.useTransition&&this.isInTransition?(this.isInTransition=!1,i=this.getComputedPosition(),this._translate(s.round(i.x),s.round(i.y)),this._execEvent("scrollEnd")):!this.options.useTransition&&this.isAnimating&&(this.isAnimating=!1,this._execEvent("scrollEnd")),this.startX=this.x,this.startY=this.y,this.absStartX=this.x,this.absStartY=this.y,this.pointX=e.pageX,this.pointY=e.pageY,this._execEvent("beforeScrollStart")}},_move:function(t){if(this.enabled&&o.eventType[t.type]===this.initiated){this.options.preventDefault&&t.preventDefault();var i,e,n,r,h=t.touches?t.touches[0]:t,a=h.pageX-this.pointX,c=h.pageY-this.pointY,l=o.getTime();if(this.pointX=h.pageX,this.pointY=h.pageY,this.distX+=a,this.distY+=c,n=s.abs(this.distX),r=s.abs(this.distY),!(l-this.endTime>300&&10>n&&10>r)){if(this.directionLocked||this.options.freeScroll||(n>r+this.options.directionLockThreshold?this.directionLocked="h":r>=n+this.options.directionLockThreshold?this.directionLocked="v":this.directionLocked="n"),"h"==this.directionLocked){if("vertical"==this.options.eventPassthrough)t.preventDefault();else if("horizontal"==this.options.eventPassthrough)return void(this.initiated=!1);c=0}else if("v"==this.directionLocked){if("horizontal"==this.options.eventPassthrough)t.preventDefault();else if("vertical"==this.options.eventPassthrough)return void(this.initiated=!1);a=0}a=this.hasHorizontalScroll?a:0,c=this.hasVerticalScroll?c:0,i=this.x+a,e=this.y+c,(i>0||i<this.maxScrollX)&&(i=this.options.bounce?this.x+a/3:i>0?0:this.maxScrollX),(e>0||e<this.maxScrollY)&&(e=this.options.bounce?this.y+c/3:e>0?0:this.maxScrollY),this.directionX=a>0?-1:0>a?1:0,this.directionY=c>0?-1:0>c?1:0,this.moved||this._execEvent("scrollStart"),this.moved=!0,this._translate(i,e),l-this.startTime>300&&(this.startTime=l,this.startX=this.x,this.startY=this.y)}}},_end:function(t){if(this.enabled&&o.eventType[t.type]===this.initiated){this.options.preventDefault&&!o.preventDefaultException(t.target,this.options.preventDefaultException)&&t.preventDefault();var i,e,n=(t.changedTouches?t.changedTouches[0]:t,o.getTime()-this.startTime),r=s.round(this.x),h=s.round(this.y),a=s.abs(r-this.startX),c=s.abs(h-this.startY),l=0,p="";if(this.isInTransition=0,this.initiated=0,this.endTime=o.getTime(),!this.resetPosition(this.options.bounceTime))return this.scrollTo(r,h),this.moved?this._events.flick&&200>n&&100>a&&100>c?void this._execEvent("flick"):(this.options.momentum&&300>n&&(i=this.hasHorizontalScroll?o.momentum(this.x,this.startX,n,this.maxScrollX,this.options.bounce?this.wrapperWidth:0,this.options.deceleration):{destination:r,duration:0},e=this.hasVerticalScroll?o.momentum(this.y,this.startY,n,this.maxScrollY,this.options.bounce?this.wrapperHeight:0,this.options.deceleration):{destination:h,duration:0},r=i.destination,h=e.destination,l=s.max(i.duration,e.duration),this.isInTransition=1),r!=this.x||h!=this.y?((r>0||r<this.maxScrollX||h>0||h<this.maxScrollY)&&(p=o.ease.quadratic),void this.scrollTo(r,h,l,p)):void this._execEvent("scrollEnd")):(this.options.tap&&o.tap(t,this.options.tap),this.options.click&&o.click(t),void this._execEvent("scrollCancel"))}},_resize:function(){var t=this;clearTimeout(this.resizeTimeout),this.resizeTimeout=setTimeout(function(){t.refresh()},this.options.resizePolling)},resetPosition:function(t){var i=this.x,s=this.y;return t=t||0,!this.hasHorizontalScroll||this.x>0?i=0:this.x<this.maxScrollX&&(i=this.maxScrollX),!this.hasVerticalScroll||this.y>0?s=0:this.y<this.maxScrollY&&(s=this.maxScrollY),i==this.x&&s==this.y?!1:(this.scrollTo(i,s,t,this.options.bounceEasing),!0)},disable:function(){this.enabled=!1},enable:function(){this.enabled=!0},refresh:function(){this.wrapper.offsetHeight;this.wrapperWidth=this.wrapper.clientWidth,this.wrapperHeight=this.wrapper.clientHeight,this.scrollerWidth=this.scroller.offsetWidth,this.scrollerHeight=this.scroller.offsetHeight,this.maxScrollX=this.wrapperWidth-this.scrollerWidth,this.maxScrollY=this.wrapperHeight-this.scrollerHeight,this.hasHorizontalScroll=this.options.scrollX&&this.maxScrollX<0,this.hasVerticalScroll=this.options.scrollY&&this.maxScrollY<0,this.hasHorizontalScroll||(this.maxScrollX=0,this.scrollerWidth=this.wrapperWidth),this.hasVerticalScroll||(this.maxScrollY=0,this.scrollerHeight=this.wrapperHeight),this.endTime=0,this.directionX=0,this.directionY=0,this.wrapperOffset=o.offset(this.wrapper),this._execEvent("refresh"),this.resetPosition()},on:function(t,i){this._events[t]||(this._events[t]=[]),this._events[t].push(i)},off:function(t,i){if(this._events[t]){var s=this._events[t].indexOf(i);s>-1&&this._events[t].splice(s,1)}},_execEvent:function(t){if(this._events[t]){var i=0,s=this._events[t].length;if(s)for(;s>i;i++)this._events[t][i].apply(this,[].slice.call(arguments,1))}},scrollBy:function(t,i,s,e){t=this.x+t,i=this.y+i,s=s||0,this.scrollTo(t,i,s,e)},scrollTo:function(t,i,s,e){e=e||o.ease.circular,this.isInTransition=this.options.useTransition&&s>0,!s||this.options.useTransition&&e.style?(this._transitionTimingFunction(e.style),this._transitionTime(s),this._translate(t,i)):this._animate(t,i,s,e.fn)},scrollToElement:function(t,i,e,n,r){if(t=t.nodeType?t:this.scroller.querySelector(t)){var h=o.offset(t);h.left-=this.wrapperOffset.left,h.top-=this.wrapperOffset.top,e===!0&&(e=s.round(t.offsetWidth/2-this.wrapper.offsetWidth/2)),n===!0&&(n=s.round(t.offsetHeight/2-this.wrapper.offsetHeight/2)),h.left-=e||0,h.top-=n||0,h.left=h.left>0?0:h.left<this.maxScrollX?this.maxScrollX:h.left,h.top=h.top>0?0:h.top<this.maxScrollY?this.maxScrollY:h.top,i=void 0===i||null===i||"auto"===i?s.max(s.abs(this.x-h.left),s.abs(this.y-h.top)):i,this.scrollTo(h.left,h.top,i,r)}},_transitionTime:function(t){t=t||0,this.scrollerStyle[o.style.transitionDuration]=t+"ms",!t&&o.isBadAndroid&&(this.scrollerStyle[o.style.transitionDuration]="0.001s")},_transitionTimingFunction:function(t){this.scrollerStyle[o.style.transitionTimingFunction]=t},_translate:function(t,i){this.options.useTransform?this.scrollerStyle[o.style.transform]="translate("+t+"px,"+i+"px)"+this.translateZ:(t=s.round(t),i=s.round(i),this.scrollerStyle.left=t+"px",this.scrollerStyle.top=i+"px"),this.x=t,this.y=i},_initEvents:function(i){var s=i?o.removeEvent:o.addEvent,e=this.options.bindToWrapper?this.wrapper:t;s(t,"orientationchange",this),s(t,"resize",this),this.options.click&&s(this.wrapper,"click",this,!0),this.options.disableMouse||(s(this.wrapper,"mousedown",this),s(e,"mousemove",this),s(e,"mousecancel",this),s(e,"mouseup",this)),o.hasPointer&&!this.options.disablePointer&&(s(this.wrapper,o.prefixPointerEvent("pointerdown"),this),s(e,o.prefixPointerEvent("pointermove"),this),s(e,o.prefixPointerEvent("pointercancel"),this),s(e,o.prefixPointerEvent("pointerup"),this)),o.hasTouch&&!this.options.disableTouch&&(s(this.wrapper,"touchstart",this),s(e,"touchmove",this),s(e,"touchcancel",this),s(e,"touchend",this)),s(this.scroller,"transitionend",this),s(this.scroller,"webkitTransitionEnd",this),s(this.scroller,"oTransitionEnd",this),s(this.scroller,"MSTransitionEnd",this)},getComputedPosition:function(){var i,s,e=t.getComputedStyle(this.scroller,null);return this.options.useTransform?(e=e[o.style.transform].split(")")[0].split(", "),i=+(e[12]||e[4]),s=+(e[13]||e[5])):(i=+e.left.replace(/[^-\d.]/g,""),s=+e.top.replace(/[^-\d.]/g,"")),{x:i,y:s}},_animate:function(t,i,s,e){function r(){var u,f,d,m=o.getTime();return m>=p?(h.isAnimating=!1,h._translate(t,i),void(h.resetPosition(h.options.bounceTime)||h._execEvent("scrollEnd"))):(m=(m-l)/s,d=e(m),u=(t-a)*d+a,f=(i-c)*d+c,h._translate(u,f),void(h.isAnimating&&n(r)))}var h=this,a=this.x,c=this.y,l=o.getTime(),p=l+s;this.isAnimating=!0,r()},handleEvent:function(t){switch(t.type){case"touchstart":case"pointerdown":case"MSPointerDown":case"mousedown":this._start(t);break;case"touchmove":case"pointermove":case"MSPointerMove":case"mousemove":this._move(t);break;case"touchend":case"pointerup":case"MSPointerUp":case"mouseup":case"touchcancel":case"pointercancel":case"MSPointerCancel":case"mousecancel":this._end(t);break;case"orientationchange":case"resize":this._resize();break;case"transitionend":case"webkitTransitionEnd":case"oTransitionEnd":case"MSTransitionEnd":this._transitionEnd(t);break;case"wheel":case"DOMMouseScroll":case"mousewheel":this._wheel(t);break;case"keydown":this._key(t);break;case"click":t._constructed||(t.preventDefault(),t.stopPropagation())}}},e.utils=o,"undefined"!=typeof module&&module.exports?module.exports=e:t.IScroll=e}(window,document,Math);

/*! nanoScrollerJS - v0.8.7 - (c) 2015 James Florentino; Licensed MIT */
!function(a){return"function"==typeof define&&define.amd?define(["jquery"],function(b){return a(b,window,document)}):"object"==typeof exports?module.exports=a(require("jquery"),window,document):a(jQuery,window,document)}(function(a,b,c){"use strict";var d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H;z={paneClass:"nano-pane",sliderClass:"nano-slider",contentClass:"nano-content",enabledClass:"has-scrollbar",flashedClass:"flashed",activeClass:"active",iOSNativeScrolling:!1,preventPageScrolling:!1,disableResize:!1,alwaysVisible:!1,flashDelay:1500,sliderMinHeight:20,sliderMaxHeight:null,documentContext:null,windowContext:null},u="scrollbar",t="scroll",l="mousedown",m="mouseenter",n="mousemove",p="mousewheel",o="mouseup",s="resize",h="drag",i="enter",w="up",r="panedown",f="DOMMouseScroll",g="down",x="wheel",j="keydown",k="keyup",v="touchmove",d="Microsoft Internet Explorer"===b.navigator.appName&&/msie 7./i.test(b.navigator.appVersion)&&b.ActiveXObject,e=null,D=b.requestAnimationFrame,y=b.cancelAnimationFrame,F=c.createElement("div").style,H=function(){var a,b,c,d,e,f;for(d=["t","webkitT","MozT","msT","OT"],a=e=0,f=d.length;f>e;a=++e)if(c=d[a],b=d[a]+"ransform",b in F)return d[a].substr(0,d[a].length-1);return!1}(),G=function(a){return H===!1?!1:""===H?a:H+a.charAt(0).toUpperCase()+a.substr(1)},E=G("transform"),B=E!==!1,A=function(){var a,b,d;return a=c.createElement("div"),b=a.style,b.position="absolute",b.width="100px",b.height="100px",b.overflow=t,b.top="-9999px",c.body.appendChild(a),d=a.offsetWidth-a.clientWidth,c.body.removeChild(a),d},C=function(){var a,c,d;return c=b.navigator.userAgent,(a=/(?=.+Mac OS X)(?=.+Firefox)/.test(c))?(d=/Firefox\/\d{2}\./.exec(c),d&&(d=d[0].replace(/\D+/g,"")),a&&+d>23):!1},q=function(){function j(d,f){this.el=d,this.options=f,e||(e=A()),this.$el=a(this.el),this.doc=a(this.options.documentContext||c),this.win=a(this.options.windowContext||b),this.body=this.doc.find("body"),this.$content=this.$el.children("."+this.options.contentClass),this.$content.attr("tabindex",this.options.tabIndex||0),this.content=this.$content[0],this.previousPosition=0,this.options.iOSNativeScrolling&&null!=this.el.style.WebkitOverflowScrolling?this.nativeScrolling():this.generate(),this.createEvents(),this.addEvents(),this.reset()}return j.prototype.preventScrolling=function(a,b){if(this.isActive)if(a.type===f)(b===g&&a.originalEvent.detail>0||b===w&&a.originalEvent.detail<0)&&a.preventDefault();else if(a.type===p){if(!a.originalEvent||!a.originalEvent.wheelDelta)return;(b===g&&a.originalEvent.wheelDelta<0||b===w&&a.originalEvent.wheelDelta>0)&&a.preventDefault()}},j.prototype.nativeScrolling=function(){this.$content.css({WebkitOverflowScrolling:"touch"}),this.iOSNativeScrolling=!0,this.isActive=!0},j.prototype.updateScrollValues=function(){var a,b;a=this.content,this.maxScrollTop=a.scrollHeight-a.clientHeight,this.prevScrollTop=this.contentScrollTop||0,this.contentScrollTop=a.scrollTop,b=this.contentScrollTop>this.previousPosition?"down":this.contentScrollTop<this.previousPosition?"up":"same",this.previousPosition=this.contentScrollTop,"same"!==b&&this.$el.trigger("update",{position:this.contentScrollTop,maximum:this.maxScrollTop,direction:b}),this.iOSNativeScrolling||(this.maxSliderTop=this.paneHeight-this.sliderHeight,this.sliderTop=0===this.maxScrollTop?0:this.contentScrollTop*this.maxSliderTop/this.maxScrollTop)},j.prototype.setOnScrollStyles=function(){var a;B?(a={},a[E]="translate(0, "+this.sliderTop+"px)"):a={top:this.sliderTop},D?(y&&this.scrollRAF&&y(this.scrollRAF),this.scrollRAF=D(function(b){return function(){return b.scrollRAF=null,b.slider.css(a)}}(this))):this.slider.css(a)},j.prototype.createEvents=function(){this.events={down:function(a){return function(b){return a.isBeingDragged=!0,a.offsetY=b.pageY-a.slider.offset().top,a.slider.is(b.target)||(a.offsetY=0),a.pane.addClass(a.options.activeClass),a.doc.bind(n,a.events[h]).bind(o,a.events[w]),a.body.bind(m,a.events[i]),!1}}(this),drag:function(a){return function(b){return a.sliderY=b.pageY-a.$el.offset().top-a.paneTop-(a.offsetY||.5*a.sliderHeight),a.scroll(),a.contentScrollTop>=a.maxScrollTop&&a.prevScrollTop!==a.maxScrollTop?a.$el.trigger("scrollend"):0===a.contentScrollTop&&0!==a.prevScrollTop&&a.$el.trigger("scrolltop"),!1}}(this),up:function(a){return function(b){return a.isBeingDragged=!1,a.pane.removeClass(a.options.activeClass),a.doc.unbind(n,a.events[h]).unbind(o,a.events[w]),a.body.unbind(m,a.events[i]),!1}}(this),resize:function(a){return function(b){a.reset()}}(this),panedown:function(a){return function(b){return a.sliderY=(b.offsetY||b.originalEvent.layerY)-.5*a.sliderHeight,a.scroll(),a.events.down(b),!1}}(this),scroll:function(a){return function(b){a.updateScrollValues(),a.isBeingDragged||(a.iOSNativeScrolling||(a.sliderY=a.sliderTop,a.setOnScrollStyles()),null!=b&&(a.contentScrollTop>=a.maxScrollTop?(a.options.preventPageScrolling&&a.preventScrolling(b,g),a.prevScrollTop!==a.maxScrollTop&&a.$el.trigger("scrollend")):0===a.contentScrollTop&&(a.options.preventPageScrolling&&a.preventScrolling(b,w),0!==a.prevScrollTop&&a.$el.trigger("scrolltop"))))}}(this),wheel:function(a){return function(b){var c;if(null!=b)return c=b.delta||b.wheelDelta||b.originalEvent&&b.originalEvent.wheelDelta||-b.detail||b.originalEvent&&-b.originalEvent.detail,c&&(a.sliderY+=-c/3),a.scroll(),!1}}(this),enter:function(a){return function(b){var c;if(a.isBeingDragged)return 1!==(b.buttons||b.which)?(c=a.events)[w].apply(c,arguments):void 0}}(this)}},j.prototype.addEvents=function(){var a;this.removeEvents(),a=this.events,this.options.disableResize||this.win.bind(s,a[s]),this.iOSNativeScrolling||(this.slider.bind(l,a[g]),this.pane.bind(l,a[r]).bind(""+p+" "+f,a[x])),this.$content.bind(""+t+" "+p+" "+f+" "+v,a[t])},j.prototype.removeEvents=function(){var a;a=this.events,this.win.unbind(s,a[s]),this.iOSNativeScrolling||(this.slider.unbind(),this.pane.unbind()),this.$content.unbind(""+t+" "+p+" "+f+" "+v,a[t])},j.prototype.generate=function(){var a,c,d,f,g,h,i;return f=this.options,h=f.paneClass,i=f.sliderClass,a=f.contentClass,(g=this.$el.children("."+h)).length||g.children("."+i).length||this.$el.append('<div class="'+h+'"><div class="'+i+'" /></div>'),this.pane=this.$el.children("."+h),this.slider=this.pane.find("."+i),0===e&&C()?(d=b.getComputedStyle(this.content,null).getPropertyValue("padding-right").replace(/[^0-9.]+/g,""),c={right:-14,paddingRight:+d+14}):e&&(c={right:-e},this.$el.addClass(f.enabledClass)),null!=c&&this.$content.css(c),this},j.prototype.restore=function(){this.stopped=!1,this.iOSNativeScrolling||this.pane.show(),this.addEvents()},j.prototype.reset=function(){var a,b,c,f,g,h,i,j,k,l,m,n;return this.iOSNativeScrolling?void(this.contentHeight=this.content.scrollHeight):(this.$el.find("."+this.options.paneClass).length||this.generate().stop(),this.stopped&&this.restore(),a=this.content,f=a.style,g=f.overflowY,d&&this.$content.css({height:this.$content.height()}),b=a.scrollHeight+e,l=parseInt(this.$el.css("max-height"),10),l>0&&(this.$el.height(""),this.$el.height(a.scrollHeight>l?l:a.scrollHeight)),i=this.pane.outerHeight(!1),k=parseInt(this.pane.css("top"),10),h=parseInt(this.pane.css("bottom"),10),j=i+k+h,n=Math.round(j/b*i),n<this.options.sliderMinHeight?n=this.options.sliderMinHeight:null!=this.options.sliderMaxHeight&&n>this.options.sliderMaxHeight&&(n=this.options.sliderMaxHeight),g===t&&f.overflowX!==t&&(n+=e),this.maxSliderTop=j-n,this.contentHeight=b,this.paneHeight=i,this.paneOuterHeight=j,this.sliderHeight=n,this.paneTop=k,this.slider.height(n),this.events.scroll(),this.pane.show(),this.isActive=!0,a.scrollHeight===a.clientHeight||this.pane.outerHeight(!0)>=a.scrollHeight&&g!==t?(this.pane.hide(),this.isActive=!1):this.el.clientHeight===a.scrollHeight&&g===t?this.slider.hide():this.slider.show(),this.pane.css({opacity:this.options.alwaysVisible?1:"",visibility:this.options.alwaysVisible?"visible":""}),c=this.$content.css("position"),("static"===c||"relative"===c)&&(m=parseInt(this.$content.css("right"),10),m&&this.$content.css({right:"",marginRight:m})),this)},j.prototype.scroll=function(){return this.isActive?(this.sliderY=Math.max(0,this.sliderY),this.sliderY=Math.min(this.maxSliderTop,this.sliderY),this.$content.scrollTop(this.maxScrollTop*this.sliderY/this.maxSliderTop),this.iOSNativeScrolling||(this.updateScrollValues(),this.setOnScrollStyles()),this):void 0},j.prototype.scrollBottom=function(a){return this.isActive?(this.$content.scrollTop(this.contentHeight-this.$content.height()-a).trigger(p),this.stop().restore(),this):void 0},j.prototype.scrollTop=function(a){return this.isActive?(this.$content.scrollTop(+a).trigger(p),this.stop().restore(),this):void 0},j.prototype.scrollTo=function(a){return this.isActive?(this.scrollTop(this.$el.find(a).get(0).offsetTop),this):void 0},j.prototype.stop=function(){return y&&this.scrollRAF&&(y(this.scrollRAF),this.scrollRAF=null),this.stopped=!0,this.removeEvents(),this.iOSNativeScrolling||this.pane.hide(),this},j.prototype.destroy=function(){return this.stopped||this.stop(),!this.iOSNativeScrolling&&this.pane.length&&this.pane.remove(),d&&this.$content.height(""),this.$content.removeAttr("tabindex"),this.$el.hasClass(this.options.enabledClass)&&(this.$el.removeClass(this.options.enabledClass),this.$content.css({right:""})),this},j.prototype.flash=function(){return!this.iOSNativeScrolling&&this.isActive?(this.reset(),this.pane.addClass(this.options.flashedClass),setTimeout(function(a){return function(){a.pane.removeClass(a.options.flashedClass)}}(this),this.options.flashDelay),this):void 0},j}(),a.fn.nanoScroller=function(b){return this.each(function(){var c,d;if((d=this.nanoscroller)||(c=a.extend({},z,b),this.nanoscroller=d=new q(this,c)),b&&"object"==typeof b){if(a.extend(d.options,b),null!=b.scrollBottom)return d.scrollBottom(b.scrollBottom);if(null!=b.scrollTop)return d.scrollTop(b.scrollTop);if(b.scrollTo)return d.scrollTo(b.scrollTo);if("bottom"===b.scroll)return d.scrollBottom(0);if("top"===b.scroll)return d.scrollTop(0);if(b.scroll&&b.scroll instanceof a)return d.scrollTo(b.scroll);if(b.stop)return d.stop();if(b.destroy)return d.destroy();if(b.flash)return d.flash()}return d.reset()})},a.fn.nanoScroller.Constructor=q});

/* modify 151118 */
/* jquery easing extend Robert Penner's original easing equations modified for JQuery animate method, Jamie Lemon 2009 lemonsanver.com */
jQuery.extend({easing:{linear:function(n){return n},swing:function(n){return.5-Math.cos(n*Math.PI)/2},backEaseIn:function(n,t,r,a){var u=r+a,e=1.70158;return u*(n/=1)*n*((e+1)*n-e)+r},backEaseOut:function(n,t,r,a){var u=r+a,e=1.70158;return u*((n=n/1-1)*n*((e+1)*n+e)+1)+r},backEaseInOut:function(n,t,r,a){var u=r+a,e=1.70158;return(n/=.5)<1?u/2*(n*n*(((e*=1.525)+1)*n-e))+r:u/2*((n-=2)*n*(((e*=1.525)+1)*n+e)+2)+r},bounceEaseIn:function(n,t,r,a){var u=r+a,e=this.bounceEaseOut(1-n,1,0,a);return u-e+r},bounceEaseOut:function(n,t,r,a){var u=r+a;return 1/2.75>n?u*(7.5625*n*n)+r:2/2.75>n?u*(7.5625*(n-=1.5/2.75)*n+.75)+r:2.5/2.75>n?u*(7.5625*(n-=2.25/2.75)*n+.9375)+r:u*(7.5625*(n-=2.625/2.75)*n+.984375)+r},circEaseIn:function(n,t,r,a){var u=r+a;return-u*(Math.sqrt(1-(n/=1)*n)-1)+r},circEaseOut:function(n,t,r,a){var u=r+a;return u*Math.sqrt(1-(n=n/1-1)*n)+r},circEaseInOut:function(n,t,r,a){var u=r+a;return(n/=.5)<1?-u/2*(Math.sqrt(1-n*n)-1)+r:u/2*(Math.sqrt(1-(n-=2)*n)+1)+r},cubicEaseIn:function(n,t,r,a){var u=r+a;return u*(n/=1)*n*n+r},cubicEaseOut:function(n,t,r,a){var u=r+a;return u*((n=n/1-1)*n*n+1)+r},cubicEaseInOut:function(n,t,r,a){var u=r+a;return(n/=.5)<1?u/2*n*n*n+r:u/2*((n-=2)*n*n+2)+r},elasticEaseIn:function(n,t,r,a){var u=r+a;if(0==n)return r;if(1==n)return u;var e,i=.25,c=u;return c<Math.abs(u)?(c=u,e=i/4):e=i/(2*Math.PI)*Math.asin(u/c),-(c*Math.pow(2,10*(n-=1))*Math.sin((1*n-e)*(2*Math.PI)/i))+r},elasticEaseOut:function(n,t,r,a){var u=r+a;if(0==n)return r;if(1==n)return u;var e,i=.25,c=u;return c<Math.abs(u)?(c=u,e=i/4):e=i/(2*Math.PI)*Math.asin(u/c),-(c*Math.pow(2,-10*n)*Math.sin((1*n-e)*(2*Math.PI)/i))+u},expoEaseIn:function(n,t,r,a){var u=r+a;return 0==n?r:u*Math.pow(2,10*(n-1))+r-.001*u},expoEaseOut:function(n,t,r,a){var u=r+a;return 1==n?u:1.001*a*(-Math.pow(2,-10*n)+1)+r},expoEaseInOut:function(n,t,r,a){var u=r+a;return 0==n?r:1==n?u:(n/=.5)<1?u/2*Math.pow(2,10*(n-1))+r-5e-4*u:u/2*1.0005*(-Math.pow(2,-10*--n)+2)+r},quadEaseIn:function(n,t,r,a){var u=r+a;return u*(n/=1)*n+r},quadEaseOut:function(n,t,r,a){var u=r+a;return-u*(n/=1)*(n-2)+r},quadEaseInOut:function(n,t,r,a){var u=r+a;return(n/=.5)<1?u/2*n*n+r:-u/2*(--n*(n-2)-1)+r},quartEaseIn:function(n,t,r,a){var u=r+a;return u*(n/=1)*n*n*n+r},quartEaseOut:function(n,t,r,a){var u=r+a;return-u*((n=n/1-1)*n*n*n-1)+r},quartEaseInOut:function(n,t,r,a){var u=r+a;return(n/=.5)<1?u/2*n*n*n*n+r:-u/2*((n-=2)*n*n*n-2)+r},quintEaseIn:function(n,t,r,a){var u=r+a;return u*(n/=1)*n*n*n*n+r},quintEaseOut:function(n,t,r,a){var u=r+a;return u*((n=n/1-1)*n*n*n*n+1)+r},quintEaseInOut:function(n,t,r,a){var u=r+a;return(n/=.5)<1?u/2*n*n*n*n*n+r:u/2*((n-=2)*n*n*n*n+2)+r},sineEaseIn:function(n,t,r,a){var u=r+a;return-u*Math.cos(n*(Math.PI/2))+u+r},sineEaseOut:function(n,t,r,a){var u=r+a;return u*Math.sin(n*(Math.PI/2))+r},sineEaseInOut:function(n,t,r,a){var u=r+a;return-u/2*(Math.cos(Math.PI*n)-1)+r}}});

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
                    _this.wrap("<span class='placeholder_wrap' style='display:block;position:relative'></span>");   // 20140423 최수빈
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
                window.agreement01 = $.get('/jsp/worksout/include/layout/agreement01.jsp');
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
                window.agreement02 = $.get('/jsp/worksout/include/layout/agreement02.jsp');
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
                window.agreement03 = $.get('/jsp/worksout/include/layout/agreement03.jsp');
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
                window.agreement04 = $.get('/jsp/worksout/include/layout/agreement04.jsp');
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
                window.header = $.get('/front/header?oneDepth='+$('#oneDepth').val());
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
            if(typeof noScript != "undefined"){
                noScript();
            }
        }

        return {init: init};
    })();

    var footer = (function(){
        var el;

        function init(){
            el = $('#footer');

            if(el.children().length <= 0){
                window.footer = $.get('/front/footer');
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
                window.snbMain = $.get('/front/snbMain');
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

            /* 160328
            IOS : 간헐적으로 랜더링이 코드상 뒤의 event excute되는 시점보다 느림.
            --> 해당 렌더링의 유무를 계속 체크하여 해당 노드있을때 event 실행
            */
            var timerCheck = null;
            function timerComplete() {
            	timerCheck = setTimeout(function(){
            		if ($('.snb_mobile_container').length > 0) {
            			complete();
            			clearTimeout(timerCheck);
            			timerCheck = null;
            		} else {
            			timerComplete();
            		}
            	}, 10);
            }

            if(el.children().length <= 0){
                window.snbShop = $.get('/front/snbShop?oneDepth='+$('#oneDepth').val()+"&twoDepth="+$('#twoDepth').val()+"&threeDepth="+$('#threeDepth').val()+"&sex="+$('#sex').val()+"&ubiGdsSize="+$('#ubiGdsSize').val()+"&orderBy="+$('#orderBy').val()+"&orderFlag="+$('#orderFlag').val()+"&brand="+$('#brand').val()+"&newArvl="+$('#newArvl').val());
                window.snbShop.done(function(data){
                    el.html(data);
                    timerComplete();	// 160328 modify
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
            allMenuRadio.init();
            allMenu_aware.init();
            shopSelect.init();
        }

        return {init: init};
    })();

    var snbNews = (function(){
        var el;

        function init(){
            el = $('#snb_news_area');

            if(el.children().length <= 0){
                window.snbNews = $.get('/front/news/snbNews');
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
                window.snbStoreInfo = $.get('/front/snbStoreInfo');
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
                window.snbLookBook = $.get('/jsp/worksout/include/layout/snb_lookbook.jsp');
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
                window.snbJoin = $.get('/jsp/worksout/include/layout/snb_join.jsp');
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
            
            if(el.length <= 0){
                return;
            }
            
            if(el.children().length <= 0){
                window.snbMypage = $.get('/front/myPage/snb_mypage');
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
                window.snbCart = $.get('/jsp/worksout/include/layout/snb_cart.jsp');
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
                window.snbOrder = $.get('/jsp/worksout/include/layout/snb_order.jsp');
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
                window.snbContactUs = $.get('/jsp/worksout/include/layout/snb_contact_us.jsp');
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
                window.snbWorkWithUs = $.get('/jsp/worksout/include/layout/snb_work_with_us.jsp');
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
                window.snbSearch = $.get('/jsp/worksout/include/layout/snb_search.jsp');
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
                window.snbSearch = $.get('/html/worksout/inc/layout/snb_about_us.html');
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

    /**
     * modify 151118
     * Other Utils : 비즈니스 로직과 무관한 Utils
     */
    var otherUtils = (function(){
        return {
            /**
             * Document Total Size(outerSize)
             */
            getDocumentHeight: function() {
                 var D = document;
                 return Math.max(Math.max(D.body.scrollHeight, D.documentElement.scrollHeight), Math.max(D.body.offsetHeight, D.documentElement.offsetHeight), Math.max(D.body.clientHeight, D.documentElement.clientHeight));
            },

            /**
             * Detection function to tell what kind of browser is used
             */
            getBrowser: function(){
                var userAgent = navigator.userAgent.toLowerCase();
                var edge = /edge/.test(userAgent);
                var chrome = /chrome/.test(userAgent);
                var safari= /webkit/.test(userAgent);
                var opera=/opera/.test(userAgent);
                var msie=/msie/.test( userAgent ) && !/opera/.test( userAgent );
                var mozilla= /mozilla/.test( userAgent ) && !/(compatible|webkit)/.test( userAgent ) || /firefox/.test(userAgent);

                if(edge) return "edge";
                if(chrome) return "chrome";
                if(mozilla) return "mozilla";
                if(opera) return "opera";
                if(safari) return "safari";
                if(msie) return "ie";
            },

            /**
             * Since IE11 can not be detected like this because the new user agent on IE11 is trying to hide as Mozilla
             * we detect IE11 with this function
             */
            getInternetExplorerVersion: function(){
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
            }
        }
    })();


    /**
     * modify 151118
     * Image Controll
     */
    var overImg = (function(){
        var el;

        // modify 151118
        /**
         * 현재 스크롤의 위치상 몇번째 이미지인지 체크
         */
        var positionObj = {
            targetID: null, // 다음에 넘어갈 이미지 ID
            currentID:null  // 현재 보여질 이미지 ID
        }

        /**
         * image active Time ( imageActive 함수에서 사용 )
         */
        var IMG_ACTIVE_TIME = 2000, // 이미지 active time
            IMG_DISABLE_TIME = 500; // 이미지 disable time

        var ieVer,      // IE 브라우저라면 몇 버전인지 확인(IE가 아니면 -1)
                        // EDGE : ieVer == -1, browser == 'edge' 일때, EDGE
            browser;    // 브라우저 type


        /**
         * graySvgUtils
         *  - ie10, ie11, ie11 edge 에서 만들어 질 grayscale(svg) 
         */
        var graySvgUtils = {
            getComputedStyle: function(element) {
              var computedStyle = {},
                  styles        = {};

              computedStyle = window.getComputedStyle(element, null);

              for(var i = 0, length = computedStyle.length; i < length; i++) {
                var prop = computedStyle[i];
                var val = computedStyle.getPropertyValue(prop);
                styles[prop] = val;
              }

              return styles;
            },
            getImgParams: function(element) {
              var params = {};

              params.styles = this.getComputedStyle(element[0]);
              params.svg = {
                url   : element[0].src,
                width : params.styles.width.replace('px', ''),
                height: params.styles.height.replace('px', ''),
                offset: ''
              };

              return params;
            },
            switchImage: function(element) {
              var params,
                  classes,
                  template;

              params = this.getImgParams(element);

              classes = '';

              // TODO: use templating or DOM elements here
              template = $(
                '<div class="grayscale-replaced ' + classes + '" data-id="img_grayscale">' +
                 // '<svg xmlns="http://www.w3.org/2000/svg" id="svgroot" viewBox="0 0 '+params.svg.width+' '+params.svg.height+'" width="'+params.svg.width+'" height="'+params.svg.height+'" style="'+params.svg.offset+'">' +
                  '<svg xmlns="http://www.w3.org/2000/svg" id="svgroot" width="'+params.svg.width+'" height="'+params.svg.height+'" style="'+params.svg.offset+'">' +
                    '<defs>' +
                      '<filter id="gray">' +
                        '<feColorMatrix type="matrix" values="0.3333 0.3333 0.3333 0 0 0.3333 0.3333 0.3333 0 0 0.3333 0.3333 0.3333 0 0 0 0 0 1 0" />' +
                      '</filter>' +
                    '</defs>' +
                    '<image filter="url(&quot;#gray&quot;)" x="0" y="0" width="'+params.svg.width+'" height="'+params.svg.height+'" xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="'+params.svg.url+'" />' +
                  '</svg>' +
                '</div>');

                params.styles['left'] = 0;
                params.styles['max-width'] = '100%';
                params.styles['display']  = 'inline-block';
                params.styles['overflow'] =
                params.styles['overflow-x'] =
                params.styles['overflow-y'] = 'hidden';

              // TODO: Should this really set all params or should we set only unique ones by comparing to a control element?
              template.css(params.styles);

              element.replaceWith(template);
            },

            /**
             * 리사이즈가 되면서 svg가 있는 엘리먼트의 크기 조정
             * @param  {[type]} $el [description] svg가 있는 element root
             * @param  {[type]} w   [description] width
             * @param  {[type]} h   [description] height
             */
            changeSvgScale: function($el, w, h) {
                $el.css('width', w+'px');
                $el.css('height', h+'px');
                $el.find('svg').attr('width', w);
                $el.find('svg').attr('height', h);
                $el.find('image').attr('width', w);
                $el.find('image').attr('height', h);
            }
        }

        /**
         * imageActive
         * 그레이스케일 이미지를 컬러로, 컬러이미지를 그레이스케일로 변환시키는 함수
         * @param  {[type]} $el      [description] 변환 시킬 이미지가 있는 element root
         * @param  {[type]} activeCh [description] true(컬러, 활성화), false(그레이스케일, 비활성화)
         * @param  {[type]} motionCh [description] true(애니메이션이되며 컬러변화), false(바로 변화)
         */
        function imageActive($el, activeCh, motionCh){
            var $activeEl = $el.find('>a'),
                $originalEl = $activeEl.find('[data-id=original]'),
                $targetEl = $activeEl.find('[data-id=original]'),
                imgWidth = $activeEl.find('[data-id=original]').width(),
                imgHeight = $activeEl.find('[data-id=original]').height();

            var motionTime = (motionCh)?((activeCh)?IMG_ACTIVE_TIME:IMG_DISABLE_TIME):0,
                opacityValue = (activeCh)?1:0;

            if ($originalEl.css('opacity') == opacityValue) {return;}
            
            if (motionCh) {
                $originalEl.stop().animate({opacity:opacityValue}, motionTime, 'cubicEaseOut', function(){
                });
            } else {
                $originalEl.stop().css('opacity', opacityValue);
            }
        }

        /**
         * 현재 스크롤의 위치계산하여 몇번째 이미지가 보여야 하는지 계산
         */
        function getCurrentID(){
            return Math.round($(window).scrollTop()/window.innerHeight);
        }


        function init(){
            el = $('.main_visual > li');
            ieVer = otherUtils.getInternetExplorerVersion();
            browser = otherUtils.getBrowser();
            setGrayscale();


            // 차후 마우스 버튼에 대한 액션시 아래 스크립트 적용
            /*el.on('mouseenter', '> a', function(e){
                imageActive($(this).parent(), true, true);
            });

            el.on('mouseleave', '> a', function(e){
                imageActive($(this).parent(), false, true);
            });*/
        }

        /**
         * ie10, ie11, edge애서의 스케일 변경
         */
        function ie10ImageScaleControll(){
            var $images, $imagesGray;

            if (ieVer >= 10 || browser == 'edge') {
                $images = $('[data-id=original]');
                $imagesGray = $('[data-id=img_grayscale]');

                $images.each(function(idx){
                    var $this = $(this),
                        $grayImg = $imagesGray.eq(idx),
                        w = $this.width(),
                        h = $this.height();

                    graySvgUtils.changeSvgScale($grayImg, w, h);
                });
            }
        }

        /**
         * Dom ready 후 기존 이미지를 복사 후 복사한 이미지에 grayscale 효과를 적용
         */
        function setGrayscale(){
            $(document).ready(function() {
                var $body = $('body'),
                    $images = $('[data-id=original]'),
                    $imagesGray;

                // element copy
                var $this, $newImg;

                $images.each(function(idx){
                    $this = $(this);
                    $newImg = $('<img />').attr({
                        'name': $this.attr('name'),
                        'alt': 'Main Image Grayscale',
                        'data-id': 'img_grayscale',
                        'src': $this.attr('src')
                    }).addClass('gray_visual').addClass('grayscale')

                    $this.parent().prepend($newImg);
                    $this.css('opacity', 0);
                });

                positionObj.targetID = getCurrentID();
                $images.eq(positionObj.targetID).css('opacity', 1);

                $imagesGray = $('[data-id=img_grayscale]');

                if (ieVer >= 10 || browser == 'edge'){
                    $imagesGray.each(function(){
                        $this = $(this);
                        graySvgUtils.switchImage($this);
                    });

                    ie10ImageScaleControll();
                }
            });
        }

        return {
            init: init, 
            imageActive: imageActive, 
            getCurrentID: getCurrentID, 
            positionObj: positionObj, 
            ie10ImageScaleControll: ie10ImageScaleControll
        };
    })();

    var fullScroll = (function(){
        var el;
        var list;
        var listTotal;      // modify 160128
        var imgHeight;
        var paddingTop;
        var liHeight;
        var scrollAnimated;
        var currentId = -1;
        var timeStamp = new Date().getTime();


        function init(){
            el = $('.main_visual');
            list = el.find('> li');
            listTotal = list.length;    // modify 160128
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
        
        /**
         * modify 151118
         * 스크롤의 위치에 따른 텍스트영역의 위치 산정
         * - scroll이 scrollMin ~ scrollMax 까지 변할 때, text 위치는 textPosMin 에서 textPosMax 까지 변한다.
         */
        function textAreaScrollMotion(scrollMin, scrollMax, textPosMin, textPosMax) {
            var documentHeight = otherUtils.getDocumentHeight(),
                nowScrollN,
                target;

            nowScrollN = $(window).scrollTop();
            target = Math.floor( ( textPosMax - textPosMin ) / ( scrollMax - scrollMin ) * (nowScrollN - scrollMin) + textPosMin);
            return target;
        }

        function tabletNPhone(){
            $(window).off('resize').on('resize', function(e){
                imgHeight = list.eq(0).find('>a').height();
                paddingTop = 10;
                el.css({position: 'relative', top: -paddingTop});
                list.css({height: liHeight, paddingTop: paddingTop, borderBottom: '0px solid #f00'});

                // modify 151118, resize 관련 grayscale
                overImg.ie10ImageScaleControll();
            }).triggerHandler("resize");

            $(window).on('scroll', function(e){
                list.each(function(idx, obj){
                    var top = $(window).scrollTop() < $(this).find('a').offset().top - 50;
                    var bottom = $(window).scrollTop() + window.innerHeight > $(this).find('a').offset().top + $(this).find('a').height() + 50;

                    if(top && bottom){
                        overImg.imageActive(list.eq(idx), true, true);
                        currentId = idx;
                    }else{
                        overImg.imageActive(list.eq(idx), false, true);
                    }
                });
            });

            $(window).trigger('scroll');
        }       
        
        function bindEvents(){
            var positionObj = overImg.positionObj,
                scrollResetPosTimer = 0;

            // 각 scroll boundary
            var scrollTotalMax = null, scrollAverage = null;


            $(window).off('resize').on('resize', function(e){
                imgHeight = list.eq(0).find('>a').height();
                paddingTop = 115;
                liHeight = window.innerHeight - paddingTop;
                el.css({position: 'relative', top: -paddingTop});
                el.next('.btn_area').css({marginTop: -205});
                list.css({height: liHeight, paddingTop: paddingTop, borderBottom: '0px solid #f00'});

                // modify 151118, 
                overImg.ie10ImageScaleControll();   // resize 관련 grayscale
                setScrollBoundary();                // 선택된 이미지위치 내의 scroll boundary를 정한다.

            }).triggerHandler("resize");

            /**
             * 선택된 이미지위치 내의 scroll boundary를 정한다.
             */
            function setScrollBoundary() {
                if (otherUtils.getDocumentHeight() > window.innerHeight) {
                    scrollAverage = window.innerHeight;
                    scrollTotalMax = otherUtils.getDocumentHeight() - scrollAverage;

                    list.each(function(idx){
                        var scrollMin = scrollAverage*idx,
                            scrollMax = scrollAverage*(idx+1),
                            $this = $(this),
                            $txtArea = $this.find('>.txt_area');

                        if (idx > 0) {scrollMin += 1;}

                        if ($txtArea.length > 0) {
                            $this.data('scrollTxtCtrlCh', true);
                            $this.data('scrollMin', scrollMin);
                            $this.data('scrollMax', scrollMax);
                        }else {
                            $this.data('scrollTxtCtrlCh', false);
                        }
                    })
                }
            }

            
            $(window).on('scroll', function(e){
                // modify 151118
                // scroll 이 있을시에 작동
                if (scrollTotalMax != null && scrollAnimated == false) {
                    list.each(function(idx){
                        var $this = $(this),
                            $txtArea = $this.find('>.txt_area').find('.txt'),
                            scrollTxtCtrlCh = $this.data('scrollTxtCtrlCh'),
                            scrollMin, 
                            scrollMax,
                            returnValue;

                        if (scrollTxtCtrlCh) {
                            scrollMin = $this.data('scrollMin');
                            scrollMax = $this.data('scrollMax');

                            returnValue = textAreaScrollMotion(scrollMin, scrollMax, 0, 200);
                            
                            if (returnValue >= 0 && returnValue <= 200) {
                                $txtArea.css('top', returnValue+'px');
                            }
                        }
                    });

                    if (positionObj.targetID != overImg.getCurrentID()) {
                        positionObj.currentID = positionObj.targetID;
                        positionObj.targetID = overImg.getCurrentID();
                        motionImgActive();
                    }
                }

                e.preventDefault();
                e.stopPropagation();
                return false;
            });

            /**
             * 이미지의 변환(컬러<->그레이스케일)
             */
            function motionImgActive(){
                overImg.imageActive(list.eq(positionObj.targetID), true, true);
                if (positionObj.currentID != null) {
                    overImg.imageActive(list.eq(positionObj.currentID), false, false);
                }
            }

            $(window).on('mousewheel', function(e){
                e.preventDefault();
                e.stopPropagation();

                if (scrollAnimated) {return;}

                var timeNow = new Date().getTime(),
                    windowHeight = window.innerHeight;

                e.preventDefault();

                if (timeNow - timeStamp < 200) {
                    timeStamp = timeNow;
                    return;
                } else {
                    timeStamp = timeNow;
                }

                scrollAnimated = true;
                currentId = overImg.getCurrentID();

                var $moveEl = $('html, body'),
                    listLen = list.length,
                    targetId = null,
                    deltaY = e.deltaY,
                    motionTime = 0;

                if (deltaY < 0) {
                    targetId = currentId + 1;
                    if (targetId == listLen) {targetId = listLen - 1;}
                    motionTime = 800;
                } else {
                    targetId = currentId - 1;
                    if (targetId < 0) {targetId = 0;}
                    motionTime = 400;
                }

                var targetScrollTop = targetId * windowHeight,
                    nowScrollTop = $(window).scrollTop(),
                    scrollLenLimit = otherUtils.getDocumentHeight() - windowHeight;

                // modify 160128
                if (listTotal <= 1) {
                    if (deltaY < 0 && nowScrollTop == scrollLenLimit) {
                        scrollAnimated = false;
                        return;
                    }
                    if (deltaY > 0 && nowScrollTop == 0) {
                        scrollAnimated = false;
                        return;
                    }
                }

                if (targetId == currentId) {
                    // 마지막일 경우 
                    if (targetId == listLen - 1) {
                        // scrollLenLimit = otherUtils.getDocumentHeight() - windowHeight;
                        // 실제 스크롤의 마지막이 아니라면,(휠마우스의 스크롤의 마지막 index표시는 맨마지막이 아니다.)
                        if ( nowScrollTop < scrollLenLimit) {
                            // 맨마지막으로 보낸다.
                            targetScrollTop = scrollLenLimit;
                        } else {
                            scrollAnimated = false;

                            // modify 160128, list가 1개이상일때만 중단
                            if (listTotal > 1) {return;}
                        }
                    } else {
                        var realPos = nowScrollTop/windowHeight;
                        if (realPos > currentId) {
                            targetId = Math.floor(realPos);
                            targetScrollTop = targetId * windowHeight;
                        } else if (realPos < currentId) {
                            targetId = Math.ceil(realPos);
                            targetScrollTop = targetId * windowHeight;
                        } else {
                            scrollAnimated = false;

                            // modify 160128, list가 1개이상일때만 중단
                            if (listTotal > 1) {return;}
                        }
                    }
                }

                var $targetTxtArea = list.eq(targetId).find('>.txt_area').find('.txt'),
                    targetTxtValue = null,
                    txtMotionTime = (motionTime-100);

                /**
                 * text area animation
                 * scrollAnimated 가 false 일때는 scroll event 내에 text부분이 작동하지 않는다.
                 */
                if (targetId != currentId) {
                    targetTxtValue = (currentId > targetId)?-300:300;
                    txtMotionTime = (currentId > targetId)?(motionTime+100):txtMotionTime;
                    $targetTxtArea.css('top', targetTxtValue+'px');
                } 

                $targetTxtArea.stop().animate({
                    'top': 0
                }, txtMotionTime , 'cubicEaseOut', function(){
                });

                /**
                 * scroll animation
                 */
                $moveEl.stop().animate({
                    scrollTop: targetScrollTop
                },{
                    duration: motionTime,
                    easing: 'cubicEaseOut',
                    complete: function() {
                        // html, body twice excute callback
                        // body event check
                        if ($(this)[0] == $('body')[0]) {
                            setTimeout(function(){
                                // scroll event block
                                scrollAnimated = false;

                                if (targetId != currentId) {
                                    positionObj.currentID = currentId;
                                    positionObj.targetID = targetId;
                                    motionImgActive();
                                }
                            }, 100);
                        }
                    }
                });
            });
        }

        return {init: init};
    })();

    window.refreshScroll = function(){
        setTimeout(function(){
            $(".nano").nanoScroller({alwaysVisible: true, preventPageScrolling: true});
        }, 0);
    };

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

            $(".nano").nanoScroller({alwaysVisible: true});
            // $('.cart_slide_area').each(function(idx, obj){
            //  utilCartRolling.init(obj);
            // });
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

                refreshScroll();
            }).on('mouseleave', function(e){
                mouseLeaveTimer = setTimeout(mouseLeaveAction, 10000);
            }).find('>a').on('click', function(e){
                e.preventDefault();

                var index = $(this).closest('li').index();

                if(index == 2){// 로그인일 경우
                    $(this).closest('li').find('.add_content>div').hide().eq(0).show();
                    el.find('> li').eq(index).triggerHandler('mouseenter');
                }
            });

            $(document).on('click', function(e){
                if($(e.target).closest('.util_menu_area').length <= 0){
                    mouseLeaveAction();
                }
            });
        }

        function mouseLeaveAction(){
            el.find('> li.on').find('.util_add').animate({opacity: 0}, 100, function(){
                el.find('> li').find('.util_add').each(function(idx, obj){
                    $(this).removeAttr('style')
                    pastHeight = 55;
                });
            });

            clearTimeout(mouseLeaveTimer);
        }

        function refresh(){
            el.find('> li.on').trigger('mouseenter');
        }

        return {
            init: init
            , refresh: refresh
        }
    })();

    window.utilCartRolling = (function(){
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

            setup();

            return this;
        }

        function setup(){
            currentId = 0;
            rollingWrapHeight = rollingWrap.height() - btnDown.height();
            totalCount = rollingBody.find('>div').length;
            pageSize = Math.ceil(totalCount/3);

            bindEvents();
        }

        function bindEvents(){
            btnUp.off('click').on('click', function(e){
                e.preventDefault();

                --currentId;

                if(currentId < 0){
                    // currentId = pageSize - 1;
                    currentId = 0;
                    return;
                }

                moveRolling();
            });

            btnDown.off('click').on('click', function(e){
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

        function refreshHeight(){
            setup();
        }

        return {
            init: init
            , refreshHeight: refreshHeight
        };
    })();

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

            el.find('.btn_arrow').show();

            bindEvents();
        }

        function bindEvents(){
            el.on('click', function(e){
                e.preventDefault();
                //$('.top_notice_banner').hide();

                if($(this).hasClass('active')){
                    $(this).removeClass('active');
                    //$('.top_notice_banner').show();
                    $('.header_content').css({zIndex: 1});
                    menuPanel.stop().css({opacity: 1}).show().animate({opacity: 0}, 300, function(){
                        $(this).hide();
                        // menuPanelBtnClose.off('click').on('click', function(e){
                        //  menuPanel.animate({opacity: 0}, 300, function(){
                        //      $(this).hide();
                        //  });
                        //  menuPanelBtnClose.off('click');
                        // });
                    });

                    TweenMax.to(el.find('rect:eq(0)'), 0.5, {y: 5, x: 0, rotation: 0});
                    TweenMax.to(el.find('rect:eq(1)'), 0.5, {y: 45, rotation: 0});
                    TweenMax.to(el.find('rect:eq(2)'), 0.5, {y: 85, x:0, rotation: 0});

                    el.find('.btn_arrow').show();
                    return;
                }

                $(this).addClass('active');

                $('.header_content').css({zIndex: 60});
                menuPanel.stop().css({opacity: 0}).show().animate({opacity: 1}, 300, function(){
                    // menuPanelBtnClose.off('click').on('click', function(e){
                    //  menuPanel.animate({opacity: 0}, 300, function(){
                    //      $(this).hide();
                    //  });
                    //  menuPanelBtnClose.off('click');
                    // });
                });

                TweenMax.to(el.find('rect:eq(0)'), 0.5, {y: 85, x: 10, rotation: -45});
                TweenMax.to(el.find('rect:eq(1)'), 0.5, {y: 45, rotation: -180});
                TweenMax.to(el.find('rect:eq(2)'), 0.5, {y: 15, x: 15, rotation: 45});

                el.find('.btn_arrow').show();

            });
        }

        return {init: init};
    })();
    
    var allMenuRadio = (function(){
        var el;
        var menuPanel;
        var menuPanelBtnClose;

        function init(){
            el = $('.btn_radio:not(.close)');
            menuPanel = $('.music_area');
            menuPanelBtnClose = menuPanel.find('.btn_radio');

            bindEvents();
        }

        function bindEvents(){
            el.on('click', function(e){
                e.preventDefault();

                if($(this).hasClass('active')){
                    actionClose(this);
                    return;
                }

                $(this).addClass('active');

                $('.header_content').css({zIndex: 60});
                
                menuPanel.stop().css({top: -670}).show();
                $('body').append('<div id="radioDimm" style="background:#fff;position:fixed;left:0;top:0;right:0;bottom:0;z-index:59;opacity:0;filter:alpha(opacity=0);"></div>');
                carharttRadio.init();

                $('#radioDimm').off('click touchstart touchmove').on('click touchstart touchmove', function(e){
                    actionClose();
                    $('#radioDimm').off('click touchstart touchmove')
                });

                menuPanel.animate({top: 0}, 700, function(){
                });
            });
        }
        
        function actionClose(obj){
            if(!obj){
                obj = el;
            }
            
            $(obj).removeClass('active');
            $('.header_content').css({zIndex: 1});
            $('#radioDimm').remove();
            menuPanel.stop().css({top: 0}).show().animate({top: -670}, 700, function(){
                $(this).hide();

                carharttRadio.destroy();    //carhartt radio destroy
            });
        }

        return {
            init: init
            , actionClose: actionClose
        };
    })();

    var allMenu_aware = (function(){
        var el;
        var menuPanel;
        var menuPanelBtnClose;
        var mySwipe;
        var length;

        function init(){
            el = $('.btn_awareness:not(.close)');
            menuPanel = $('.awareness_area');
            menuPanelBtnClose = menuPanel.find('.btn_awareness');
            length = $('.awareness_list > div').length;

            bindEvents();
        }

        function bindEvents(){
            el.on('click', function(e){
                e.preventDefault();

                if($(this).hasClass('active')){
                    actionClose(this);
                    return;
                }

                $(this).addClass('active');

                $('.header_content').css({zIndex: 60});
                
                menuPanel.stop().css({top: -774}).show();
                $('body').append('<div id="obeyDimm" style="background:#fff;position:fixed;left:0;top:0;right:0;bottom:0;z-index:59;opacity:0;filter:alpha(opacity=0);"></div>');
                setTimeout(function(){
                    setupSwipe();
                }, 0);

                $('#obeyDimm').off('click touchstart touchmove').on('click touchstart touchmove', function(e){
                    actionClose();
                    $('#obeyDimm').off('click touchstart touchmove')
                });

                menuPanel.animate({top: 0}, 700, function(){
                });
            });

            $('.btn_close_obey_awareness').off('click').on('click', function(e){
                e.preventDefault();
                
                actionClose();
            });

            menuPanel.find('.btn_awareness_prev').on('click', function(e){
                e.preventDefault();

                mySwipe.prev();
            });

            menuPanel.find('.btn_awareness_next').on('click', function(e){
                e.preventDefault();

                mySwipe.next();
            });
        }

        function setupSwipe(){
            mySwipe = Swipe($('.awareness_container')[0], {
                transitionEnd: function(index, element) {
                    setTimeout(function(){
                        menuPanel.find('.util01 span').text((index+1) + '/' + length);
                    }, 0);
                }
            });     
        }
        
        function actionClose(obj){
            if(!obj){
                obj = el;
            }
            
            $(obj).removeClass('active');
            $('.header_content').css({zIndex: 1});
            $('#obeyDimm').remove();
            menuPanel.stop().css({top: 0}).show().animate({top: -774}, 700, function(){
                $(this).hide();
                
                if(mySwipe){
                    // console.log(mySwipe);
                    mySwipe.kill(); //carhartt radio destroy
                }
            });
        }

        return {
            init: init
            , actionClose: actionClose
        };
    })();



    // 20150827 allMenu02함수 내 소스 수정
    //- 임시 모바일, 태블릿용 allMenu02
    window.allMenu02 = (function(){
        var el;
        var menuPanel;
        var menuPanelBtnClose;
        // var isWeb;
        var iscroll;
        var cartIscroll;
        var currentUtilIdx = -1;

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

            el.find('.btn_arrow').show();

            bindEvents();
        }

        function bindEvents(){
            el.on('click', function(e){
                e.preventDefault();

                var _this = this;
                if($(this).hasClass('active')){
                    // console.log('close');

                    menuPanel.transition({x: -275}, 300, function(){
                        $(this).hide();
                        $('body').css({overflow: 'auto'});
                    });
                    $('.header_content').transition({x: 0}, 500);
                    $('#container').transition({x: 0}, 500);
                    el.find('img').show();
                    // menuPanelBtnClose.hide().off('click');
                    
                    $('#dimm').off('click').remove();
                    $(document).off('.iscroll');

                    menuPanel.find('.util_menu02>li>a').off('click');
                    iscroll.destroy();
                    $(this).removeClass('active');

                    TweenMax.to(el.find('rect:eq(0)'), 0.5, {rotation: 0, y:0, attr: {width: 100}});
                    TweenMax.to(el.find('rect:eq(1)'), 0.5, {y: 30});
                    TweenMax.to(el.find('rect:eq(2)'), 0.5, {rotation: 0, y: 60, x: 0, attr: {width: 100}});

                    el.find('.btn_arrow').show();
                    return;
                }

                $(this).addClass('active');
                $('body').append('<div id="dimm" style="position:fixed;top:0;left:0;right:0;bottom:0;background:#000;opacity:0.6;z-index:20;"></div>');
                $('body').css({overflow: 'hidden', width: $(window).width()});
                $(document).on('touchmove.iscroll', function(e){e.preventDefault();});
                setTimeout(function(){
                    $('#dimm').on('click', function(e){
                        e.preventDefault();

                        // 상단 내용 복사
                        menuPanel.transition({x: -275, y: 0}, 300, function(){
                            $(this).hide();
                            setTimeout(function(){
                                $('body').css({overflow: 'auto'});
                            }, 200);
                        });
                        $('.header_content').transition({x: 0}, 500);
                        $('#container').transition({x: 0}, 500);
                        el.find('img').show();
                        // menuPanelBtnClose.hide().off('click');
                        
                        $('#dimm').off('click').remove();
                        $(document).off('.iscroll');

                        menuPanel.find('.util_menu02>li>a').off('click');
                        iscroll.destroy();
                        $(_this).removeClass('active');

                        TweenMax.to(el.find('rect:eq(0)'), 0.5, {rotation: 0, y:0, attr: {width: 100}});
                        TweenMax.to(el.find('rect:eq(1)'), 0.5, {y: 30});
                        TweenMax.to(el.find('rect:eq(2)'), 0.5, {rotation: 0, y: 60, x: 0, attr: {width: 100}});

                        el.find('.btn_arrow').show();
                        return;
                    });
                }, 0);

                // el.find('img').hide();
                // menuPanelBtnClose.show();

                menuPanel.stop().css({height: window.innerHeight, top:$(window).scrollTop(), x: -275}).show().transition({x: 0}, 300, function(){
                    TweenMax.to(el.find('rect:eq(0)'), 0.5, {rotation: -45, y:30, attr: {width: 46}});
                    TweenMax.to(el.find('rect:eq(1)'), 0.5, {y: 30});
                    TweenMax.to(el.find('rect:eq(2)'), 0.5, {rotation: 45, y: 35, x: 7, attr: {width: 46}});

                    el.find('.btn_arrow').show();

                    iscroll = new IScroll(menuPanel.get(0), {click: true});
                    // console.log(menuPanel.find('.util_menu02>li>a'));
                    menuPanel.find('.util_menu02>li>a').off('click').on('click', function(e){
                        e.preventDefault();
                        
                        var utilAdd = $(this).closest('li').find('.util_add');
                        // menuPanel.find('.util_menu02>li .util_add').each(function(idx, obj){
                        //  if($(obj).is(':visible')){
                        //      utilAdd.hide();
                        //  }else{
                        //      utilAdd.show();
                        //  }
                        // });

                        // menuPanel.find('.util_menu02>li .util_add').hide();
                        var utilAdd = $(this).closest('li').find('.util_add');
                        // console.log(utilAdd, utilAdd.is(':visible'));
                        var index = $(this).closest('li').index();
                        // console.log(currentUtilIdx, index);
                        if(currentUtilIdx == index){
                            // console.log(index);
                            if(index == 2){
                                if(!$(this).closest('li').find('.add_content>div:eq(0)').is(':visible')){
                                    $(this).closest('li').find('.add_content>div').hide().eq(0).show();
                                    currentUtilIdx = index;

                                    utilRefresh();
                                    return;
                                }
                                
                            }
                            utilAdd.hide();
                            menuPanel.find('.util_menu02>li .util_add').hide();
                            menuPanel.find('.util_menu_area02').css({height: 'initial'});
                            currentUtilIdx = -1;
                            iscroll.refresh();
                            return;
                        }else{
                            menuPanel.find('.util_menu02>li .util_add').hide();
                            utilAdd.show();
                            currentUtilIdx = index;
                        }
                        // if(menuPanel.find('.util_menu02').hasClass('active')){
                        //  utilAdd.hide();
                        //  menuPanel.find('.util_menu02').removeClass('active');
                        // }else{
                        //  utilAdd.show();
                        //  menuPanel.find('.util_menu02').addClass('active');
                        // }

                        if($(this).closest('li').is(':last-child')){
//                            $('.all_menu_list02').hide();
                            $('.cart_ctr').hide();
                            $('.cart_slide_area').css({paddingTop: 0});
                            $('.cart_slide_container:visible').css({height: 0});
                            $('.cart_slide_container:visible').css({height: window.innerHeight - $('.add_content:visible').outerHeight(true)});

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
                    //  e.preventDefault();

                    //  menuPanel.transition({x: -275}, 300, function(){
                    //      $(this).hide();
                    //  });
                    //  $('.header_content').transition({x: 0}, 500);
                    //  $('#container').transition({x: 0}, 500);
                    //  el.find('img').show();
                    //  menuPanelBtnClose.hide().off('click');
                    //  $('body').css({overflow: 'auto'});
                    //  $(document).off('.iscroll');

                    //  menuPanel.find('.util_menu02>li>a').off('click');
                    //  iscroll.destroy();
                    // });
                });

                $('.header_content').transition({x: 275}, 500);
                $('#container').transition({x: 275}, 500);
            });
        }

        function utilRefresh(){
            menuPanel.find('.util_menu_area02').height(menuPanel.find('.util_menu02>li:eq(2) .util_add').height());
            if(iscroll){
                iscroll.refresh();
            }
        }

        return {
            init: init
            , utilRefresh: utilRefresh
        };
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
                	$(".product_position_ctr").show();
                	
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
                    iscroll = new IScroll(el.find('.snb_mobile_sub_menu').get(0), {click:true});
                }

                $(".product_position_ctr").hide();
                
                iscroll.refresh();
                
                
            });
        }

        return {init: init};
    })();
    
    
    var productDetailTab = (function(){
        var el,
            initStatus = true;  // 첫시작일때 수정 modify 151125

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

                // 첫 페이지 시작일때는 무조건 열어준다. modify 151125
                if (initStatus) {
                    el.find('>a').removeClass('on');
                    $(this).addClass('on');
                    el.find('>div, >ul').hide();
                    $(this).next().show();
                    initStatus = false;
                    return;
                }

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
                        	if ($('.footer_newsletter_area').find("input").val().length == 0) {	// input에 값이 없을때만 숨김
                        		$('.footer_newsletter_area').hide();
                        		$(document).off('.news_letter');
							}
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
        var currentCount = 0;
        var btnDetailViewType;
        var btnListViewType;
        var listBody;

        function init(){
            el = $('.lookbook_detail_layer');

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
            //  $(this).find('img').css({marginTop: Math.ceil((detailWrap.height() - $(this).find('img').height())/2)});
            // });
        }
        
        function resizeImage(obj){
            var ratio;
            var type;
            
            obj.each(function(idx, o){
                type = $(o).attr('data-type');
                
                if(type == 'horizontal'){
                    ratio = 640/960;
                }else if(type == 'vertical'){
                    ratio = 1000/758;
                }
                
                var windowRatio;
                var _window;

                var width = 0;
                var height = 0;
                var marginTop = 0;
                var marginLeft = 0;

                //$(window).off('resize').on('resize', function(){
                _window = $(window);

                windowRatio = _window.height()/(_window.width());

                if(ratio < windowRatio){
//                  console.log(1);
                    
                    width = _window.width();
                    height = Math.round(_window.width() * ratio);
                    marginTop = Math.round((_window.height() - height)/2);
//                      marginLeft = 0;
                    
                    if(width > 960){
                        width = 960;
                        height = Math.round(width * ratio);
                        marginTop = Math.round((_window.height() - height)/2);
                    }
                }else{
//                  console.log(2);
                    width = Math.round(_window.height() / ratio);
                    height = _window.height();
                    marginTop = 0;
//                      marginLeft = _window.width();
                    if(width > 960){
                        width = 960;
                        height = Math.round(width * ratio);
                        marginTop = Math.round((_window.height() - height)/2);
                    }
                }
                
                $(o).css({width: width, height: height, marginTop: marginTop});
                //}).triggerHandler('resize');
            });
            
        }
        
        function bindEvents(){

            
//          $(window).on('resize', function(e){
//              if(pastElWidth == $(window).width()){
//                  return;
//              }
//              detail.css({width: el.width()});
//              list.css({width: el.width()});
//
//              pastElWidth = $(window).width();
//
//              //imgVerticalAlign();
//          }).trigger('resize');

            $(window).on('load', function(e){
                e.preventDefault();

                imgVerticalAlign();
            });
            
            $('.lookbook_detail_new > li > a').on('click', function(e){
                var $target = $(e.currentTarget);
                var src = $target.find("span > img").prop("src");
                
                //$(".lookbook_detail_layer_wrap").find("img").attr("src", src);    
                $('.lookbook_detail_layer').show();
                
                var index = $(this).closest('li').index();
                currentCount = index;
                showDetailNew();
            });
            
            $('.lookbook_detail_layer_close').on('click', function(e){
                $('.lookbook_detail_layer').hide();
                
                objSwipeDetail.kill();
                objSwipeDetail = null;
                
                //objSwipeDetail.
            });

            
            
            $(window).off('resize').on('resize', function(){
                resizeImage($('.lookbook_detail_layer_item img'));
            }).triggerHandler('resize');
        }
        
        function showDetailNew(){
            loadImage(currentCount);

            objSwipeDetail = Swipe(detailWrap.get(0), {
                startSlide: currentCount,
                // auto: 3000,
                // continuous: true,
                // disableScroll: true,
                // stopPropagation: true,
                // callback: function(index, element) {

                // },
                transitionEnd: function(index, element) {
                    currentCount = index;

                    loadImage(currentCount);

                    viewDetailText();
                    setCount();
                    imgVerticalAlign();
                }
            });
            window.objSwipeDetail = objSwipeDetail;
            viewDetailText();
            setCount();
            imgVerticalAlign();

            btnDetailPrev.off('click').on('click', function(e){
                e.preventDefault();

                loadImage('left');

                objSwipeDetail.prev();
            });

            btnDetailNext.off('click').on('click', function(e){
                e.preventDefault();

                loadImage('right');

                objSwipeDetail.next();
            });

            $(document).off('keydown').on('keydown', function(e){
                e = e || window.event;

                if (e.keyCode == '37') {
                    // left arrow
                    btnDetailPrev.triggerHandler('click');
                }else if (e.keyCode == '39') {
                    // right arrow
                    btnDetailNext.triggerHandler('click');
                }else if (e.keyCode == '27') {
                    // esc
                    // console.log('esc');
                    $('.lookbook_detail_layer_close').triggerHandler('click');
                }
            });
        }

        function loadImage(direction){
            var _no;
            var currentImg;
            if(direction == 'left'){
                _no = (objSwipeDetail.getPos()-1 + objSwipeDetail.getNumSlides()) % objSwipeDetail.getNumSlides();
                currentImg = detailWrap.find('.lookbook_item img').eq(_no);
                currentImg.attr({src: currentImg.attr('data-src')});
            }else if(direction == 'right'){
                _no = (objSwipeDetail.getPos()+1 + objSwipeDetail.getNumSlides()) % objSwipeDetail.getNumSlides();
                currentImg = detailWrap.find('.lookbook_item img').eq(_no);
                currentImg.attr({src: currentImg.attr('data-src')});
            }else{
                currentImg = detailWrap.find('.lookbook_item img').eq(direction);
                currentImg.attr({src: currentImg.attr('data-src')});
            }

            if(currentImg.hasClass('ui_complete')){

            }else{
                $('.lookbook_detail_layer_wrap').addClass('loading');

                currentImg.off('load').on('load', function(e){
                    currentImg.addClass('ui_complete');
                    $(window).triggerHandler('resize');
                    $(this).stop().animate({opacity: 1}, 300);

                    $('.lookbook_detail_layer_wrap').removeClass('loading');
                });
            }
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
            $("div[class='lookbook_detail_layer_info clfix']").find("ul").html($(obj).find('ul').html());

//          $(obj).find('ul>li').each(function(idx, obj){
//              detailInfoList.find('li').eq(idx).text($(obj).text());
//          });
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
    //  var el;

    //  function init(){
    //      el = $('.ui_expand');

    //      if(el.length <= 0){
    //          return;
    //      }

    //      bindEvents();
    //  }

    //  function bindEvents(){
    //      el.each(function(idx, obj){
    //          setTh = $(obj).find('thead th');

    //          $(obj).find('.mobile_th').each(function(){
    //              var index = $(this).closest('td').index();

    //              $(this).text(setTh.eq(index).text());
    //          });
    //      });
    //  }

    //  return {init: init};
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
            $.get('http://loc.brixton.co.kr/jsp/worksout/include/layout/layer_common.jsp').done(function(data){
                var content = $(data).find('.' + template);
    
            
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
    
    var storeInfo = (function(){
        var el;
        var lat;
        var lng;
        var title;
        var swipeTarget;
        var mySwipe;
        var rolling;
        var width;
        var height;
        var ratio;

        function init(){
            el = $('.store_info_aera');
            lat = $("#lat").val();
            lng = $("#lng").val();
            title = $("#naverMap").attr("title");

            if(el.length <= 0){
                return;
            }
            
            if(lat.length < 0 && lng.lng < 0 && title == ''){
                return;
            }

            swipeTarget = el.find('.ui_swipe');
            rolling = el.find('.ui_rolling');

            bindEvents();
            initMap(lat,lng,title);
        }

        function bindEvents(){
            //- var elem = document.getElementById('mySwipe');
            mySwipe = Swipe(swipeTarget.get(0), {
                // startSlide: 4,
                // auto: 3000,
                // continuous: true,
                // disableScroll: true,
                // stopPropagation: true,
                // callback: function(index, element) {},
                transitionEnd: function(index, element) {
                    rolling.find('a').removeClass('on').eq(index).addClass('on');
                }
            });

            var swipeLength = swipeTarget.find('.store_info_item').length;
            var rollingContent = '';
            for(var i = 0 ; i < swipeLength ; i++){
                rollingContent += '<a href="#"><span class="hide_txt">' + i + '</span></a>';
            }
            rolling.html(rollingContent);
            rolling.find('a:eq(0)').addClass('on');

            rolling.on('click', 'a', function(e){
                e.preventDefault();

                var index = $(this).index();

                mySwipe.slide(index);
            });

            el.find('.btn_prev').on('click', function(e){
                e.preventDefault();

                mySwipe.prev();
            });

            el.find('.btn_next').on('click', function(e){
                e.preventDefault();

                mySwipe.next();
            });

            // width = swipeTarget.width();
            // height = swipeTarget.height();
            // ratio = width/height;


            // $('#naverMap').css({width: width, height: height});

            $(window).on('resize', function(e){
                width = swipeTarget.width();
                height = swipeTarget.height();
                ratio = width/height;
                
                width = $('.store_info_aera').width();
                height = width / ratio;

                $('#naverMap').css({width: width, height: height});

                oMap.setSize(new nhn.api.map.Size(width, height));
            });

            $(window).on('load', function(e){
                $(window).triggerHandler('resize');
            });

            $(".btn_map a").on("click",function(){
                if($(this).closest('.btn_map').hasClass("on")){
                    // // e.preventDefault();
                    $('.btn_map').removeClass('on');
                    $(this).text('MAP');
                    //$('.store_info_slide_wrap').show();
                    //$('.store_info_map_wrap').hide();
                    

                    
                    $('.store_info_map_wrap').fadeOut( "slow", function() {
                        $('.store_info_slide_list').fadeIn( "slow", function() {
                        });
                    });

                    
                    mySwipe.setup();
                }else{
                    $('.btn_map').addClass('on');
                    $(this).text('BACK');
                    //$('.store_info_slide_list').hide();
                    //$('.store_info_map_wrap').show();
                    
                    $('.store_info_slide_list').fadeOut( "slow", function() {
                        $('.store_info_map_wrap').fadeIn( "slow", function() {
                        });
                    });                 
                    //- $('.store_info_slide_wrap').hide();
                    //- $('.store_info_map_wrap').show();
                }
            });
        }

        function initMap(lat,lng,mTitle){
            var oPoint = new nhn.api.map.LatLng(lat, lng);
            var defaultLevel = 12;
            nhn.api.map.setDefaultPoint('LatLng');
            oMap = new nhn.api.map.Map('naverMap' ,{
                        point : oPoint,
                        zoom : defaultLevel,
                        enableWheelZoom : true,
                        enableDragPan : true,
                        enableDblClickZoom : false,
                        mapMode : 0,
                        activateTrafficMap : false,
                        activateBicycleMap : false,
                        minMaxLevel : [ 1, 14 ],
                        size : new nhn.api.map.Size(width, height)
                    });
            var oInfoWnd = new nhn.api.map.InfoWindow();
            oInfoWnd.setVisible(false);
            oMap.addOverlay(oInfoWnd);

            oInfoWnd.setPosition(oPoint);
            var oSlider = new nhn.api.map.ZoomControl();
            oMap.addControl(oSlider);
            oSlider.setPosition({
                    top : 400,
                    left : 920
            });
            oSlider.setCenterMarkOptions(true);

            var oSize = new nhn.api.map.Size(28, 37);
            var oOffset = new nhn.api.map.Size(14, 37);
            var oIcon = new nhn.api.map.Icon('http://static.naver.com/maps2/icons/pin_spot2.png', oSize, oOffset);
            
            oMap.attach('mouseenter', function(oCustomEvent) {

                var oTarget = oCustomEvent.target;
                // 마커위에 마우스 올라간거면
                if (oTarget instanceof nhn.api.map.Marker) {
                        var oMarker = oTarget;
                        oLabel.setVisible(true, oMarker); // - 특정 마커를 지정하여 해당 마커의 title을 보여준다.
                }
            });

            oMap.attach('mouseleave', function(oCustomEvent) {

                var oTarget = oCustomEvent.target;
                // 마커위에서 마우스 나간거면
                if (oTarget instanceof nhn.api.map.Marker) {
                        oLabel.setVisible(false);
                }
            });

            var oLabel = new nhn.api.map.MarkerLabel(); // - 마커 라벨 선언.
            oMap.addOverlay(oLabel); // - 마커 라벨 지도에 추가. 기본은 라벨이 보이지 않는 상태로 추가됨.

            var oMarker = new nhn.api.map.Marker(oIcon, { title : mTitle });
            oMarker.setPoint(oPoint);
            oMap.addOverlay(oMarker);

        }

        return {init: init};
    })();
    
    var carharttRadio = (function(){
        var el;
        var musicContainer;
        var thumbContainer;
        var musicSwiper;
        var thumbSwiper;
        
        function init(){
            el= $('.music_area');
            
            if(el.length <= 0){
                return;
            }
            
            musicContainer = el.find('.music_container');
            thumbContainer = el.find('.music_thumb_container');
            
            $('.music_thumb_list a').removeClass('on').eq(0).addClass('on');
            
            bindEvents();
        }
        
        function bindEvents(){
            thumbSwiper = new Swiper(thumbContainer.get(0), {
                slidesPerView: 'auto',
                centeredSlides: true,
                onSlideChangeStart: function(swiper){
                    setTimeout(function(){
                        var index = swiper.activeIndex;
                        // console.log(11111, index);
                        musicSwiper.slideTo(index);
                        $('.music_thumb_list a').removeClass('on').eq(index).addClass('on');
                    }, 0);
                }
            });

            musicSwiper = new Swiper(musicContainer.get(0), {
                slidesPerView: 1,
                centeredSlides: true,
                spaceBetween: 0,
                // loop: true,
                onSlideChangeStart: function(swiper){
                    // console.log(thumbSwiper);
                    // var index = musicContainer.find('.swiper-slide-active').data('swiper-slide-index');
                    var index = swiper.activeIndex;
                    // console.log(22222, index);
                    thumbSwiper.slideTo(index);
                }
            });
            
            
            
            $('.btn_music_prev').off('click').on('click', function(e){
                e.preventDefault();
                
                musicSwiper.slidePrev();
            });
            
            $('.btn_music_next').off('click').on('click', function(e){
                e.preventDefault();
                
                musicSwiper.slideNext();
            });
            
            $('.btn_music_close').off('click').on('click', function(e){
                e.preventDefault();
                
                allMenuRadio.actionClose();
            });
            
            $('.music_thumb_list a').off('click').on('click', function(e){
                e.preventDefault();
                
                var index = $(this).index();
                
                thumbSwiper.slideTo(index);
                // musicSwiper.slideTo(index);
            });
        }
        
        function destroy(){
            // console.log('destroy');
        }
        
        return {
            init: init
            , destroy: destroy
        };
    })();

    var carharttRadioPopup = (function(){
        var el;
        var objSwipe;

        function init(){
            el = $('.pop_thumb_list_wrap');

            if(el.length <= 0){
                return;
            }

            bindEvents();
        }

        function bindEvents(){
            objSwipe = Swipe(el.find('.pop_thumb_list_container').get(0), {
                transitionEnd: function(index, element) {
                    
                }
            });

            el.find('.pop_btn_prev').off('click').on('click', function(e){
                e.preventDefault();

                objSwipe.prev();
            });

            el.find('.pop_btn_next').off('click').on('click', function(e){
                e.preventDefault();

                objSwipe.next();
            });
        }

        return {init: init};
    })();

    //modify 151118
    var btnArrrowAnimation = (function(){
        var $btnHorizon,
            $btnAnimate;

        function init(){
            $btnArrowAnimate = $('[data-id=btnArrowAnimate]');

            $btnArrowAnimate.each(function(){
                $btnAnimate = $(this).find('.animate');
                $btnAnimate.data('originalHeight', parseInt($btnAnimate.height()));
                $btnAnimate.data('originalWidth', parseInt($btnAnimate.width()));
            });

            $btnArrowAnimate.css({'overflow': 'hidden', 'display': 'inline-block'});

            $btnArrowAnimate.on('click', function(e){
                location.href = $(this).attr('href');
                e.preventDefault();
                return false;
            });

            $btnArrowAnimate.on('mouseenter', function(){
                var $btnAni = $(this).find('.animate'),
                    $btnTxtAni,
                    btnType = $(this).attr('data-btn-type');

                $btnAni.stop();
                if (btnType == 'horizon') {
                    // horizon type 
                    if (parseInt($btnAni.css('left')) == 0) {
                        $btnAni.css('left', -$btnAni.width() + 'px');
                    }
                    $btnAni.css('display','').animate({
                        left: 0
                    }, 200);

                } else {
                    // vertical type
                    $btnTxtAni = $(this).find('.txt02');
                    $btnTxtAni.stop();
                    if (parseInt($btnAni.height()) == $btnAni.data('originalHeight')) {
                        $btnAni.css('height', 0);
                    }

                    $btnTxtAni.animate({
                        'margin-left':'11px'
                    }, 100);

                    $btnAni.css('display','').animate({
                        height: $btnAni.data('originalHeight')
                    }, 200); 
                }
                
            });

            $btnArrowAnimate.on('mouseleave', function(){
                var $btnAni = $(this).find('.animate'),
                    $btnTxtAni,
                    btnType = $(this).attr('data-btn-type');

                $btnAni.stop();
                if (btnType == 'horizon') {
                    // horizon type
                    $btnAni.animate({
                        left: -parseInt($btnAni.width())
                    }, 100, function(){
                        $btnAni.hide();
                    });
                } else {
                    // vertical type
                    $btnTxtAni = $(this).find('.txt02');
                    $btnTxtAni.stop();

                    $btnAni.animate({
                        height: 0
                    }, 50, function(){
                        $btnAni.hide();
                        $btnTxtAni.animate({
                            'margin-left':'4px'
                        }, 200);
                    }); 
                }
            });
        }
        return {init:init};
    })();

    $(function(){
        textPlaceHolderInit(); // ie7,8 가능한 placeholder

        header.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
        footer.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
        snbMain.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
        snbShop.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
        snbNews.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
        snbStoreInfo.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
        snbAboutUs.init();
        snbLookBook.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
        snbJoin.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
        snbMypage.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
        snbCart.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
        snbOrder.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
        snbContactUs.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
        snbWorkWithUs.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)
        snbSearch.init(); // 개발언어로 변경시 이 부분 삭제 해야 합니다. (개발언어로 인클루드 필요.)


        agreement01.init(); // 약관 로드
        agreement02.init(); // 약관 로드
        agreement03.init(); // 약관 로드
        agreement04.init(); // 약관 로드

        overImg.init();
        fullScroll.init();

        snbShopFolding.init();

        // /lookbook/lookbook_detail.jsp
        lookBook.init();

        // /mypage/mypage.jsp
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
        
        storeInfo.init();

        carharttRadioPopup.init();
        
        // modify 151118
        btnArrrowAnimation.init();
    });



})(jQuery);

// test popup callback
function callback_test01(){
    // console.log(1);
}