import zero.utilities.Timer;
import zero.utilities.Ease;
import zero.utilities.Tween;
import js.html.DivElement;
import js.Browser.document as document;
import js.Browser.window as window;

using zero.extensions.Tools;

class Main {
	
	static var value:DivElement;
	static var opacity:Float = 1;
	static var offset:Float = 0;
	static var offset_amt:Float = window.innerHeight * 0.333;
	static var total_time:Float = 8;
	static var animate_time:Float;
	static var animate_time_min:Float = 0.01;
	static var animate_time_max:Float = 0.75;
	static var scale:Float = 1;
	static var progress:Float = 0;
	static var complete:Bool = false;
	static var begun:Bool = false;

	static function main() {
		values.shuffle();
		animate_time = animate_time_min;
		value = cast document.getElementById('value_container');
		value.onclick = begin;
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
		Tween.get(Main).from_to('animate_time', animate_time_min, animate_time_max).duration(total_time).on_complete(() -> complete = true);
		Tween.get(Main).prop({ opacity: 0, offset: 1, scale: 0.5 })/*.ease(Ease.smoothStepIn)*/.duration(animate_time/2).on_complete(() -> animate());
	}

	static function animate() {
		offset = -1;
		scale = 0.5;
		opacity = 0;
		value.innerText = values[0];
		values.push(values.shift());
		if (complete) {
			Tween.get(Main).prop({ opacity: 1, offset: 0, scale: 1 }).ease(Ease.smoothStepOut).duration(animate_time).on_complete(() -> {
				Timer.get(0.4, () -> value.classList.add('invert'));
			});
			return;
		}
		Tween.get(Main).prop({ opacity: 1, offset: 0, scale: 1 })/*.ease(Ease.smoothStepOut)*/.duration(animate_time/2).on_complete(() -> {
			Tween.get(Main).prop({ opacity: 0, offset: 1, scale: 0.5 })/*.ease(Ease.smoothStepIn)*/.duration(animate_time/2).on_complete(() -> animate());
		});
	}

	static var values = [
		'Etienne Naylor',
		'Zachary Edmonds',
		'Anwen Mccormack',
		'Bronte Parker',
		'Morgan Bauer',
		'Christopher Mcneil',
		'Adam Leon',
		'Anoushka Hartley',
		'Shoaib Oliver',
		'Ruby Lambert',
		'Rahima Chaney',
		'Dua Walters',
		'Kiaan Lutz',
		'Rosemary Coffey',
		'Ifan Bob',
		'Anya Hickman',
		'Sulayman Beil',
		'Kaidan Read',
		'Madihah Lucas',
		'Abdur Brady',
		'Kaylee Leech',
		'Layton Nicholson',
		'Harper-Rose Weir',
		'Alyssa Downs',
		'Torin Bloom',
		'Jorgie Plant',
		'Latisha Moon',
		'Izaac Glover',
		'Dora Piper',
		'Aaliya Kirkland',
		'Lorcan Bains',
		'Nabila Bannister',
		'Zahrah Sparks',
		'Faizan Shea',
		'Keyan Weiss',
		'Heena Chester',
		'Jordanna Montoya',
		'Aleena Decker',
		'Maryam King',
		'Maximus Wiley',
		'Kyle Croft',
		'Brandi Simons',
		'Caitlin Wardle',
		'Hassan Greenwood',
		'Greyson Henry',
		'Ariah Butt',
		'Sadie Marks',
		'Simeon Molina',
		'Margaret North',
		'Cory Rodriguez',
		'Eadie Almond',
		'Sohail Hobbs',
		'Jonty Baxter',
		'Dawson Anderson',
		'Jessie Whitfield',
		'Katerina Cardenas',
		'Sonnie Kavanagh',
		'Shanai Tyson',
		'Ariya Greer',
		'Kane Horton',
		'Andy Cousins',
		'Arooj Henson',
		'Aneesa Doherty',
		'Steven Mayer',
		'Charlotte Morin',
		'Cathy Webster',
		'Miyah Simmonds',
		'Alessandro Lowry',
		'Siddharth Alvarado',
		'Ritchie Ellwood',
		'Lyle Barajas',
		'Johnny Mill',
		'Viola Baird',
		'Aubree Liu',
		'Ananya Galloway',
		'Marion Freeman',
		'Kareena Mathis',
		'Aamna Stokes',
		'Kayleigh Cullen',
		'Ellis Combs',
		'Yuvaan Finley',
		'Harold Walton',
		'Alexis Boyer',
		'Adelaide Kerr',
		'Nicolle Ferguson',
		'Tariq Poole',
		'Eleanor Lozano',
		'Raj Morley',
		'Kianna Mccullough',
		'Carley O\'Neill',
		'Arham Osborne',
		'Brooklyn Cabrera',
		'Freya Clarkson',
		'Anand Shah',
		'Jamie-Lee Rayner',
		'Aimie Moore',
		'Zander Villalobos',
		'Aleyna William',
		'Emilia Riley',
		'Aqib Rankin',
	];

}
