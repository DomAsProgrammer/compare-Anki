#!/usr/bin/perl

# Show, which Jōyō-Kanji are missing in database

use strict;
use warnings;
#use diagnostics;

# Variables
my $databasef	= ( defined($ARGV[0]) ) ? $ARGV[0] : '';	# second argument
my $missingf	= ( defined($ARGV[1]) ) ? $ARGV[1] : '';	# third argument
my @joyos	= ();						# array for all Jōyō-Kanji 
my $database	= '';						# joined array from database export
my @missing	= ();						# array for all Kanji, which weren't found
my $yn		= '';

if ( ! ($databasef) || ! ($missingf) ) {
	print STDERR "\nUsage: $0 <file from Anki-export (utf8)> <file for output>\n\n\n";
	exit(1);
	}
elsif ( ! -T $databasef ) {
	print STDERR "\n\"$databasef\" is no valid textfile!\n\n";
	exit(3);
	}

if ( -e $missingf ) {
	YN:
	while ( 1 ) {
		print STDERR "\nSame outputfile \"$missingf\" already exists!\nOverwrite? [Y|n] ";
		chomp($yn = <STDIN>);
		$yn =~ s/\s+//g;
		if ( $yn eq '' || $yn =~ m/^Y|YES/i ) {
			last(YN);
			}
		elsif ( $yn =~ m/^n|no/i ) {
			print STDERR "Abort!\n";
			exit(4);
			}
		else {
			print "\"$yn\" is no valid input!\n";
			}
		}
	}

