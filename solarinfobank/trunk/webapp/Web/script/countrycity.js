
function Dsy()
{
this.Items = {};
}
Dsy.prototype.add = function(id,iArray)
{
this.Items[id] = iArray;
}
Dsy.prototype.Exists = function(id)
{
if(typeof(this.Items[id]) == "undefined") return false;
return true;
}

function change(v) {
var str="0";
for(i=0;i<v;i++){ str+=("_"+(document.getElementById(s[i]).selectedIndex-1));};
var ss=document.getElementById(s[v]);
with(ss){
length = 0;
options[0]=new Option(opt0[v],opt0[v]);
if(v && document.getElementById(s[v-1]).selectedIndex>0 || !v)
{
if(dsy.Exists(str)){
ar = dsy.Items[str];
for(i=0;i<ar.length;i++)options[length]=new Option(ar[i],ar[i]);
if(v)options[1].selected = true;
}
}
if(++v<s.length){change(v);}
}
}

var dsy = new Dsy();

dsy.add("0", ["中国", "America", "日本", "Deutschland", "United Kingdom", "France", "대한민국", "Россия", "Suomi", "Italian", "Other"]);

dsy.add("0_0", ["北京", "天津", "上海", "广州", "深圳", "香港", "重庆", "宁波", "苏州", "福州", "厦门", "南昌", "台北", "高雄", "澳门", "长沙", "沈阳", "大连", "济南", "青岛", "南京", "杭州", "武汉", "成都", "长春", "西安", "汕头", "珠海", "海口", "南宁", "太原", "郑州", "合肥", "贵阳", "昆明", "拉萨", "兰州", "西宁", "银川", "乌鲁木齐", "呼和浩特", "哈尔滨", "石家庄", "唐山","其他"]);

dsy.add("0_1", ["Alabamas", "Nebraska", "Alaska", "Nevada", "Arizona", "New Hampshire", "Arkansas", "New Jersy", "California", "New Mexico", "Colorado", "New York", "Connecticut", "North Carolina", "Delaware", "North Dakota", "District of Columbia", "Ohio", "Florida", "Oklahoma", "Georgia", "Oregon", "Hawaii", "Pennsylvania", "Idaho", "Puerto Rico", "Illinois", "Rhode Island", "Indiana", "South Carolina", "Iowa", "South Dakota", "Kansas", "Tennessee", "Kentucky", "Texas", "Louisiana", "Utah", "Maine", "Vermont", "Maryland", "Virginia", "Massachusetts", "Virgin Islands", "Michigan", "Washington", "Minnesota", "West Virginia", "Mississippi", "Wisconsin", "Missouri", "Wyoming", "Montana", "Other"]);

dsy.add("0_2", ["東京", "神奈川", "大阪", "横浜", "名古屋", "札幌", "神戸", "京都", "福岡", "カワサキ", "埼玉県", "広島", "仙台", "北九州", "千葉県", "その他"]);

dsy.add("0_3", ["Frankfurt", "Berlin", "Stuttgart", "München", "Köln", "Hannover", "Leipzig", "Dresden", "Weimar","Andere"]);

dsy.add("0_4", ["London", "Birmingham", "Glasgow", "Manchester", "Liverpool", "Cardiff", "Newcastle", "Leicester", "Exeter", "Belfast", "Portsmouth", "Leeds", "Other"]);

dsy.add("0_5", ["Paris", "Dunkerque", "Lille", "Cherbourg", "Rouen", "Nancy", "Brest", "Strasbourg", "Orleans", "Nantes", "Dijon", "Limoges", "Lyon", "Grenoble", "Bordeaux", "Valence", "Toulouse", "Nice", "Perpignan", "Marseille", "Toulon", "Autres"]);

dsy.add("0_6", ["서울", "부산", "대구", "인천", "광주", "대전", "울산", "제주", "안톤", "춘천", "강릉", "경주", "속초","기타"]);

dsy.add("0_7", ["Москва", "Санкт-Петербург", "Владивосток", "Мурманск", "Екатеринбург", "Челябинск", "Магнитогорск", "Новосибирск", "Ленинградская","Другие"]);

dsy.add("0_8", ["Rotterdam", "Amsterdam", "Den Haag", "Zo hoog", "Leiden", "Muut"]);

