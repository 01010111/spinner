(function ($global) { "use strict";
var $estr = function() { return js_Boot.__string_rec(this,''); },$hxEnums = $hxEnums || {},$_;
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.remove = function(a,obj) {
	var i = a.indexOf(obj);
	if(i == -1) {
		return false;
	}
	a.splice(i,1);
	return true;
};
HxOverrides.now = function() {
	return Date.now();
};
var Main = function() { };
Main.__name__ = true;
Main.main = function() {
	Main.load_settings();
};
Main.init_page = function() {
	var list = window.document.getElementById("list");
	list.onchange = function() {
		Main.format_list(list.value);
	};
	var settings = window.document.getElementById("settings");
	var shuffle = window.document.getElementById("shuffle");
	var show_every_list_item = window.document.getElementById("show_every_list_item");
	var animate_time_min = window.document.getElementById("animate_time_min");
	var animate_time_max = window.document.getElementById("animate_time_max");
	var spin_time = window.document.getElementById("spin_time");
	shuffle.checked = Main.settings.shuffle;
	show_every_list_item.checked = Main.settings.show_every_list_item;
	animate_time_min.value = Std.string(Main.settings.animate_time_min);
	animate_time_max.value = Std.string(Main.settings.animate_time_max);
	spin_time.value = Std.string(Main.settings.spin_time);
	shuffle.onchange = function() {
		return Main.settings.shuffle = shuffle.checked;
	};
	show_every_list_item.onchange = function() {
		return Main.settings.show_every_list_item = show_every_list_item.checked;
	};
	animate_time_min.onchange = function() {
		var tmp = parseFloat(animate_time_min.value);
		return Main.settings.animate_time_min = tmp;
	};
	animate_time_max.onchange = function() {
		var tmp = parseFloat(animate_time_max.value);
		return Main.settings.animate_time_max = tmp;
	};
	spin_time.onchange = function() {
		var tmp = parseFloat(spin_time.value);
		return Main.settings.spin_time = tmp;
	};
	window.document.getElementById("list-button").onclick = function() {
		if(!Main.begun) {
			list.classList.toggle("hidden");
		}
	};
	window.document.getElementById("settings-button").onclick = function() {
		if(!Main.begun) {
			settings.classList.toggle("hidden");
		}
	};
};
Main.load_settings = function() {
	var req = new XMLHttpRequest();
	req.open("GET","settings.json");
	req.onload = function() {
		var _g = [];
		var _g1 = 0;
		var _g2 = req.responseText.split("\n");
		while(_g1 < _g2.length) _g.push(_g2[_g1++].split("//")[0]);
		Main.settings = JSON.parse(_g.join("\n"));
		Main.animate_time = Main.settings.animate_time_min;
		Main.load_list();
	};
	req.send();
};
Main.load_list = function() {
	var req = new XMLHttpRequest();
	req.open("GET","list.txt");
	req.onload = function() {
		Main.format_list(req.response);
		Main.value = window.document.getElementById("value_container");
		Main.value.onclick = Main.begin;
		Main.init_page();
	};
	req.send();
};
Main.format_list = function(src) {
	Main.values = Main.parse_list(src);
};
Main.update = function(time) {
	if(Main.last == null) {
		Main.last = time;
	}
	var dt = (time - Main.last) / 1000;
	zero_utilities_Tween.update(dt);
	zero_utilities_Timer.update(dt);
	Main.last = time;
	Main.value.style.opacity = "" + Main.opacity;
	Main.value.style.marginTop = "" + Main.offset * Main.offset_amt;
	Main.value.style.transform = "scaleY(" + Main.scale + ")";
	window.requestAnimationFrame(Main.update);
};
Main.begin = function() {
	if(Main.begun) {
		return;
	}
	if(Main.settings.shuffle) {
		zero_extensions_ArrayExt.shuffle(Main.values);
	}
	Main.begun = true;
	window.requestAnimationFrame(Main.update);
	var total_time = Main.settings.spin_time;
	if(Main.settings.show_every_list_item) {
		var time = 0.0;
		var _g = 0;
		var _g1 = Main.values.length;
		while(_g < _g1) {
			var t = _g++ / Main.values.length;
			time += (1 - t) * (Main.settings.animate_time_min / 2) + t * (Main.settings.animate_time_max / 2);
		}
		total_time = time;
	}
	zero_utilities_Tween.get(Main).from_to("animate_time",Main.settings.animate_time_min,Main.settings.animate_time_max).duration(total_time).on_complete(function() {
		Main.complete = true;
	});
	zero_utilities_Tween.tween(Main,Main.animate_time / 2,{ opacity : 0, offset : 1, scale : 0.5},{ on_complete : Main.animate});
};
Main.animate = function() {
	Main.offset = -1;
	Main.scale = 0.5;
	Main.opacity = 0;
	Main.value.innerText = Main.values[0];
	Main.values.push(Main.values.shift());
	Main.count++;
	var is_complete = Main.complete;
	if(Main.settings.show_every_list_item) {
		is_complete = is_complete && Main.count >= Main.values.length;
	}
	if(is_complete) {
		zero_utilities_Tween.tween(Main,Main.animate_time,{ opacity : 1, offset : 0, scale : 1},{ ease : zero_utilities_Ease.smoothStepOut, on_complete : function() {
			zero_utilities_Timer.get(0.4,function() {
				Main.value.classList.add("invert");
			});
		}});
		return;
	}
	zero_utilities_Tween.tween(Main,Main.animate_time / 2,{ opacity : 1, offset : 0, scale : 1},{ on_complete : function() {
		zero_utilities_Tween.tween(Main,Main.animate_time / 2,{ opacity : 0, offset : 1, scale : 0.5},{ on_complete : Main.animate});
	}});
};
Main.parse_list = function(s) {
	var out = [];
	var _g = 0;
	var _g1 = s.split("\n");
	while(_g < _g1.length) out.push(_g1[_g++]);
	return out;
};
Math.__name__ = true;
var Reflect = function() { };
Reflect.__name__ = true;
Reflect.field = function(o,field) {
	try {
		return o[field];
	} catch( _g ) {
		return null;
	}
};
Reflect.getProperty = function(o,field) {
	var tmp;
	if(o == null) {
		return null;
	} else {
		var tmp1;
		if(o.__properties__) {
			tmp = o.__properties__["get_" + field];
			tmp1 = tmp;
		} else {
			tmp1 = false;
		}
		if(tmp1) {
			return o[tmp]();
		} else {
			return o[field];
		}
	}
};
Reflect.setProperty = function(o,field,value) {
	var tmp;
	var tmp1;
	if(o.__properties__) {
		tmp = o.__properties__["set_" + field];
		tmp1 = tmp;
	} else {
		tmp1 = false;
	}
	if(tmp1) {
		o[tmp](value);
	} else {
		o[field] = value;
	}
};
Reflect.fields = function(o) {
	var a = [];
	if(o != null) {
		var hasOwnProperty = Object.prototype.hasOwnProperty;
		for( var f in o ) {
		if(f != "__id__" && f != "hx__closures__" && hasOwnProperty.call(o,f)) {
			a.push(f);
		}
		}
	}
	return a;
};
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
var haxe_iterators_ArrayIterator = function(array) {
	this.current = 0;
	this.array = array;
};
haxe_iterators_ArrayIterator.__name__ = true;
haxe_iterators_ArrayIterator.prototype = {
	hasNext: function() {
		return this.current < this.array.length;
	}
	,next: function() {
		return this.array[this.current++];
	}
};
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__string_rec = function(o,s) {
	if(o == null) {
		return "null";
	}
	if(s.length >= 5) {
		return "<...>";
	}
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) {
		t = "object";
	}
	switch(t) {
	case "function":
		return "<function>";
	case "object":
		if(o.__enum__) {
			var e = $hxEnums[o.__enum__];
			var con = e.__constructs__[o._hx_index];
			var n = con._hx_name;
			if(con.__params__) {
				s = s + "\t";
				return n + "(" + ((function($this) {
					var $r;
					var _g = [];
					{
						var _g1 = 0;
						var _g2 = con.__params__;
						while(true) {
							if(!(_g1 < _g2.length)) {
								break;
							}
							var p = _g2[_g1];
							_g1 = _g1 + 1;
							_g.push(js_Boot.__string_rec(o[p],s));
						}
					}
					$r = _g;
					return $r;
				}(this))).join(",") + ")";
			} else {
				return n;
			}
		}
		if(((o) instanceof Array)) {
			var str = "[";
			s += "\t";
			var _g = 0;
			var _g1 = o.length;
			while(_g < _g1) {
				var i = _g++;
				str += (i > 0 ? "," : "") + js_Boot.__string_rec(o[i],s);
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( _g ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") {
				return s2;
			}
		}
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		var k = null;
		for( k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) {
			str += ", \n";
		}
		str += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "string":
		return o;
	default:
		return String(o);
	}
};
var zero_extensions_ArrayExt = function() { };
zero_extensions_ArrayExt.__name__ = true;
zero_extensions_ArrayExt.shuffle = function(array) {
	var _g = 0;
	var _g1 = array.length;
	while(_g < _g1) {
		var i = _g++;
		var n = array.length;
		var j = Math.random() * n | 0;
		var a = array[i];
		array[i] = array[j];
		array[j] = a;
	}
	return array;
};
var zero_utilities_Ease = function() { };
zero_utilities_Ease.__name__ = true;
zero_utilities_Ease.smoothStepOut = function(t) {
	var t1 = t / 2 + 0.5;
	return 2 * (t1 * t1 * (t1 * -2 + 3)) - 1;
};
var zero_utilities_Timer = function() {
};
zero_utilities_Timer.__name__ = true;
zero_utilities_Timer.get = function(time,fn,repeat) {
	if(repeat == null) {
		repeat = 1;
	}
	var timer = zero_utilities_Timer.pool.length > 0 ? zero_utilities_Timer.pool.shift() : new zero_utilities_Timer();
	timer.time = time;
	timer.fn = fn;
	timer.repeat = repeat;
	timer.paused = false;
	timer.elapsed = 0;
	zero_utilities_Timer.timers.push(timer);
	return timer;
};
zero_utilities_Timer.update = function(dt) {
	var _g = 0;
	var _g1 = zero_utilities_Timer.timers;
	while(_g < _g1.length) _g1[_g++].run(dt);
};
zero_utilities_Timer.prototype = {
	cancel: function() {
		if(HxOverrides.remove(zero_utilities_Timer.timers,this)) {
			zero_utilities_Timer.pool.push(this);
		}
	}
	,run: function(dt) {
		if(this.paused) {
			return;
		}
		this.elapsed += dt;
		if(this.time - this.elapsed > zero_utilities_Timer.epsilon) {
			return;
		}
		this.fn();
		this.elapsed = 0;
		this.repeat--;
		if(this.repeat != 0) {
			return;
		}
		this.cancel();
	}
};
var zero_utilities_Tween = function() {
	this.active = true;
};
zero_utilities_Tween.__name__ = true;
zero_utilities_Tween.get = function(target) {
	var tween = zero_utilities_Tween.pool.shift();
	if(tween == null) {
		tween = new zero_utilities_Tween();
	}
	tween.init(target);
	tween.active = true;
	zero_utilities_Tween.active_tweens.push(tween);
	return tween;
};
zero_utilities_Tween.tween = function(target,duration,properties,options) {
	var t = zero_utilities_Tween.get(target).duration(duration).prop(properties);
	if(options == null) {
		return t;
	}
	if(options.delay != null) {
		t.delay(options.delay);
	}
	if(options.ease != null) {
		t.ease(options.ease);
	}
	if(options.type != null) {
		t.type(options.type);
	}
	if(options.on_complete != null) {
		t.on_complete(options.on_complete);
	}
	return t;
};
zero_utilities_Tween.update = function(dt) {
	var _g = 0;
	var _g1 = zero_utilities_Tween.active_tweens;
	while(_g < _g1.length) _g1[_g++].update_tween(dt);
};
zero_utilities_Tween.prototype = {
	duration: function(time) {
		this.data.duration = time;
		return this;
	}
	,prop: function(properties) {
		var _g = 0;
		var _g1 = Reflect.fields(properties);
		while(_g < _g1.length) {
			var field = _g1[_g];
			++_g;
			var start = Reflect.getProperty(this.data.target,field);
			if(((this.data.target) instanceof Array)) {
				switch(field) {
				case "g":case "y":
					start = this.data.target[1];
					break;
				case "a":case "height":case "w":
					start = this.data.target[3];
					break;
				case "b":case "width":case "z":
					start = this.data.target[2];
					break;
				case "r":case "x":
					start = this.data.target[0];
					break;
				}
			}
			this.data.properties.push({ field : field, start : start == null ? 0 : start, end : Reflect.field(properties,field)});
		}
		return this;
	}
	,from_to: function(field,from,to) {
		this.data.properties.push({ field : field, start : from, end : to});
		return this;
	}
	,ease: function(ease) {
		this.data.ease = ease;
		return this;
	}
	,delay: function(time) {
		this.data.delay = time;
		this.data.delay_ref = time;
		return this;
	}
	,on_complete: function(fn) {
		this.data.on_complete = fn;
		return this;
	}
	,type: function(type) {
		this.data.type = type;
		var tmp;
		switch(type._hx_index) {
		case 1:case 3:
			tmp = true;
			break;
		case 0:case 2:case 4:
			tmp = false;
			break;
		}
		this.reverse = tmp;
		return this;
	}
	,destroy: function() {
		this.data = null;
		HxOverrides.remove(zero_utilities_Tween.active_tweens,this);
		this.active = false;
		zero_utilities_Tween.pool.push(this);
	}
	,init: function(target) {
		this.data = this.get_default_data(target);
		this.period = 0;
		this.reverse = false;
	}
	,get_default_data: function(target) {
		return { target : target, duration : 1, properties : [], ease : function(f) {
			return f;
		}, delay : 0, delay_ref : 0, on_complete : function() {
		}, type : zero_utilities_TweenType.SINGLE_SHOT_FORWARDS};
	}
	,update_tween: function(dt) {
		if(!this.active) {
			return;
		}
		dt = this.update_dt(dt);
		this.update_period(dt);
	}
	,update_dt: function(dt) {
		if(this.data.delay > 0) {
			this.data.delay -= dt;
			if(this.data.delay > 0) {
				return 0;
			}
			dt = -this.data.delay;
		}
		return dt;
	}
	,update_period: function(dt) {
		if(dt == 0) {
			return;
		}
		var d = dt / this.data.duration;
		this.period += this.reverse ? -d : d;
		this.period = Math.max(Math.min(this.period,1),0);
		if(this.period == 0 || this.period == 1) {
			this.complete();
		} else {
			this.apply();
		}
	}
	,complete: function() {
		this.apply();
		this.data.on_complete();
		switch(this.data.type._hx_index) {
		case 0:case 1:
			this.destroy();
			break;
		case 2:case 3:case 4:
			this.reset();
			break;
		}
	}
	,reset: function() {
		if(this.data.type == zero_utilities_TweenType.PING_PONG) {
			this.reverse = !this.reverse;
		}
		this.data.delay = this.data.delay_ref;
		this.period = this.reverse ? 1 : 0;
	}
	,apply: function() {
		if(this.data == null) {
			return;
		}
		var eased_period = this.data.ease(this.period);
		var _g = 0;
		var _g1 = this.data.properties;
		while(_g < _g1.length) {
			var property = _g1[_g];
			++_g;
			var t = eased_period / 1;
			var val = (1 - t) * property.start + t * property.end;
			if(((this.data.target) instanceof Array)) {
				switch(property.field) {
				case "g":case "y":
					this.data.target[1] = val;
					break;
				case "a":case "height":case "w":
					this.data.target[3] = val;
					break;
				case "b":case "width":case "z":
					this.data.target[2] = val;
					break;
				case "r":case "x":
					this.data.target[0] = val;
					break;
				}
			} else {
				Reflect.setProperty(this.data.target,property.field,val);
			}
		}
	}
};
var zero_utilities_TweenType = $hxEnums["zero.utilities.TweenType"] = { __ename__:true,__constructs__:null
	,SINGLE_SHOT_FORWARDS: {_hx_name:"SINGLE_SHOT_FORWARDS",_hx_index:0,__enum__:"zero.utilities.TweenType",toString:$estr}
	,SINGLE_SHOT_BACKWARDS: {_hx_name:"SINGLE_SHOT_BACKWARDS",_hx_index:1,__enum__:"zero.utilities.TweenType",toString:$estr}
	,LOOP_FORWARDS: {_hx_name:"LOOP_FORWARDS",_hx_index:2,__enum__:"zero.utilities.TweenType",toString:$estr}
	,LOOP_BACKWARDS: {_hx_name:"LOOP_BACKWARDS",_hx_index:3,__enum__:"zero.utilities.TweenType",toString:$estr}
	,PING_PONG: {_hx_name:"PING_PONG",_hx_index:4,__enum__:"zero.utilities.TweenType",toString:$estr}
};
zero_utilities_TweenType.__constructs__ = [zero_utilities_TweenType.SINGLE_SHOT_FORWARDS,zero_utilities_TweenType.SINGLE_SHOT_BACKWARDS,zero_utilities_TweenType.LOOP_FORWARDS,zero_utilities_TweenType.LOOP_BACKWARDS,zero_utilities_TweenType.PING_PONG];
if(typeof(performance) != "undefined" ? typeof(performance.now) == "function" : false) {
	HxOverrides.now = performance.now.bind(performance);
}
String.__name__ = true;
Array.__name__ = true;
js_Boot.__toStr = ({ }).toString;
Main.opacity = 1;
Main.offset = 0;
Main.offset_amt = window.innerHeight * 0.333;
Main.scale = 1;
Main.complete = false;
Main.begun = false;
Main.count = 0;
Main.values = [];
zero_utilities_Timer.timers = [];
zero_utilities_Timer.pool = [];
zero_utilities_Timer.epsilon = 1e-8;
zero_utilities_Tween.active_tweens = [];
zero_utilities_Tween.pool = [];
Main.main();
})({});
