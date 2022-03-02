import js.html.XMLHttpRequest;
import haxe.zip.Entry;
import zero.utilities.Timer;
import zero.utilities.Ease;
import zero.utilities.Tween;
import js.html.DivElement;
import js.Browser.document as document;
import js.Browser.window as window;

using zero.extensions.Tools;
using Std;

class Main {
	
	static var value:DivElement;
	static var opacity:Float = 1;
	static var offset:Float = 0;
	static var offset_amt:Float = window.innerHeight * 0.333;
	static var animate_time:Float;
	static var scale:Float = 1;
	static var progress:Float = 0;
	static var complete:Bool = false;
	static var begun:Bool = false;
	static var settings:Settings;
	static var count:Int = 0;

	static function main() {
		load_settings();
	}

	static function load_settings() {
		var req = new XMLHttpRequest();
		req.open('GET', 'settings.json');
		req.onload = () -> {
			settings = req.responseText.parse_json();
			load_list();
		}
		req.send();
	}
	
	static function load_list() {
		var req = new XMLHttpRequest();
		req.open('GET', 'list.txt');
		req.onload = () -> {
			values = parse_list(req.response);
			if (settings.shuffle) values.shuffle();
			animate_time = settings.animate_time_min;
			value = cast document.getElementById('value_container');
			value.onclick = begin;
		}
		req.send();
	}	

	static var last:Float;
	static function update(time:Float) {
		if (last == null) last = time;
		var dt = (time - last)/1000;
		Tween.update(dt);
		Timer.update(dt);
		last = time;
		value.style.opacity = '$opacity';
		value.style.marginTop = '${offset * offset_amt}';
		value.style.transform = 'scaleY($scale)';
		window.requestAnimationFrame(update);
	}

	static function begin() {
		if (begun) return;
		begun = true;
		window.requestAnimationFrame(update);
		var total_time = settings.spin_time;
		if (settings.show_every_list_item) {
			var time = 0.0;
			for (i in 0...values.length) {
				time += Ease.linear(i/values.length).lerp(settings.animate_time_min/2, settings.animate_time_max/2);
			}
			total_time = time;
		}
		Tween.get(Main).from_to('animate_time', settings.animate_time_min, settings.animate_time_max).duration(total_time).on_complete(() -> complete = true);
		Tween.tween(Main, animate_time/2, { opacity: 0, offset: 1, scale: 0.5 }, { on_complete: animate });
	}

	static function animate() {
		offset = -1;
		scale = 0.5;
		opacity = 0;
		value.innerText = values[0];
		values.push(values.shift());
		count++;
		var is_complete = complete;
		if (settings.show_every_list_item) is_complete = is_complete && count >= values.length;
		if (is_complete) {
			Tween.tween(Main, animate_time, { opacity: 1, offset: 0, scale: 1 }, { ease: Ease.smoothStepOut, on_complete: () -> {
				Timer.get(0.4, () -> value.classList.add('invert'));
			}});
			return;
		}
		Tween.tween(Main, animate_time/2, { opacity: 1, offset: 0, scale: 1 }, { on_complete: () -> {
			Tween.tween(Main, animate_time/2, { opacity: 0, offset: 1, scale: 0.5 }, { on_complete: animate });
		}});
	}

	static function parse_list(s:String) {
		var out:Array<String> = [];
		for (entry in s.split('\n')) out.push(entry);
		return out;
	}

	static var values = [];

}

typedef Settings = {
	shuffle:Bool,
	show_every_list_item:Bool,
	animate_time_min:Float,
	animate_time_max:Float,
	spin_time:Float,
}
