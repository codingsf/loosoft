   M S B A M L   `   `   `  ����   sungrow_demo    sungrow_demo.Main   W SPresentationCore, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35^ ZWindowsFormsIntegration, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     8x,http://schemas.microsoft.com/winfx/2006/xaml    >d2http://schemas.microsoft.com/expression/blend/2008    Hmc;http://schemas.openxmlformats.org/markup-compatibility/2006    -   $��WelcomeWindow��  � Title$  多电站演示系统�� � AllowsTransparency .  � WindowStyle$
 None=� � WindowStartupLocation$ CenterScreen=�$
��1052��$	��615��.��� -   $��contentContainer������  �� ImageSource$4 ./sungrow_demo;component/images/main/suc_bg.jpg��.+��� -   $��tbxUserName��$��16��$
��Left=�$��553,96,0,455q�$��Center=�$	��117��$��12(�$��0q�$�� ���� -   $��imgClose��$��21��$
��Left=�$��
1004,2,0,0q�$
��Fill=�$	��Top=�$��24��$5��//sungrow_demo;component/images/main/suc_big.png���� -   $��imgSmall��$��21��$
��Left=�$��	974,2,0,0q�$4��./sungrow_demo;component/images/main/suc_sm.png��$
��Fill=�$	��Top=�$��24���� -   $��
tbxUserPwd��$��0q�$��12(�$��16��$
��Left=�$��730,96,0,455q�$��Center=�$	��117��$�� ���� -   $��btnGetPlants��$��22��$
��Left=�$��850,117,0,0q�$	��Top=�$��64��$��0q�.���� $6��0/sungrow_demo;component/images/main/suc_bu02.png��$��64��$��22��$��	-3,-3,0,0q��� -   $��btnSave��$��23��$
��Left=�$��927,117,0,0q�$	��Top=�$��65��$��0q�.���� $6��0/sungrow_demo;component/images/main/suc_bu01.png��$��64��$��22��$��	-3,-3,0,0q��� -	   $��btnStart��$��23��$��65��$��
39,550,0,0q�$
��Left=�$	��Top=�$��0q�.���� $6��0/sungrow_demo;component/images/main/suc_bu03.png��$��64��$��22��$��	-3,-3,0,0q��� -
   $��
btnReStart�� �� Left$ 92��
 �� Top$	 340��$��23��$��65��$��122,550,844,0q�$
��Left=�$	��Top=�$��0q�.���� $6��0/sungrow_demo;component/images/main/suc_bu04.png��$��64��$��22��$��	-3,-3,0,0q��� -   $��btnClose��$	 170��$	 340��$��23��$��65��$��204,550,0,0q�$
��Left=�$	��Top=�$��0q�.���� $6��0/sungrow_demo;component/images/main/suc_bu05.png��$��64��$��22��$��	-3,-3,0,0q��� -    ��Name$ 
plantsList��$��29,182,2,62q��� -   $��imgPlant��$��28��$
��Left=�$��
39,112,0,0q�$
��Fill=�$	��Top=�$	��102��$7��1/sungrow_demo;component/images/main/suc_tab01.png���� -   $��	imgGrobal��$��28��$
��Left=�$��142,112,0,0q�$7��1/sungrow_demo;component/images/main/suc_tab04.png��$
��Fill=�$	��Top=�$	��102���� -   $ grolbaConfig��$��42,101,0,64q�$y�Hidden=�.+��� -   $��label1��$ 50��$	 180��   MainPageMainCount#���   $��28���� -   $��label11��$	 241��$	 180��$	��(s)��$��28���� -   $��tbxmainpageinterval��$	 134��$	 182��$��20��$	��110��$��0q�.������ $6 0/sungrow_demo;component/images/main/suc_sy02.png��.���� -   $��label3��$ 98��$ 84��  MainPageHeight#���  $��28���� -   $��label31��$	 241��$ 84��$
��(km)��$��28���� -   $��	tbxheight��$	 134��$ 87��$��20��$	��110��$��0q�.������ $6 0/sungrow_demo;component/images/main/suc_sy02.png��.���� -   $��label6��$ 52��$	 113��  MainPageTipsCount#���  $��28���� -   $��label61��$	 241��$	 113��$	��(s)��$��28���� -   $��tbxtipsinterval��$	 134��$	 117��$��20��$	��110��$��0q�.������ $6 0/sungrow_demo;component/images/main/suc_sy02.png��.���� -   $��label7��$ 16��$	 145��  MainPageDetailCount#���  $��28���� -   $��label71��$	 241��$	 145��$	��(s)��$��28���� -   $��tbxdetailinterval��$	 134��$	 150��$��20��$	��110��$��0q�.������ $6 0/sungrow_demo;component/images/main/suc_sy02.png��.���� -   $��label2��$ 70��$	 301��  MainPageBankUrl#���  $��28���� -   $��
tboxDomain��$��0q�$	 134��$	 305��$��20��$	��250��.������ $6 0/sungrow_demo;component/images/main/suc_sy03.png��.���� -   $��labelSysname��$ 70��$	 332��  MainPageSysName#���  $��28���� -   $��tboxSysname��$��0q�$	 134��$	 336��$��20��$	��350��.������ $6 0/sungrow_demo;component/images/main/suc_sy03.png��.���� -    $��label4��$ 71��$	 272��  MainPageCounterType#���  $��28���� -!   $��cbxCounterType��$	 133��$	 274��$��23��$	��120��$ �� IsSynchronizedWithCurrentItem$
 TrueY�.@��� $��当前用户��	 �� 
IsSelected	 . �� $��系统���� -"   $��label5��$ 54��$	 210��  MainPageIncomeRate#���  $��28���� -#   $��
incomeRate��$��0q�$	 134��$	 212��$��20��$	��110��.������ $6 0/sungrow_demo;component/images/main/suc_sy02.png��.���� -$   $��label8��$ 72��$	 239��  MainPageIncomeUnit#���  $��28���� -%   $��cbxCurrencyType��$	 134��$	 241��$��23��$
 TrueY�$	��120��.@��� $��	人民币��	 . �� $��美元���� $��卢布���� $��韩元���� $��欧元���� $��英镑��� -&   $��displayItems��$	 533��$ 65��$	��108��$	��395��.+��� -'   $��	cbxPlants��$��电站数量��$��16��$
��Left=�$��	44,25,0,0q�$	��Top=��� -(   $��cbxTodayEnergy��$��今日发电��$��16��$
��Left=�$��	44,55,0,0q�$	��Top=��� -)   $��cbxTotalEnergy��$��累计发电��$��16��$
��Left=�$��	44,85,0,0q�$	��Top=��� -*   $��cbxTodayPower��$��今日功率��$��16��$
��Left=�$��
157,25,0,0q�$	��Top=��� -+   $��cbxTotalDesignPower��$��累计装机容量��$��16��$
��Left=�$��
157,55,0,0q�$	��Top=��� -,   $��cbxTotalTrees��$��累计等效树木��$��16��$
��Left=�$��
157,85,0,0q�$	��Top=��� --   $��label9��$	 462��$ 66�� 	 MainPageItemsList#��� 	 $��28��$	��109��� -.   $��displayPages��$	 533��$	 182��$��38��$	��395��.+��� -/   $��cboxPagePowerChart��$��功率图表页面��$��16��$
��Left=�$��	44,10,0,0q�$	��Top=��� -0   $��cboxPageWeekEnergyChart��$��发电量周图表��$��16��$
��Left=�$��
157,10,0,0q�$	��Top=��� -1   $��cboxPageMonthEnergyChart��$��发电量月图表��$��16��$
��Left=�$��	296,9,0,0q�$	��Top=��� -2   $��label10�� 
 MainPagePlantItems#��� 
 $	 462��$	 164��$	��109���� -3   $��label12��$ 68��$	 368��$��语言设置��$��28���� -4   $��cbxMasterLanguage��$��23��$	��120��$	 134��$	 368���� -5   $��cbxLanguage��$	 269��$	 368��$��23��$	��120���� -6   $��label13��$	 525��$	 305��$��	欢迎词��$��28���� -7   $��tboxhyc��$	 577��$	 302��$��94��$	��351��
 �� MinLines$
 1�� �� TextWrapping$
 Wrap=��� -8   $��cbxTotalRecome��$��累计收益��$��16��$	 829��$	 119���� -9   $��cbxTotalCo2��$��累计减排��$��16��$	 830��$ 90���� -:   $��label14��$	 500��$	 222��$��
首页LOGO��$��28���� -;   $��tbxLogoPath��$��0q�$	 577��$	 227��$��20��$	��274��.������ $6 0/sungrow_demo;component/images/main/suc_sy03.png��.���� -<   $��label15��$	 500��$	 262��$��
内页LOGO��$��28���� -=   $��tbxInsideLogoPath��$��0q�$	 577��$	 267��$��20��$	��274��.������ $6 0/sungrow_demo;component/images/main/suc_sy03.png��.���� ->   $��btnLogoConfirm��$	 853��$	 225��$��	浏览...��$��23��$��75���� -?   $��btnInsideLogo��$	 853��$	 264��$��	浏览...��$��23��$��75���� -@   $��lblMainPage��$��首页��$��28��$
��Left=�$��674,548,0,0q�$	��Top=��� -A   $��
lblPrePage��$��	上一页��$��28��$
��Left=�$��723,548,0,0q�$	��Top=��� -B   $��lblNextPage��$��	下一页��$��28��$
��Left=�$��823,548,0,0q�$	��Top=��� -C   $��
lblCurPage��$��2/5页��$��28��$
��Left=�$��776,548,0,0q�$	��Top=��� -D   $��comPageList��$��23��$
��Left=�$��910,550,0,0q�$	��Top=�$��80�� J� 	AllowDrop .  �� -E   $��lblSkip��$��跳转��$��28��$
��Left=�$��874,548,0,0q�$	��Top=