# build array with jōyō
# List of year 2010
use utf8;
@joyos = split('', "一右雨円王音下火花貝学気休玉金九空月犬見五口校左三山四子糸字耳七車手十出女小上森人水正生青石赤先千川早草足村大男竹中虫町天田土二日入年白八百文本名木目夕立力林六引羽雲園遠黄何夏家科歌画会回海絵外角楽活間丸岩顔帰汽記弓牛魚京強教近兄形計元原言古戸午後語交光公工広考行高合国黒今才細作算姉市思止紙寺時自室社弱首秋週春書少場色食心新親図数星晴声西切雪線船前組走多太体台谷知地池茶昼朝長鳥直通弟店点電冬刀東当答頭同道読内南肉馬買売麦半番父風分聞米歩母方北妹毎万明鳴毛門夜野矢友曜用来理里話悪安暗委意医育員飲院運泳駅横屋温化荷界開階寒感漢館岸期起客宮急球究級去橋業局曲銀区苦具君係軽決血研県庫湖向幸港号根祭坂皿仕使始指死詩歯事持次式実写者主取守酒受州拾終習集住重宿所暑助勝商昭消章乗植深申真神身進世整昔全想相送息速族他打対待代第題炭短談着柱注丁帳調追定庭笛鉄転登都度島投湯等豆動童農波配倍箱畑発反板悲皮美鼻筆氷表病秒品夫負部服福物平返勉放味命面問役薬油有由遊予様洋羊葉陽落流旅両緑礼列練路和愛案以位囲胃衣印栄英塩央億加果課貨芽改械害街各覚完官管観関願喜器希旗機季紀議救求泣給挙漁競共協鏡極訓軍郡型径景芸欠結健建験固候功好康航告差最菜材昨刷察札殺参散産残司史士氏試児治辞失借種周祝順初唱松焼照省笑象賞信臣成清静席積折節説戦浅選然倉巣争側束続卒孫帯隊達単置仲貯兆腸低停底的典伝徒努灯働堂得特毒熱念敗梅博飯費飛必標票不付府副粉兵別変辺便包法望牧末満未脈民無約勇要養浴利陸料良量輪類令例冷歴連労老録圧易移因営永衛液益演往応恩仮価可河過賀解快格確額刊幹慣眼基寄規技義逆久旧居許境興均禁句群経潔件券検険減現限個故護効厚構耕講鉱混査再妻採災際在罪財桜雑賛酸師志支枝資飼似示識質舎謝授修術述準序承招証常情条状織職制勢性政精製税績責接設絶舌銭祖素総像増造則測属損態貸退団断築張提程敵適統導銅徳独任燃能破判版犯比肥非備俵評貧婦富布武復複仏編弁保墓報豊暴貿防務夢迷綿輸余預容率略留領異遺域宇映延沿我灰拡閣革割株巻干看簡危揮机貴疑吸供胸郷勤筋敬系警劇激穴憲権絹厳源呼己誤后孝皇紅鋼降刻穀骨困砂座済裁策冊蚕姿私至視詞誌磁射捨尺若樹収宗就衆従縦縮熟純処署諸除傷将障城蒸針仁垂推寸盛聖誠宣専泉洗染善創奏層操窓装臓蔵存尊宅担探誕暖段値宙忠著庁潮頂賃痛展党糖討届難乳認納脳派俳拝背肺班晩否批秘腹奮並閉陛片補暮宝訪亡忘棒枚幕密盟模訳優郵幼欲翌乱卵覧裏律臨朗論亜哀握扱依偉威尉慰為維緯違井壱逸稲芋姻陰隠韻渦浦影詠鋭疫悦謁越閲宴援炎煙猿縁鉛汚凹奥押欧殴翁沖憶乙卸穏佳嫁寡暇架禍稼箇華菓蚊雅餓介塊壊怪悔懐戒拐皆劾慨概涯該垣嚇核殻獲穫較郭隔岳掛潟喝括渇滑褐轄且刈乾冠勘勧喚堪寛患憾換敢棺款歓汗環甘監緩缶肝艦貫還鑑閑陥含頑企奇岐幾忌既棋棄祈軌輝飢騎鬼偽儀宜戯擬欺犠菊吉喫詰却脚虐丘及朽窮糾巨拒拠虚距享凶叫峡恐恭挟況狂狭矯脅響驚仰凝暁斤琴緊菌襟謹吟駆愚虞偶遇隅屈掘靴繰桑勲薫傾刑啓契恵慶憩掲携渓継茎蛍鶏迎鯨撃傑倹兼剣圏堅嫌懸献肩謙賢軒遣顕幻弦玄孤弧枯誇雇顧鼓互呉娯御悟碁侯坑孔巧恒慌抗拘控攻更江洪溝甲硬稿絞綱肯荒衡貢購郊酵項香剛拷豪克酷獄腰込墾婚恨懇昆紺魂佐唆詐鎖債催宰彩栽歳砕斎載剤咲崎削搾索錯撮擦傘惨桟暫伺刺嗣施旨祉紫肢脂諮賜雌侍慈滋璽軸執湿漆疾芝赦斜煮遮蛇邪勺爵酌釈寂朱殊狩珠趣儒寿需囚愁秀臭舟襲酬醜充柔汁渋獣銃叔淑粛塾俊瞬准循旬殉潤盾巡遵庶緒叙徐償匠升召奨宵尚床彰抄掌昇晶沼渉焦症硝礁祥称粧紹肖衝訟詔詳鐘丈冗剰壌嬢浄畳譲醸錠嘱飾殖触辱伸侵唇娠寝審慎振浸紳薪診辛震刃尋甚尽迅陣酢吹帥炊睡粋衰遂酔錘随髄崇枢据杉澄瀬畝是姓征牲誓請逝斉隻惜斥析籍跡拙摂窃仙占扇栓潜旋繊薦践遷銑鮮漸禅繕塑措疎礎租粗訴阻僧双喪壮捜掃挿曹槽燥荘葬藻遭霜騒憎贈促即俗賊堕妥惰駄耐怠替泰滞胎袋逮滝卓択拓沢濯託濁諾但奪脱棚丹嘆淡端胆鍛壇弾恥痴稚致遅畜蓄逐秩窒嫡抽衷鋳駐弔彫徴懲挑眺聴脹超跳勅朕沈珍鎮陳津墜塚漬坪釣亭偵貞呈堤帝廷抵締艇訂逓邸泥摘滴哲徹撤迭添殿吐塗斗渡途奴怒倒凍唐塔悼搭桃棟盗痘筒到謄踏逃透陶騰闘洞胴峠匿督篤凸突屯豚曇鈍縄軟尼弐如尿妊忍寧猫粘悩濃把覇婆廃排杯輩培媒賠陪伯拍泊舶薄迫漠爆縛肌鉢髪伐罰抜閥伴帆搬畔繁般藩販範煩頒盤蛮卑妃彼扉披泌疲碑罷被避尾微匹姫漂描苗浜賓頻敏瓶怖扶敷普浮符腐膚譜賦赴附侮舞封伏幅覆払沸噴墳憤紛雰丙併塀幣弊柄壁癖偏遍舗捕穂募慕簿倣俸奉峰崩抱泡砲縫胞芳褒邦飽乏傍剖坊妨帽忙房某冒紡肪膨謀僕墨撲朴没堀奔翻凡盆摩磨魔麻埋膜又抹繭慢漫魅岬妙眠矛霧婿娘銘滅免茂妄猛盲網耗黙戻紋匁厄躍柳愉癒諭唯幽悠憂猶裕誘雄融与誉庸揚揺擁溶窯謡踊抑翼羅裸頼雷絡酪欄濫吏履痢離硫粒隆竜慮虜了僚寮涼猟療糧陵倫厘隣塁涙累励鈴隷零霊麗齢暦劣烈裂廉恋錬炉露廊楼浪漏郎賄惑枠湾腕媛怨鬱唄淫咽茨彙椅萎畏嵐宛顎曖挨韓鎌葛骸蓋崖諧潰瓦牙苛俺臆岡旺艶稽憬詣熊窟串惧錦僅巾嗅臼畿亀伎玩挫沙痕頃駒傲乞喉梗虎股舷鍵拳桁隙呪腫嫉叱鹿餌摯恣斬拶刹柵埼塞采戚脊醒凄裾須腎芯尻拭憧蹴羞袖汰遜捉踪痩曾爽遡狙膳箋詮腺煎羨鶴爪椎捗嘲貼酎緻綻旦誰戴堆唾鍋謎梨奈那丼貪頓栃瞳藤賭妬填溺諦阜訃肘膝眉斑阪汎氾箸剥罵捻虹匂喩闇弥冶麺冥蜜枕昧勃頬貌蜂蔑璧餅蔽脇麓籠弄呂瑠瞭侶慄璃藍辣拉沃瘍妖湧柿哺楷睦釜錮賂毀勾曽");
no utf8;