dsy.add("0_9", ["Arezzo", "Bari", "Brescia", "Catania", "Florence", "Genova", "Milan", "Naples", "Palermo", "Pisa", "Rome","Siena", "Turin", "Venice", "Verona"]);

dsy.add("0_10", ["Other"]);


//dsy.add("0_9",["实皆省 Sagaing","望濑县 Monywa","勃固省 Bago","马圭省 Magway","曼德勒省 Mandalay","德林达依省 Tanintharyi","伊洛瓦底省 Ayeyarwady","仰光省 Yangon","克钦邦 Kachin","克耶邦 Kayah","克伦邦 Kayin","钦邦 Chin","孟邦 Mon","若开邦 Rakhine","掸邦 Shan"]);



//dsy.add("0_10",["巴登-符腾堡 Baden-Württemberg","拜恩（巴伐利亚）  Bayern","柏 林 Berlin","勃兰登堡 Brandenburg","不来梅 Bremen","汉 堡 Hamburg","黑 森 Hessen","梅克伦堡-前波莫瑞 Mecklenburg-Vorpommern","下萨克森  Niedersachsen","北莱茵-威斯特法伦 Nordrhein-Westfalen","莱茵兰-普法尔茨 Rheinland-Pfalz","萨 尔 Saarland","萨克森 Sachsen","萨克森-安哈特 Sachsen-Anhalt","石勒苏益格-荷尔斯泰因 Schleswig-Holstein","图林根 Thüringen"]);




//dsy.add("0_11",["英格兰 England","威尔士 Wales","苏格兰 Scotland","北爱尔兰 Northern Ireland"]);


//dsy.add("0_12",["法兰西岛 Ile-de-France","香槟-阿登 Champagne-Ardenne","皮卡第 Picardie","上诺曼底 Haute-Normandie","中央 Centre","下诺曼底 Basse-Normandie","勃艮第 Bourgogne","北部-加莱海峡 Nord-pas-de-Calais","洛林 Lorraine","阿尔萨斯 Alsace","弗朗什孔泰 Franche-Comté","卢瓦尔河地区 Pays de la Loire","布列塔尼 Bretagne","普瓦图-夏朗德 Poitou-Charentes","阿基坦 Aquitaine","南部-比利牛斯 Midi-Pyrénées","利穆赞 Limousin","罗讷-阿尔卑斯 Rhone-Alpes","奥弗涅 Auvergne","朗格多克-鲁西永 Languedoc-Roussillon","普罗旺斯-阿尔卑斯-蓝色海岸 Provence-Alpes-Cote d'Azur","科西嘉 Corse"]);



//dsy.add("0_13",["穆斯特省 Munster","康诺特省 Connacht","伦斯特省 Leinster","阿尔斯特省 Ulster"]);


//dsy.add("0_14",["下西里西亚 Dolnoslaskie","库亚瓦滨海 Kujawsko-Pomorskie","罗兹 Lódzkie ","卢布林 Lubelskie","鲁布斯卡 Lubuskie","小波兰 Malopolskie","马佐夫舍 Mazowieckie","奥波莱 Opolskie","喀尔巴阡山 Podkarpackie","波德拉斯 Podlaskie","滨海 Pomorskie","西里西亚 Slaskie","圣十字 Swietokrzyskie","瓦尔米亚马祖尔 Warmińsko-Mazurskie","大波兰 Wielkopolskie","西滨海 Zachodniopomorskie"]);


//dsy.add("0_15",["安达卢西亚 Andalucía","阿拉贡 Aragón","阿斯图利亚斯 Asturias","巴利阿里群岛 Baleares","加那利 Canarias","坎塔布利亚 Cantábria","卡斯蒂利亚－拉曼恰 Castilla-La Mancha","卡斯蒂利亚－莱昂 Castilla y Léon","加泰罗尼亚* Cataluna","加利西亚* Galicia","马德里 Madrid"]);

//dsy.add("0_16",["阿布鲁佐 Abruzzi","巴西利卡塔 Basilicata","卡拉布里亚 Calabria","坎帕尼亚 Campania","艾米利亚－罗马涅 Emilia-Romagna","弗留利－威尼斯·朱利亚* Friuli-Venezia Giulia","拉齐奥 Lazio","利古里亚 Liguria","伦巴第 Lombardia","马尔凯 Marche","莫利塞 Molise","皮埃蒙特 Piemonte","普利亚 Puglia","撒丁* Sardegna","西西里* Sicilia","托斯卡纳 Toscana","特伦蒂诺-上阿迪杰* Trentino-Alto Adige","翁布里亚 Umbria","瓦莱·达奥斯塔* Valle d'Aosta","威尼托 Veneto"]);

//dsy.add("0_17", ["西北 Severo-Zapadnyj","中央 Central'nyj ","南方 Juznyj ","伏尔加 Privolzskij ","乌拉尔 Ural'skij","西伯利亚 Sibirskij","远东 Dal'nevostocnij"]);


//dsy.add("0_18", ["德伦特 Drenthe","弗莱福兰 Flevoland","弗里斯兰* Friesland","海尔德兰 Gelderland","格罗宁根 Groningen","林堡 Limburg","北布拉班特 Noord-Brabant","北荷兰 Noord-Holland ","上艾瑟尔 Overijssel","乌得勒支 Utrecht","泽兰 Zeeland","南荷兰 Zuid-Holland"]);



//dsy.add("0_19", ["阿拉巴马 Alabama","阿拉斯加 Alaska","亚利桑那 Arizona","阿肯色 Arkansas","加利福尼亚 California","科罗拉多 Colorado","康涅狄格 Connecticut","特拉华 Delaware","哥伦比亚特区 District of Columbia","佛罗里达 Florida","乔治亚 Georgia","夏威夷 Hawaii","爱达荷 Idaho","伊利诺斯 Illinois","印地安那 Indiana","衣阿华 Iowa","堪萨斯 Kansas","肯塔基 Kentucky","路易斯安那 Louisiana","缅因 Maine","马里兰 Maryland","马萨诸塞 Massachusetts","密歇根 Michigan","明尼苏达 Minnesota","密西西比 Mississippi","密苏里 Missouri","蒙大拿 Montana","内布拉斯加 Nebraska","内华达 Nevada","新罕布什尔 New Hampshire","新泽西 New Jersey","新墨西哥 New Mexico","纽约 New York","犹他 Utah","华盛顿 Washington","威斯康星 Wisconsin"]);


//dsy.add("0_20", ["新不伦瑞克省 New Brunswick","新斯科舍省 Nova Scotia","安大略省 Ontario","魁北克省 Québec","马尼托巴省 Manitoba","不列颠哥伦比亚省 British Columbia","爱德华王子岛省 Prince Edward Island","艾伯塔省 Alberta","萨斯喀彻温省 Saskatchewan","纽芬兰-拉布拉多省 Newfoundland-Labrador","西北地区 Northwest Territories","育空地区 Yukon Territory","努纳维特地区 Nunavut Territory"]);


//dsy.add("0_21", ["联邦首都 Distrito Federal","戈亚斯 Goiás","马托格罗索 Mato Grosso","南马托格罗索 Mato Grosso do Sul","阿拉戈斯 Alagoas","巴伊亚 Bahia","塞阿拉 Ceará","马拉尼昂 Maranhao","帕拉伊巴 Paraíba","伯南布哥 Pernambuco","皮奥伊 Piauí","北里奥格兰德 Rio Grande do Norte","塞尔希培 Sergipe","阿克里 Acre","阿马帕 Amapá","亚马孙 Amazonas","帕拉 Pará","朗多尼亚 Rondonia","罗赖马 Roraima","托坎廷斯 Tocantins","圣埃斯皮里图 Espírito Santo*","米纳斯吉拉斯 Minas Gerais","里约热内卢 Rio de Janeiro","圣保罗 Sao Paulo","巴拉那 Paraná","南里奥格兰德 Rio Grande do Sul**","圣卡塔琳娜 Santa Catarina"]);



