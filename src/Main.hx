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
	static var total_time:Float = 8;
	static var animate_time:Float;
	static var animate_time_min:Float = 0.01;
	static var animate_time_max:Float = 0.6;
	static var scale:Float = 1;
	static var progress:Float = 0;
	static var complete:Bool = false;
	static var begun:Bool = false;

	static function main() {
		values = parse_list('_heymarjtheplantlady	138
		_theplantmom	25
		adayinmyleaf	1
		alicia_bish_40	1
		beleaf.it.or.knot	22
		beth_tessla	53
		bethplantastic	18
		bobatease	14
		bridgees	3
		butterfly25059	5
		clyo.d	2
		crazi_colaizzi	9
		dailyplantita	34
		family.plants.faith.love	26
		gettingplantywithit	1
		glassyjelly	2
		grinandgrow	1
		happy_plantlife	1
		iheart_succies	19
		in_the_nodes	17
		iz_sandraaa	2
		jayy.plants	5
		jennarously.botanical	4
		jojosbizarreplantadventures	14
		juniesfoliage	1
		ladylambdasgarden	3
		lblumsa_botanica	4
		leafishliving	5
		lesxliej__	12
		lillillipop	2
		mandalizia	17
		melissa_feng	10
		mjajpa_maryjane	5
		mrgreenlovesplants	8
		nogreenthumbs	27
		patuloy.na.sumulong	1
		plant.mutti	1
		plant_babess	19
		plantaverse2	4
		plantdadee	10
		planting.seeds.nursery	1
		plantlyxox	1
		plantmommy_	74
		plantsmom.Arkansas	4
		plantswithlia	13
		planty.things.with.nessa	6
		planty_babies	2
		propagation_moomoo	337
		queen.bee.luvs.succies	34
		sleepinfpikachu	4
		soufrieres.garden	6
		succielover	66
		succulent.mom	19
		swizzyplants	28
		thejungleswoof	7
		theplantgemini	8
		thepropagationpapi	3
		thirstyassplants	17
		thrivebotanical	6
		vaidas444	6
		vwliz	29
		w1chyyplants	10
		weirdlittlewildflower	10
		wokeandwitchy	1
		xclusvlstudio	33').shuffle();
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

	static function parse_list(s:String) {
		var out:Array<String> = [];
		for (entry in s.split('\n')) {
			var data = entry.split('\t');
			var votes = data.pop().parseInt();
			var name = data.pop();
			for (i in 0...votes) out.push('@$name');
		}
		return out;
	}

	static var values = [
		'@wonderplantart',
		'@wonderplantart',
		'@wonderplantart',
		'@wonderplantart',
		'@wonderplantart',
		'@wonderplantart',
		'@wonderplantart',
		'@wonderplantart',
		'@thewonderingplants',
		'@thewonderingplants',
		'@thewonderingplants',
		'@thewonderingplants',
		'@thewonderingplants',
		'@thewonderingplants',
		'@thewonderingplants',
		'@thewonderingplants',
		'@thewonderingplants',
		'@thewonderingplants',
		'@thewonderingplants',
		'@thewonderingplants',
		'@thewonderingplants',
		'@thewonderingplants',
		'@thewonderingplants',
		'@thewonderingplants',
		'@plant.obsessed.jess',
		'@plant.obsessed.jess',
		'@plant.obsessed.jess',
		'@plant.obsessed.jess',
		'@plant.obsessed.jess',
		'@plant.obsessed.jess',
		'@plant.obsessed.jess',
		'@sage.hate.then.propagate',
		'@sage.hate.then.propagate',
		'@sage.hate.then.propagate',
		'@sage.hate.then.propagate',
		'@sage.hate.then.propagate',
		'@sage.hate.then.propagate',
		'@predilection_4_plants',
		'@predilection_4_plants',
		'@predilection_4_plants',
		'@predilection_4_plants',
		'@predilection_4_plants',
		'@predilection_4_plants',
		'@predilection_4_plants',
		'@ceeplants',
		'@ceeplants',
		'@ceeplants',
		'@ceeplants',
		'@ceeplants',
		'@ceeplants',
		'@ceeplants',
		'@ceeplants',
		'@ceeplants',
		'@ceeplants',
		'@firmlyrootd',
		'@firmlyrootd',
		'@firmlyrootd',
		'@firmlyrootd',
		'@firmlyrootd',
		'@firmlyrootd',
		'@firmlyrootd',
		'@firmlyrootd',
		'@Coyote flowers_94',
		'@Coyote flowers_94',
		'@Coyote flowers_94',
		'@Coyote flowers_94',
		'@Coyote flowers_94',
		'@Coyote flowers_94',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@Princessdaudier',
		'@plantcarelife',
		'@plantcarelife',
		'@plantcarelife',
		'@plantcarelife',
		'@plantcarelife',
		'@plantcarelife',
		'@plantcarelife',
		'@plantcarelife',
		'@plantcarelife',
		'@plantcarelife',
		'@plantcarelife',
		'@plantcarelife',
		'@plantcarelife',
		'@plantcarelife',
		'@plantcarelife',
		'@plantcarelife',
		'@plantcarelife',
		'@paulapotsandplants',
		'@paulapotsandplants',
		'@paulapotsandplants',
		'@paulapotsandplants',
		'@paulapotsandplants',
		'@paulapotsandplants',
		'@marijuanamountainmama',
		'@marijuanamountainmama',
		'@marijuanamountainmama',
		'@marijuanamountainmama',
		'@marijuanamountainmama',
		'@marijuanamountainmama',
		'@marijuanamountainmama',
		'@marijuanamountainmama',
		'@countryroadsgreenery',
		'@countryroadsgreenery',
		'@countryroadsgreenery',
		'@countryroadsgreenery',
		'@countryroadsgreenery',
		'@countryroadsgreenery',
		'@sweehomeinthedesert',
		'@sweehomeinthedesert',
		'@sweehomeinthedesert',
		'@sweehomeinthedesert',
		'@sweehomeinthedesert',
		'@sweehomeinthedesert',
		'@sleazienicks',
		'@sleazienicks',
		'@sleazienicks',
		'@sleazienicks',
		'@sleazienicks',
		'@sleazienicks',
		'@sleazienicks',
		'@Bootsrootandhorti',
		'@Bootsrootandhorti',
		'@Bootsrootandhorti',
		'@Bootsrootandhorti',
		'@Bootsrootandhorti',
		'@Bootsrootandhorti',
		'@lydiasleaves',
		'@lydiasleaves',
		'@lydiasleaves',
		'@lydiasleaves',
		'@lydiasleaves',
		'@lydiasleaves',
		'@lydiasleaves',
		'@lydiasleaves',
		'@lydiasleaves',
		'@lydiasleaves',
		'@lydiasleaves',
		'@lydiasleaves',
		'@lydiasleaves',
		'@katiewoodpc',
		'@katiewoodpc',
		'@katiewoodpc',
		'@katiewoodpc',
		'@katiewoodpc',
		'@katiewoodpc',
		'@katiewoodpc',
		'@katiewoodpc',
		'@theurbanplantdiaries',
		'@theurbanplantdiaries',
		'@theurbanplantdiaries',
		'@theurbanplantdiaries',
		'@theurbanplantdiaries',
		'@theurbanplantdiaries',
		'@succulent.heart',
		'@succulent.heart',
		'@succulent.heart',
		'@succulent.heart',
		'@succulent.heart',
		'@succulent.heart',
		'@succulent.heart',
		'@succulent.heart',
		'@succulent.heart',
		'@succulent.heart',
		'@garden.state.plant.mom',
		'@garden.state.plant.mom',
		'@garden.state.plant.mom',
		'@garden.state.plant.mom',
		'@garden.state.plant.mom',
		'@garden.state.plant.mom',
		'@garden.state.plant.mom',
		'@garden.state.plant.mom',
		'@garden.state.plant.mom',
		'@handcraftedshots',
		'@handcraftedshots',
		'@handcraftedshots',
		'@handcraftedshots',
		'@handcraftedshots',
		'@handcraftedshots',
		'@handcraftedshots',
		'@handcraftedshots',
		'@handcraftedshots',
		'@handcraftedshots',
		'@handcraftedshots',
		'@handcraftedshots',
		'@handcraftedshots',
		'@handcraftedshots',
		'@handcraftedshots',
		'@handcraftedshots',
		'@pinayinay916',
		'@pinayinay916',
		'@pinayinay916',
		'@pinayinay916',
		'@pinayinay916',
		'@pinayinay916',
		'@pinayinay916',
		'@pinayinay916',
		'@pinayinay916',
		'@pinayinay916',
		'@pinayinay916',
		'@pinayinay916',
		'@pinayinay916',
		'@pinayinay916',
		'@pinayinay916',
		'@bethplantastics',
		'@bethplantastics',
		'@bethplantastics',
		'@bethplantastics',
		'@bethplantastics',
		'@bethplantastics',
		'@bethplantastics',
		'@bethplantastics',
		'@bethplantastics',
		'@bethplantastics',
		'@bethplantastics',
		'@bethplantastics',
		'@tinas_plantyplants__',
		'@tinas_plantyplants__',
		'@tinas_plantyplants__',
		'@tinas_plantyplants__',
		'@tinas_plantyplants__',
		'@tinas_plantyplants__',
		'@dragons_of_insta',
		'@dragons_of_insta',
		'@dragons_of_insta',
		'@dragons_of_insta',
		'@dragons_of_insta',
		'@dragons_of_insta',
		'@kt_chickens',
		'@kt_chickens',
		'@kt_chickens',
		'@kt_chickens',
		'@kt_chickens',
		'@kt_chickens',
		'@plantsuccs',
		'@plantsuccs',
		'@plantsuccs',
		'@plantsuccs',
		'@plantsuccs',
		'@plantsuccs',
		'@plantsuccs',
		'@plantsuccs',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@raisingplantsandbadkids',
		'@seedsrootssprouts',
		'@seedsrootssprouts',
		'@seedsrootssprouts',
		'@seedsrootssprouts',
		'@seedsrootssprouts',
		'@seedsrootssprouts',
		'@seedsrootssprouts',
		'@plantsrcoolnstuff',
		'@plantsrcoolnstuff',
		'@plantsrcoolnstuff',
		'@plantsrcoolnstuff',
		'@plantsrcoolnstuff',
		'@plantsrcoolnstuff',
		'@plantsrcoolnstuff',
		'@alys_ivy',
		'@alys_ivy',
		'@alys_ivy',
		'@alys_ivy',
		'@alys_ivy',
		'@alys_ivy',
		'@alys_ivy',
		'@alys_ivy',
		'@crazyplantmom22',
		'@crazyplantmom22',
		'@crazyplantmom22',
		'@crazyplantmom22',
		'@crazyplantmom22',
		'@crazyplantmom22',
		'@crazyplantmom22',
		'@adhalia.avalon',
		'@adhalia.avalon',
		'@adhalia.avalon',
		'@adhalia.avalon',
		'@adhalia.avalon',
		'@adhalia.avalon',
		'@vive_con_plants',
		'@vive_con_plants',
		'@vive_con_plants',
		'@vive_con_plants',
		'@vive_con_plants',
		'@vive_con_plants',
		'@vive_con_plants',
		'@vive_con_plants',
		'@vive_con_plants',
		'@vive_con_plants',
		'@vive_con_plants',
		'@vive_con_plants',
		'@vive_con_plants',
		'@vive_con_plants',
		'@vive_con_plants',
		'@vive_con_plants',
		'@vive_con_plants',
		'@vive_con_plants',
		'@vive_con_plants',
		'@vive_con_plants',
		'@sketti_sketti',
		'@sketti_sketti',
		'@sketti_sketti',
		'@sketti_sketti',
		'@sketti_sketti',
		'@sketti_sketti',
		'@sketti_sketti',
		'@sketti_sketti',
		'@sketti_sketti',
		'@vy.is.me',
		'@vy.is.me',
		'@vy.is.me',
		'@vy.is.me',
		'@vy.is.me',
		'@vy.is.me',
		'@vy.is.me',
		'@vy.is.me',
		'@vy.is.me',
		'@prestonmann19',
		'@prestonmann19',
		'@prestonmann19',
		'@prestonmann19',
		'@prestonmann19',
		'@prestonmann19',
		'@prestonmann19',
		'@prestonmann19',
		'@prestonmann19',
		'@prestonmann19',
		'@prestonmann19',
		'@prestonmann19',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@trish_trann',
		'@otherlovings',
		'@otherlovings',
		'@otherlovings',
		'@otherlovings',
		'@otherlovings',
		'@otherlovings',
		'@otherlovings',
		'@otherlovings',
		'@otherlovings',
		'@otherlovings',
		'@carolyncarter_116',
		'@carolyncarter_116',
		'@carolyncarter_116',
		'@carolyncarter_116',
		'@carolyncarter_116',
		'@carolyncarter_116',
		'@lalafreshpots',
		'@lalafreshpots',
		'@klowexoxo',
		'@klowexoxo',
		'@klowexoxo',
		'@klowexoxo',
		'@klowexoxo',
		'@klowexoxo',
		'@motopatiolady',
		'@motopatiolady',
		'@motopatiolady',
		'@motopatiolady',
		'@motopatiolady',
		'@motopatiolady',
		'@motopatiolady',
		'@motopatiolady',
		'@motopatiolady',
		'@plantingzen',
		'@weirdlittlewildflower',
		'@weirdlittlewildflower',
		'@weirdlittlewildflower',
		'@weirdlittlewildflower',
		'@weirdlittlewildflower',
		'@weirdlittlewildflower',
		'@weirdlittlewildflower',
		'@weirdlittlewildflower',
		'@staci.succulents',
		'@staci.succulents',
		'@gabrielas.photography',
		'@ribbons.and.knots',
		'@heylo_plants',
		'@succylove86',
		'@plant_addict_annonymous',
		'@plant_addict_annonymous',
		'@plant_addict_annonymous',
		'@plant_addict_annonymous',
		'@plant_addict_annonymous',
		'@watcha_growin',
		'@miniplantopia',
		'@opalowyy',
		'@jasminecaldwell',
		'@jasminecaldwell',
		'@roomwithry',
		'@fin_the_figgy',
		'@fin_the_figgy',
		'@mary.elizabeth.z',
		'@mary.elizabeth.z',
		'@mary.elizabeth.z',
		'@mary.elizabeth.z',
		'@lilychuutaro',
		'@lilychuutaro',
		'@craleigh',
		'@lynnlees2020',
		'@alihark21',
		'@alihark21',
		'@alihark21',
		'@alihark21',
		'@jillge',
		'@gotplants88',
		'@gotplants88',
		'@itsjustme2wice',
		'@itsjustme2wice',
		'@jessycac',
		'@4tlynn',
		'@4tlynn',
		'@4tlynn',
		'@4tlynn',
		'@holyschnauzzers',
		'@npersac',
		'@npersac',
		'@npersac',
		'@npersac',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@propagation_moomoo',
		'@raelunamoth',
	];

}
