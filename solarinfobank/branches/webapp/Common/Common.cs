using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    public class Country
    {
        public string Name { get; set; }
        public int Value { get; set; }
        public IList<City> Cities { get; set; }

    }

    public class City
    {
        public string Name { get; set; }
        public int Value { get; set; }
        public string weatherCode { get; set; }
    }


    public static class Common
    {
        static Common()
        {
            //
            #region 中国
            countries.Add(new Country()
            {
                Name = "中国",
                Value = 1,
                Cities = new List<City>(){
                        new City() {  Name="北京", Value=1, weatherCode="0001"},
                        new City() {  Name="天津", Value=2, weatherCode="0001"},
                        new City() {  Name="上海", Value=3, weatherCode="0001"},
                        new City() {  Name="广州", Value=4, weatherCode="0001"},
                        new City() {  Name="深圳", Value=5, weatherCode="0001"},
                        new City() {  Name="香港", Value=6, weatherCode="0001"},
                        new City() {  Name="重庆", Value=7, weatherCode="0001"},
                        new City() {  Name="宁波", Value=8, weatherCode="0001"},
                        new City() {  Name="苏州", Value=9, weatherCode="0001"},
                        new City() {  Name="福州", Value=10, weatherCode="0001"},
                        new City() {  Name="厦门", Value=11, weatherCode="0001"},
                        new City() {  Name="南昌", Value=12, weatherCode="0001"},
                        new City() {  Name="台北", Value=13, weatherCode="0001"},
                        new City() {  Name="高雄", Value=14, weatherCode="0001"},
                        new City() {  Name="澳门", Value=15, weatherCode="0001"},
                        new City() {  Name="长沙", Value=16, weatherCode="0001"},
                        new City() {  Name="沈阳", Value=17, weatherCode="0001"},
                        new City() {  Name="大连", Value=18, weatherCode="0001"},
                        new City() {  Name="济南", Value=19, weatherCode="0001"},
                        new City() {  Name="青岛", Value=20, weatherCode="0001"},
                        new City() {  Name="南京", Value=21, weatherCode="0001"},
                        new City() {  Name="杭州", Value=22, weatherCode="0001"},
                        new City() {  Name="武汉", Value=23, weatherCode="0001"},
                        new City() {  Name="成都", Value=24, weatherCode="0001"},
                        new City() {  Name="长春", Value=25, weatherCode="0001"},
                        new City() {  Name="西安", Value=26, weatherCode="0001"},
                        new City() {  Name="汕头", Value=27, weatherCode="0001"},
                        new City() {  Name="珠海", Value=28, weatherCode="0001"},
                        new City() {  Name="海口", Value=29, weatherCode="0001"},
                        new City() {  Name="南宁", Value=30, weatherCode="0001"},
                        new City() {  Name="太原", Value=31, weatherCode="0001"},
                        new City() {  Name="郑州", Value=32, weatherCode="0001"},
                        new City() {  Name="合肥", Value=33, weatherCode="0001"},
                        new City() {  Name="贵阳", Value=34, weatherCode="0001"},
                        new City() {  Name="昆明", Value=35, weatherCode="0001"},
                        new City() {  Name="拉萨", Value=36, weatherCode="0001"},
                        new City() {  Name="兰州", Value=37, weatherCode="0001"},
                        new City() {  Name="西宁", Value=38, weatherCode="0001"},
                        new City() {  Name="银川", Value=39, weatherCode="0001"},
                        new City() {  Name="乌鲁木齐", Value=40, weatherCode="0001"},
                        new City() {  Name="呼和浩特", Value=41, weatherCode="0001"},
                        new City() {  Name="哈尔滨", Value=42, weatherCode="0001"},
                        new City() {  Name="石家庄", Value=43, weatherCode="0001"},
                        new City() {  Name="唐山", Value=44, weatherCode="0001"}
                    }
            });
            #endregion

            #region 美国
            countries.Add(new Country()
            {
                Name = "America",
                Value = 2,
                Cities = new List<City>(){
                        new City() {  Name="Alabamas", Value=1, weatherCode="0001"},               //阿拉巴马
                        new City() {  Name="Nebraska", Value=2, weatherCode="0001"},               //内布拉斯加
                        new City() {  Name="Alaska", Value=3, weatherCode="0001"},                 //阿拉斯加
                        new City() {  Name="Nevada", Value=4, weatherCode="0001"},                 //内华达
                        new City() {  Name="Arizona", Value=5, weatherCode="0001"},                //亚利桑那
                        new City() {  Name="New Hampshire", Value=6, weatherCode="0001"},          //新罕布什尔 
                        new City() {  Name="Arkansas", Value=7, weatherCode="0001"},               //阿肯色
                        new City() {  Name="New Jersy", Value=8, weatherCode="0001"},              //新泽西
                        new City() {  Name="California", Value=9, weatherCode="0001"},             //加利福尼亚
                        new City() {  Name="New Mexico", Value=10, weatherCode="0001"},            //新墨西哥
                        new City() {  Name="Colorado", Value=11, weatherCode="0001"},              //科罗拉多
                        new City() {  Name="New York", Value=12, weatherCode="0001"},              //纽约
                        new City() {  Name="Connecticut", Value=13, weatherCode="0001"},           //康涅狄格
                        new City() {  Name="North Carolina", Value=14, weatherCode="0001"},        //北卡罗来纳
                        new City() {  Name="Delaware", Value=15, weatherCode="0001"},              //特拉华
                        new City() {  Name="North Dakota", Value=16, weatherCode="0001"},          //北达科他
                        new City() {  Name="District of Columbia", Value=17, weatherCode="0001"},  //哥伦比亚特区
                        new City() {  Name="Ohio", Value=18, weatherCode="0001"},                  //俄亥俄
                        new City() {  Name="Florida", Value=19, weatherCode="0001"},               //佛罗里达
                        new City() {  Name="Oklahoma", Value=20, weatherCode="0001"},              //俄克拉何马
                        new City() {  Name="Georgia", Value=21, weatherCode="0001"},               //佐治亚
                        new City() {  Name="Oregon", Value=22, weatherCode="0001"},                //俄勒冈
                        new City() {  Name="Hawaii", Value=23, weatherCode="0001"},                //夏威夷
                        new City() {  Name="Pennsylvania", Value=24, weatherCode="0001"},          //宾夕法尼亚
                        new City() {  Name="Idaho", Value=25, weatherCode="0001"},                 //爱达荷
                        new City() {  Name="Puerto Rico", Value=26, weatherCode="0001"},           //波多黎各
                        new City() {  Name="Illinois", Value=27, weatherCode="0001"},              //伊利诺斯
                        new City() {  Name="Rhode Island", Value=28, weatherCode="0001"},          //罗德艾兰
                        new City() {  Name="Indiana", Value=29, weatherCode="0001"},               //印第安纳
                        new City() {  Name="South Carolina", Value=30, weatherCode="0001"},        //南卡罗来纳
                        new City() {  Name="Iowa", Value=31, weatherCode="0001"},                  //衣阿华
                        new City() {  Name="South Dakota", Value=32, weatherCode="0001"},          //南达科他
                        new City() {  Name="Kansas", Value=33, weatherCode="0001"},                //堪萨斯
                        new City() {  Name="Tennessee", Value=34, weatherCode="0001"},             //田纳西
                        new City() {  Name="Kentucky", Value=35, weatherCode="0001"},              //肯塔基
                        new City() {  Name="Texas", Value=36, weatherCode="0001"},                 //得克萨斯
                        new City() {  Name="Louisiana", Value=37, weatherCode="0001"},              //路易斯安那
                        new City() {  Name="Utah", Value=38, weatherCode="0001"},                  //尤他
                        new City() {  Name="Maine", Value=39, weatherCode="0001"},                 //缅因
                        new City() {  Name="Vermont", Value=40, weatherCode="0001"},               //佛蒙特
                        new City() {  Name="Maryland", Value=41, weatherCode="0001"},              //马里兰
                        new City() {  Name="Virginia", Value=42, weatherCode="0001"},              //弗吉尼亚
                        new City() {  Name="Massachusetts", Value=43, weatherCode="0001"},         //马萨诸塞
                        new City() {  Name="Virgin Islands", Value=44, weatherCode="0001"},        //维尔京群岛
                        new City() {  Name="Michigan", Value=45, weatherCode="0001"},              //密执安
                        new City() {  Name="Washington", Value=46, weatherCode="0001"},            //华盛顿
                        new City() {  Name="Minnesota", Value=47, weatherCode="0001"},             //明尼苏达
                        new City() {  Name="West Virginia", Value=48, weatherCode="0001"},         //西弗吉尼亚
                        new City() {  Name="Mississippi", Value=49, weatherCode="0001"},           //密西西比
                        new City() {  Name="Wisconsin", Value=50, weatherCode="0001"},             //威斯康星
                        new City() {  Name="Missouri", Value=51, weatherCode="0001"},              //密苏里
                        new City() {  Name="Wyoming", Value=52, weatherCode="0001"},               //怀俄明
                        new City() {  Name="Montana", Value=53, weatherCode="0001"}                //蒙大拿

                    }
            });
            #endregion
            //
            #region 日本
            countries.Add(new Country()
            {
                Name = "日本",
                Value = 3,
                Cities = new List<City>(){
                        new City() {  Name="東京", Value=1, weatherCode="0001"},           //东京
                        new City() {  Name="大阪", Value=2, weatherCode="0001"},           //大阪
                        new City() {  Name="横浜", Value=3, weatherCode="0001"},           //横滨
                        new City() {  Name="名古屋", Value=4, weatherCode="0001"},         //名古屋
                        new City() {  Name="札幌", Value=5, weatherCode="0001"},           //札幌
                        new City() {  Name="神戸", Value=6, weatherCode="0001"},           //神户
                        new City() {  Name="京都", Value=7, weatherCode="0001"},           //京都
                        new City() {  Name="福岡", Value=8, weatherCode="0001"},           //福冈
                        new City() {  Name="カワサキ", Value=9, weatherCode="0001"},       //川崎
                        new City() {  Name="埼玉県", Value=10, weatherCode="0001"},        //崎玉
                        new City() {  Name="広島", Value=11, weatherCode="0001"},          //广岛
                        new City() {  Name="仙台", Value=12, weatherCode="0001"},          //仙台
                        new City() {  Name="北九州", Value=13, weatherCode="0001"},        //北九州
                        new City() {  Name="千葉県", Value=14, weatherCode="0001"}         //千叶
                    }
            });
            #endregion
            //
            #region 韩国
            countries.Add(new Country()
            {
                Name = "대한민국",
                Value = 4,
                Cities = new List<City>(){
                        new City() {  Name="서울", Value=1, weatherCode="0001"},            //汉城 
                        new City() {  Name="부산", Value=2, weatherCode="0001"},            //釜山
                        new City() {  Name="제주", Value=3, weatherCode="0001"},            //济州
                        new City() {  Name="안톤", Value=4, weatherCode="0001"},            //安东 
                        new City() {  Name="춘천", Value=5, weatherCode="0001"},            //春川
                        new City() {  Name="강릉", Value=6, weatherCode="0001"},            //江陵
                        new City() {  Name="경주", Value=7, weatherCode="0001"},            //庆州
                        new City() {  Name="Statewide", Value=8, weatherCode="0001"},       //全州
                        new City() {  Name="속초", Value=9, weatherCode="0001"}             //束草
                    }
            });
            #endregion
            //
            #region 英国
            countries.Add(new Country()
            {
                Name = "United Kingdom",
                Value = 4,
                Cities = new List<City>(){
                        new City() {  Name="London", Value=1, weatherCode="0001"},             //伦敦 
                        new City() {  Name="Birmingham", Value=2, weatherCode="0001"},         //伯明翰
                        new City() {  Name="Glasgow", Value=3, weatherCode="0001"},            //格拉斯哥
                        new City() {  Name="Manchester", Value=4, weatherCode="0001"},         //曼彻斯特
                        new City() {  Name="Liverpool", Value=5, weatherCode="0001"},          //利物浦
                        new City() {  Name="Cardiff", Value=6, weatherCode="0001"},            //加的夫
                        new City() {  Name="Newcastle", Value=7, weatherCode="0001"},          //纽卡斯尔
                        new City() {  Name="Leicester", Value=8, weatherCode="0001"},          //莱斯特
                        new City() {  Name="Exeter", Value=9, weatherCode="0001"},             //埃克塞特
                        new City() {  Name="Belfast", Value=10, weatherCode="0001"},            //贝尔法斯特
                        new City() {  Name="Portsmouth", Value=11, weatherCode="0001"},         //朴次茅斯
                        new City() {  Name="Leeds", Value=12, weatherCode="0001"}               //利兹
                    }
            });
            #endregion
            //
            #region 法国
            countries.Add(new Country()
            {
                Name = "France",
                Value = 4,
                Cities = new List<City>(){
                        new City() {  Name="Paris", Value=1, weatherCode="0001"},             //巴黎 
                        new City() {  Name="Dunkerque", Value=2, weatherCode="0001"},         //敦刻尔克
                        new City() {  Name="Lille", Value=3, weatherCode="0001"},             //里尔
                        new City() {  Name="Cherbourg", Value=4, weatherCode="0001"},         //瑟堡
                        new City() {  Name="Rouen", Value=5, weatherCode="0001"},             //鲁昂
                        new City() {  Name="Nancy", Value=6, weatherCode="0001"},             //兰斯
                        new City() {  Name="Brest", Value=7, weatherCode="0001"},             //布雷斯特
                        new City() {  Name="Strasbourg", Value=8, weatherCode="0001"},        //斯特拉斯堡
                        new City() {  Name="Orleans", Value=9, weatherCode="0001"},           //奥尔良
                        new City() {  Name="Nantes", Value=10, weatherCode="0001"},           //南特
                        new City() {  Name="Dijon", Value=11, weatherCode="0001"},            //第戎
                        new City() {  Name="Limoges", Value=12, weatherCode="0001"},          //里摩日
                        new City() {  Name="Lyon", Value=13, weatherCode="0001"},             //里昂
                        new City() {  Name="Grenoble", Value=14, weatherCode="0001"},         //格勒诺布尔
                        new City() {  Name="Bordeaux", Value=15, weatherCode="0001"},         //波尔多
                        new City() {  Name="Valence", Value=16, weatherCode="0001"},          //瓦朗斯
                        new City() {  Name="Toulouse", Value=17, weatherCode="0001"},         //图卢兹
                        new City() {  Name="Nice", Value=18, weatherCode="0001"},             //尼斯
                        new City() {  Name="Perpignan", Value=19, weatherCode="0001"},        //佩皮尼昂
                        new City() {  Name="Marseille", Value=20, weatherCode="0001"},        //马赛
                        new City() {  Name="Toulon", Value=21, weatherCode="0001"}            //土伦
                    }
            });
            #endregion
            //
            #region 德国
            countries.Add(new Country()
            {
                Name = "Deutschland",
                Value = 4,
                Cities = new List<City>(){
                        new City() {  Name="Frankfurt", Value=1, weatherCode="0001"},        //法兰克福 
                        new City() {  Name="Berlin", Value=2, weatherCode="0001"},           //柏林
                        new City() {  Name="Stuttgart", Value=3, weatherCode="0001"},        //斯图加特
                        new City() {  Name="München", Value=4, weatherCode="0001"},          //慕尼黑
                        new City() {  Name="Köln", Value=5, weatherCode="0001"},             //科隆
                        new City() {  Name="Hannover", Value=6, weatherCode="0001"},         //汉诺威
                        new City() {  Name="Leipzig", Value=7, weatherCode="0001"},          //莱比锡
                        new City() {  Name="Dresden", Value=8, weatherCode="0001"},          //德雷斯顿
                        new City() {  Name="Weimar", Value=9, weatherCode="0001"}            //魏玛
                    }
            });
            #endregion
            //
            #region 俄国
            countries.Add(new Country()
            {
                Name = "Россия",
                Value = 4,
                Cities = new List<City>(){
                        new City() {  Name="Москва", Value=1, weatherCode="0001"},                     //莫斯科
                        new City() {  Name="Санкт-Петербург", Value=2, weatherCode="0001"},    //圣彼得堡
                        new City() {  Name="Владивосток", Value=3, weatherCode="0001"},           //海参威
                        new City() {  Name="Мурманск", Value=4, weatherCode="0001"},                 //摩尔曼斯克
                        new City() {  Name="Екатеринбург", Value=5, weatherCode="0001"},         //叶卡捷琳堡
                        new City() {  Name="Челябинск", Value=6, weatherCode="0001"},               //车里雅宾斯克
                        new City() {  Name="Магнитогорск", Value=7, weatherCode="0001"},         //马格尼托哥尔斯克
                        new City() {  Name="Новосибирск", Value=8, weatherCode="0001"},           //新西伯利亚
                        new City() {  Name="Ленинградская", Value=9, weatherCode="0001"}        //列宁格勒
                    }
            });
            #endregion
            //
            #region 芬兰
            countries.Add(new Country()
            {
                Name = "Suomi",
                Value = 4,
                Cities = new List<City>(){
                        new City() {  Name="Rotterdam", Value=1, weatherCode="0001"},        //鹿特丹
                        new City() {  Name="Amsterdam", Value=2, weatherCode="0001"},        //阿姆斯特丹
                        new City() {  Name="Den Haag", Value=3, weatherCode="0001"},         //海牙
                        new City() {  Name="Zo hoog", Value=4, weatherCode="0001"},          //豪达
                        new City() {  Name="Leiden", Value=5, weatherCode="0001"}            //莱顿
                    }
            });
            #endregion
        }

        static IList<Country> countries = new List<Country>();
        public static IList<Country> Countries
        {
            get
            {
                return countries;
            }
        }
    }
}