//dsy.add("0_22", ["联邦首都 Distrito Federal","布宜诺斯艾利斯 Buenos Aires","卡塔马卡 Catamarca","查科 Chaco","丘布特 Chubut","科尔多瓦  Córdoba","科连特斯 Corrientes","恩特雷里奥斯 Entre Ríos","福莫萨 Formosa","胡胡伊 Jujuy","拉潘帕 La Pampa","拉里奥哈 La Rioja","门多萨　Mendoza","米西奥斯内斯　Misiones","内乌肯　Neuquén","里奥内格罗 Río Negro","萨尔塔　Salta","圣胡安　San Juan","圣路易斯　San Luis","圣克鲁斯　Santa Cruz","圣菲　Santa Fe","圣地亚哥-德尔埃斯特罗 Santiago del Estero","火地岛　Tierra del Fuego","图库曼　Tucumán"]);



//dsy.add("0_23", ["北地 Northland","奥克兰 Auckland","怀卡托 Waikato ","普伦蒂湾 Bay of Plenty","吉斯伯恩 Gisborne (A) ","霍克湾 Hawkes Bay ","玛纳瓦图/旺格努伊 Manawatu-Wanganui ","塔拉那基 Taranaki","惠灵顿 Wellington ","塔斯曼 Tasman (A)","纳尔逊 Nelson (B)","马尔伯勒 Blenheim (A)","西岸 West Coast","坎特伯雷 Canterbury ","奥塔戈 Otago ","南地 Southland"]);

//dsy.add("0_24", ["新南威尔士州 New South Wales","昆士兰州 Queensland","南澳大利亚州 South Australia","塔斯马尼亚州 Tasmania","维多利亚州 Victoria","西澳大利亚州 Western Australia","澳大利亚首都地区 Australian Capital Territory","北部地区 Northern Territory"]);



//dsy.add("0_25", ["查谟和克什米尔* Jammu & Kashmīr","旁遮普 Punjub","昌迪加尔 Chandīgarh","喜马偕尔邦 Himāchal Pradesh","北安查尔 Uttaranchal","哈里亚纳 Haryāna","德里 Delhi","拉贾斯坦 Rājasthān","北方邦 Uttar Pradesh","中央邦 Madhya Pradesh","查蒂斯加尔 Chhatisgarh","比哈尔 Bihār","贾坎德 Jharkhand","锡金 Sikkim","阿鲁那恰尔邦* Arunāchal Pradesh","那加兰 Nāgāland","曼尼普尔 Manipur","米佐拉姆 Mizorām","特里普拉 Tripura","梅加拉亚  Meghālaya","阿萨姆 Assam","西孟加拉邦 West Bengal","奥里萨 Orissa","古吉拉特 Gujarāt","达曼和第乌 Damān & Diu","达德拉和纳加尔哈维利 Dādra & Nagar Haveli","马哈拉施特拉 Mahārāshtra","果阿 Goa","安得拉邦 Andhra Pradesh","卡纳塔克 Karnātaka","拉克沙群岛 Lakshadweep","喀拉拉 Kerala","泰米尔纳德 Tamil Nādu","本地治里 Pondicherry","安达曼和尼科巴群岛 Andaman & Nicobar Islands"]);



//dsy.add("0_26", ["开罗 Al Qahirah","亚历山大 Al Iskandariyah","塞得港 Bur Sa`id","苏伊士 As Suways","卢克索 Al Uqsur","代盖赫利耶 Ad Daqahl?yah","布海拉 Al Buhayrah","西部 Al Gharbiyah","伊斯梅利亚 Al Isma`iliyah","米努夫 Al Minufiyah","盖勒尤卜 Al Qalyubiyah","东部 Ash Sharqiyah","杜姆亚特 Dumyat","谢赫村 Kafr ash Shaykh","吉萨 Al Jizah","明亚 Al Minya","贝尼苏韦夫 Bani Suwayf","法尤姆 Al Fayyum","艾斯尤特 Asyut","阿斯旺 Aswan","索哈杰 Suhaj","基纳 Qina","红海 Al Bahr al Ahmar","新河谷 Al Wadi al Jadid","马特鲁 Matruh","南西奈 Janub Sina","北西奈 Shamal Sina"]);

var s=["s1","s2"];
var opt0 = ["", ""];
function setup()
{
for(i=0;i<s.length-1;i++)
document.getElementById(s[i]).onchange=new Function("change("+(i+1)+")");
change(0);
}