# build string of used Jōyō-Kanji
open(DB, "<:encoding(utf8)", $databasef);
	$database = join('', <DB>);
close(DB);
$database =~ s/\\+|\|+|\"+|\<+|\>+|\=+|\:+|\;+|\/+|[A-Z]+|[0-9]+|\n+|\s+|\.+|\^+|[ßüöä]+|_+|\&+|\'+|\"+|\*+|\?+|\,+|\(+|\)+|\-+//ig;

# test every Kanji if exist, if it not exist, add to missing array
foreach my $kanji ( @joyos ) {
	if ( $database !~ m/$kanji/ ) {
	#if ( ! ($database =~ m/$kanji/a) ) { # what is a?!
		push(@missing, $kanji);
		}
	}

# write array in file
if ( scalar(@missing) > 0 ) {
	print "\n\nFound Jōyō-Kanji:\t", scalar(@joyos), "\n",
		"Jōyō-Kanji in Ankidb:\t", scalar(@joyos) - scalar(@missing), "\n",
		"Missing Jōyō-Kanji:\t", scalar(@missing), "\n\n";
	open(MISS, ">:encoding(utf8)", $missingf);
		print MISS @missing;
	close(MISS);			# Reopen to prevent false interpetatiion of 'ō' (without utf8)
	open(MISS, ">>", $missingf);	# Reopen to prevent false interpetatiion of 'ō' (without utf8)
	print MISS "\n\nFound Jōyō-Kanji:\t", scalar(@joyos), "\n",
		"Jōyō-Kanji in Ankidb:\t", scalar(@joyos) - scalar(@missing), "\n",
		"Missing Jōyō-Kanji:\t", scalar(@missing), "\n";
	close(MISS);
	}
else {
	print STDERR "\nNo Jōyō-Kanji missing.\n\n";
	}
# EOF
exit(0);
