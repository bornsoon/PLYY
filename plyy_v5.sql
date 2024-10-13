BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS IMG (
	id      SERIAL PRIMARY KEY,
	img     BYTEA NOT NULL, 
	u_id	INTEGER NOT NULL,
	FOREIGN KEY(u_id) REFERENCES PUBLIC.USER(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS CURATOR (
	id      SERIAL PRIMARY KEY,
	name    VARCHAR(30) NOT NULL UNIQUE,
	img     VARCHAR(150) NOT NULL,    --백엔드 글자 수 초과하지 않게 설정해주기
	intro	VARCHAR(255) NOT NULL
);
CREATE TABLE IF NOT EXISTS PUBLIC.USER (
	id	        SERIAL PRIMARY KEY,
	email	    VARCHAR(100) NOT NULL UNIQUE,
	pw	        VARCHAR(50) NOT NULL,
	nickname	VARCHAR(30),
	img	        VARCHAR(50)
);
CREATE TABLE IF NOT EXISTS P_LIKE (
	id	    SERIAL PRIMARY KEY,
	u_id	INTEGER NOT NULL,
	p_id	INTEGER NOT NULL,
	FOREIGN KEY(u_id) REFERENCES PUBLIC.USER(id) ON DELETE CASCADE,
	FOREIGN KEY(p_id) REFERENCES PLYY(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS C_LIKE (
	id	    SERIAL PRIMARY KEY,
	u_id	INTEGER NOT NULL,
	c_id    INTEGER NOT NULL,
	FOREIGN KEY(c_id) REFERENCES CURATOR(id) ON DELETE CASCADE,
	FOREIGN KEY(u_id) REFERENCES PUBLIC.USER(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS TAG (
	id	    SERIAL PRIMARY KEY,
	name	VARCHAR(30) NOT NULL
);
CREATE TABLE IF NOT EXISTS P_TAG (
	id      SERIAL PRIMARY KEY,
	t_id	INTEGER,
	p_id	INTEGER,
	FOREIGN KEY(t_id) REFERENCES TAG(id) ON DELETE CASCADE,
	FOREIGN KEY(p_id) REFERENCES PLYY(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS C_TAG (
	id	    SERIAL PRIMARY KEY,
	t_id	INTEGER,
	c_id	INTEGER,
	FOREIGN KEY(t_id) REFERENCES TAG(id) ON DELETE CASCADE,
	FOREIGN KEY(c_id) REFERENCES CURATOR(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS GENRE (
	id	    SERIAL PRIMARY KEY,
	name	VARCHAR(30) NOT NULL
);
CREATE TABLE IF NOT EXISTS TRACK (
	id	    VARCHAR(30) PRIMARY KEY,
	title	VARCHAR(255) NOT NULL,
	artist	VARCHAR(100) NOT NULL,
	album	VARCHAR(255) NOT NULL,
	img	    VARCHAR(255) NOT NULL,
	rtime	INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS PLYY (
	id	        SERIAL PRIMARY KEY,
	title	    VARCHAR(255) NOT NULL,
	img   	    VARCHAR(255) NOT NULL,
	gen_date	DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	up_date	    DATE,
	cmt	        VARCHAR(255) NOT NULL,
	c_id	    INTEGER NOT NULL,
	g_id	    INTEGER NOT NULL,
	FOREIGN KEY(c_id) REFERENCES CURATOR(id),
	FOREIGN KEY(g_id) REFERENCES GENRE(id)
);
CREATE TABLE IF NOT EXISTS SONG (
	id	    SERIAL PRIMARY KEY,
	cmt	    VARCHAR(255),
	vid	    VARCHAR(255) NOT NULL,
	num	    SMALLINT NOT NULL,
	p_id	INTEGER NOT NULL,
	tk_id	VARCHAR(30) NOT NULL,
	FOREIGN KEY(tk_id) REFERENCES TRACK(id) ON DELETE CASCADE,
	FOREIGN KEY(p_id) REFERENCES PLYY(id) ON DELETE CASCADE
);
INSERT INTO CURATOR VALUES (1,'Vinky','C1.jpg','뭘 좋아할 지 몰라서 다 준비했어');
INSERT INTO CURATOR VALUES (2,'별하나','C2.jpg','보편적이고 일상적인 상황에서 느낄 수 있는 다양한 감정에 집중합니다');
INSERT INTO CURATOR VALUES (3,'쌔미','C3.jpg','~J-Pop 담당 큐레이터~ J-Pop 차트, 애니OP & EP, 여러 음원 사이트에서 들어보고 좋은 곡들을 선별하여 공유합니다~!^^/');
INSERT INTO CURATOR VALUES (4,'714','C4.jpg','장르안가리고 음악듣고 공유하는 사람');
INSERT INTO PUBLIC.USER VALUES (1,'sesac@naver.com','1234!@user','hello','U1.jpg');
INSERT INTO PUBLIC.USER VALUES (2,'wemrlc@kakao.com','kcopwl645sdfsdf','Bobo','U2.jpg');
INSERT INTO PUBLIC.USER VALUES (3,'chocolate@naver.com','1234eueiqie','쌔미','U3.jpg');
INSERT INTO PUBLIC.USER VALUES (4,'newsesac@naver.com','user5678!@','SESAC','U4.jpg');
INSERT INTO P_LIKE VALUES (1,1,1);
INSERT INTO P_LIKE VALUES (2,2,1);
INSERT INTO P_LIKE VALUES (3,3,1);
INSERT INTO P_LIKE VALUES (4,4,1);
INSERT INTO P_LIKE VALUES (5,1,2);
INSERT INTO P_LIKE VALUES (6,3,2);
INSERT INTO P_LIKE VALUES (7,1,4);
INSERT INTO P_LIKE VALUES (8,2,4);
INSERT INTO P_LIKE VALUES (9,3,4);
INSERT INTO P_LIKE VALUES (10,4,6);
INSERT INTO P_LIKE VALUES (11,4,7);
INSERT INTO P_LIKE VALUES (12,1,1);
INSERT INTO P_LIKE VALUES (13,1,3);
INSERT INTO P_LIKE VALUES (14,1,4);
INSERT INTO P_LIKE VALUES (15,1,7);
INSERT INTO C_LIKE VALUES (1,1,1);
INSERT INTO C_LIKE VALUES (2,2,2);
INSERT INTO C_LIKE VALUES (3,2,2);
INSERT INTO C_LIKE VALUES (4,1,4);
INSERT INTO TAG VALUES (1,'Emotional');
INSERT INTO TAG VALUES (2,'Aesthetic');
INSERT INTO TAG VALUES (3,'Heartbroken');
INSERT INTO TAG VALUES (4,'Sensational');
INSERT INTO TAG VALUES (5,'Rhythmical');
INSERT INTO TAG VALUES (6,'감성');
INSERT INTO TAG VALUES (7,'인디세스푼');
INSERT INTO TAG VALUES (8,'아이돌한스푼');
INSERT INTO TAG VALUES (9,'그루비');
INSERT INTO TAG VALUES (10,'감미로운');
INSERT INTO TAG VALUES (11,'힙잘알');
INSERT INTO TAG VALUES (12,'무드챙기기');
INSERT INTO TAG VALUES (13,'일본');
INSERT INTO TAG VALUES (14,'J-Pop');
INSERT INTO TAG VALUES (15,'띵곡파티');
INSERT INTO TAG VALUES (16,'혼자_듣는_노래');
INSERT INTO TAG VALUES (17,'가사_말고_멜로디');
INSERT INTO TAG VALUES (18,'내가_좋아하는_노래');
INSERT INTO TAG VALUES (19,'너도_마음에_들었으면');
INSERT INTO TAG VALUES (20,'힙스터');
INSERT INTO TAG VALUES (21,'음잘알');
INSERT INTO TAG VALUES (22,'잡탕밥취향');
INSERT INTO TAG VALUES (23,'NEWJACKWING');
INSERT INTO TAG VALUES (24,'SUMMER');
INSERT INTO TAG VALUES (25,'취향저격');
INSERT INTO TAG VALUES (26,'넓은_스펙트럼');
INSERT INTO TAG VALUES (27,'프로디깅러');
INSERT INTO P_TAG VALUES (1,12,1);
INSERT INTO P_TAG VALUES (2,11,2);
INSERT INTO P_TAG VALUES (3,3,3);
INSERT INTO P_TAG VALUES (4,6,3);
INSERT INTO P_TAG VALUES (5,2,4);
INSERT INTO P_TAG VALUES (6,1,5);
INSERT INTO P_TAG VALUES (7,5,6);
INSERT INTO P_TAG VALUES (8,23,7);
INSERT INTO P_TAG VALUES (9,24,7);
INSERT INTO P_TAG VALUES (10,9,8);
INSERT INTO P_TAG VALUES (11,18,9);
INSERT INTO P_TAG VALUES (12,19,9);
INSERT INTO P_TAG VALUES (13,25,10);
INSERT INTO P_TAG VALUES (14,15,10);
INSERT INTO P_TAG VALUES (15,7,11);
INSERT INTO P_TAG VALUES (16,8,11);
INSERT INTO C_TAG VALUES (1,20,1);
INSERT INTO C_TAG VALUES (2,21,1);
INSERT INTO C_TAG VALUES (3,22,1);
INSERT INTO C_TAG VALUES (4,4,2);
INSERT INTO C_TAG VALUES (5,10,2);
INSERT INTO C_TAG VALUES (6,14,3);
INSERT INTO C_TAG VALUES (7,16,3);
INSERT INTO C_TAG VALUES (8,17,3);
INSERT INTO C_TAG VALUES (9,26,4);
INSERT INTO C_TAG VALUES (10,27,4);
INSERT INTO GENRE VALUES (1,'팝');
INSERT INTO GENRE VALUES (2,'힙합');
INSERT INTO GENRE VALUES (3,'알앤비/소울');
INSERT INTO GENRE VALUES (4,'케이팝');
INSERT INTO GENRE VALUES (8,'신스팝');
INSERT INTO GENRE VALUES (17,'제이팝');
INSERT INTO GENRE VALUES (20,'펑크');
INSERT INTO TRACK VALUES ('1eEX2HigE7rmIT7bwVBqtj','Don''t Trip','Zacari','Run Wild Run Free','https://i.scdn.co/image/ab67616d00001e02c56e6cfbd580fa696c6ad1f6',171280);
INSERT INTO TRACK VALUES ('0gPQTLaqHDgdupKEok7J2x','7 Days','Craig David','Born to Do It','https://i.scdn.co/image/ab67616d00001e027c2e92fb2302f8e8fcd9b389',235133);
INSERT INTO TRACK VALUES ('0a4x22Cu8ix2C0ylPLl7A7','NWA (feat. Lil Durk)','Lucky Daye, Lil Durk','NWA (feat. Lil Durk)','https://i.scdn.co/image/ab67616d00001e0249d06c5128177094fc12aa13',231570);
INSERT INTO TRACK VALUES ('0NYEdeOOdXN6Nw2AeKecSJ','Back of My Mind (feat. Ty Dolla $ign)','H.E.R., Ty Dolla $ign','Back of My Mind','https://i.scdn.co/image/ab67616d00001e02f214cabc279e33a7f0140391',221133);
INSERT INTO TRACK VALUES ('360NCp4XoQ0sFi5jgu5Ww7','Insecure','Jazmine Sullivan, Bryson Tiller','Insecure','https://i.scdn.co/image/ab67616d00001e02d5ca61988f91d7f12ca71bc0',218072);
INSERT INTO TRACK VALUES ('2VSnwBXZLxPJoAHyDRyxrW','Night Calls','Yo Trane','Night Calls','https://i.scdn.co/image/ab67616d00001e02594b1120a76485dde7ba24b8',215316);
INSERT INTO TRACK VALUES ('0sHyVWNc3nfxAYOTOwOlPx','Balance','Wizkid','More Love, Less Ego','https://i.scdn.co/image/ab67616d00001e02e944c571fca9ea470ebb5821',181840);
INSERT INTO TRACK VALUES ('01JPQ87UHeGysPVwTqMJHK','She Don''t (feat. Ty Dolla $Ign)','Ella Mai, Ty Dolla $ign','Time','https://i.scdn.co/image/ab67616d00001e0240aba43042f328ad560b4be4',264097);
INSERT INTO TRACK VALUES ('6IaieqiCVvsNvEt6Y7yOFa','Ball For Me (feat. Nicki Minaj)','Post Malone, Nicki Minaj','beerbongs & bentleys','https://i.scdn.co/image/ab67616d00001e02b1c4b76e23414c9f20242268',206266);
INSERT INTO TRACK VALUES ('20jLHaXVhMFjwHs1JPjL4S','more than i should (feat. jessie reyez)','Kehlani, Jessie Reyez','blue water road','https://i.scdn.co/image/ab67616d00001e02ec32beffe58d9335b1975cb1',200639);
INSERT INTO TRACK VALUES ('4s1HdR4GZb9OQtfTq1avcq','Creep On Me (feat. French Montana & DJ Snake)','GASHI, French Montana, DJ Snake','GASHI','https://i.scdn.co/image/ab67616d00001e022b995bd89d3405e84c408bda',194777);
INSERT INTO TRACK VALUES ('4VY32hdU4byJ6cpEBAXRul','Outside','Bryson Tiller','Outside','https://i.scdn.co/image/ab67616d00001e02b0141981cfa199a11281dfd4',188579);
INSERT INTO TRACK VALUES ('1DJsyU4yU3cnONCun42snt','You Ain''t Worth It','Melii, 6LACK','You Ain''t Worth It','https://i.scdn.co/image/ab67616d00001e027134d4f6ce30f1e8c7c86a93',183077);
INSERT INTO TRACK VALUES ('4HDCLYli2SUdkq9OjmvhSD','BELIEVE IT','PARTYNEXTDOOR, Rihanna','PARTYMOBILE','https://i.scdn.co/image/ab67616d00001e02d8082097058d4c44739b17dd',183219);
INSERT INTO TRACK VALUES ('2IlT65thKQQw248mhk2PjQ','JACKIE BROWN','Brent Faiyaz','WASTELAND','https://i.scdn.co/image/ab67616d00001e0269f63a842ea91ca7c522593a',169013);
INSERT INTO TRACK VALUES ('439zbDDCpOPntEFlZFHKbY','Right Track (feat. Smino)','Syd, Smino','Right Track (feat. Smino)','https://i.scdn.co/image/ab67616d00001e0209dd94557c994dc8471d6eb6',158271);
INSERT INTO TRACK VALUES ('4E3XDKil4ElJt6sXuz5cc6','BURN','Kanye West, Ty Dolla $ign','VULTURES 1','https://i.scdn.co/image/ab67616d00001e025f4d67e6c3d62045e72d3775',111458);
INSERT INTO TRACK VALUES ('4qiBiP5cXKG6JZD1sW28u5','Do It Right','Don Toliver','Love Sick','https://i.scdn.co/image/ab67616d00001e02feeff698e6090e6b02f21ec0',174474);
INSERT INTO TRACK VALUES ('0dDI9Y0qEQspYedfdi1vau','Tyrone 2021 (feat. Big Sean)','Ty Dolla $ign, Big Sean','Featuring Ty Dolla $ign','https://i.scdn.co/image/ab67616d00001e029b6cff14d6cdf4b6a2be3a4f',158026);
INSERT INTO TRACK VALUES ('1qMnyfVxKKlAxYrFPYTuph','Mixy (feat. Summer Walker)','Quavo, Takeoff, Summer Walker','Only Built For Infinity Links','https://i.scdn.co/image/ab67616d00001e02ffe5b62233340cb6d453fc2f',270198);
INSERT INTO TRACK VALUES ('4nFrcGM7MY1mpoQCC7Kefj','Me & U','Tems','Me & U','https://i.scdn.co/image/ab67616d00001e024dfcb8700811f123ed8eca16',192935);
INSERT INTO TRACK VALUES ('5YbPxJwPfrj7uswNwoF1pJ','Last Last','Burna Boy','Love, Damini','https://i.scdn.co/image/ab67616d00001e0212ebde47882280b814275600',172342);
INSERT INTO TRACK VALUES ('2LLFl56eIFGFlnrplUC26f','Flex (Ooh, Ooh, Ooh)','Rich Homie Quan','Summer Sampler','https://i.scdn.co/image/ab67616d00001e0269c3b977ea8d7f6861a35fda',176674);
INSERT INTO TRACK VALUES ('6FXsrAH7Zol1jusSeJIoYA','Body Language (feat. Ty Dolla $ign, and Jhené Aiko)','Big Sean, Ty Dolla $ign, Jhené Aiko','Detroit 2','https://i.scdn.co/image/ab67616d00001e02b1b3fdd23be4c158d4d2c32f',224770);
INSERT INTO TRACK VALUES ('36DGvM1cGXimKtQ3rSi03a','Paper Route','Blxst, 2 Chainz','I''ll Always Come Find You','https://i.scdn.co/image/ab67616d00001e02ec71ab9f80af7052862f7b34',190826);
INSERT INTO TRACK VALUES ('6GPXq76JUWrOvlt2MHqzai','Too Many Friday Nights','Blxst, Fatman Scoop','I''ll Always Come Find You','https://i.scdn.co/image/ab67616d00001e02ec71ab9f80af7052862f7b34',174413);
INSERT INTO TRACK VALUES ('3sNVsP50132BTNlImLx70i','Bound 2','Kanye West','Yeezus','https://i.scdn.co/image/ab67616d00001e021dacfbc31cc873d132958af9',229146);
INSERT INTO TRACK VALUES ('2rbSlNYTYboHHWelF0xSAQ','Still','Kenny Beats','LOUIE','https://i.scdn.co/image/ab67616d00001e025c2bbb4d4a66a70310705a26',162240);
INSERT INTO TRACK VALUES ('5TxRUOsGeWeRl3xOML59Ai','ARE WE STILL FRIENDS?','Tyler, The Creator','IGOR','https://i.scdn.co/image/ab67616d00001e027005885df706891a3c182a57',265480);
INSERT INTO TRACK VALUES ('0Gt4nGWoATcQFL38a1NRao','West Savannah (feat. SZA)','Isaiah Rashad, SZA','Cilvia Demo','https://i.scdn.co/image/ab67616d00001e02986cd6b330f7405b17a604f4',167276);
INSERT INTO TRACK VALUES ('1jhdCONafFj1hzJsPvZx27','WHEN SPARKS FLY','Vince Staples','RAMONA PARK BROKE MY HEART','https://i.scdn.co/image/ab67616d00001e029fd6f55c35811d79d01f94ef',227873);
INSERT INTO TRACK VALUES ('5B0kgjHULYJhAQkK5XsMoC','WUSYANAME (feat. Youngboy Never Broke Again & Ty Dolla $ign)','Tyler, The Creator, YoungBoy Never Broke Again, Ty Dolla $ign','CALL ME IF YOU GET LOST','https://i.scdn.co/image/ab67616d00001e02696b4e67423edd64784bfbb4',121572);
INSERT INTO TRACK VALUES ('3GKL13lkM5nRc4zC1lIOrR','Still Not a Player (feat. Joe) - Radio Version','Big Pun, Joe','Capital Punishment','https://i.scdn.co/image/ab67616d00001e028c7a8e68dc5c20bb72f713f2',236800);
INSERT INTO TRACK VALUES ('7yoe9vbbzakNAXwb1UaWLS','Same Time Pt. 1','Big Sean, TWENTY88','I Decided.','https://i.scdn.co/image/ab67616d00001e02e572359074e5da958a922987',89866);
INSERT INTO TRACK VALUES ('1rJUbH0v2E8t1GY4OAUTeC','City Girls','Chris Brown, Young Thug','Slime & B','https://i.scdn.co/image/ab67616d00001e0263e0ddbb488d0eeec0e738fc',230253);
INSERT INTO TRACK VALUES ('3rsOs39rDAYxIOrDTHAgR9','Play No Games','Big Sean, Chris Brown, Ty Dolla $ign','Dark Sky Paradise','https://i.scdn.co/image/ab67616d00001e0250192d5f728fea13fb3af203',216653);
INSERT INTO TRACK VALUES ('4Z2hR3qjHR4r7dwt7dKd1s','Pinot Noir','IDK, Jucee Froot, Saucy Santana','F65','https://i.scdn.co/image/ab67616d00001e02be3e0e5cdda8092c351f6ac6',175834);
INSERT INTO TRACK VALUES ('0q75NwOoFiARAVp4EXU4Bs','Love Galore (feat. Travis Scott)','SZA, Travis Scott','Ctrl','https://i.scdn.co/image/ab67616d00001e024c79d5ec52a6d0302f3add25',275080);
INSERT INTO TRACK VALUES ('3zdsJOO5FIAgukJUMgboV8','Drones (feat. Kendrick Lamar, Snoop Dogg, Ty Dolla $ign & James Fauntleroy)','Terrace Martin, James Fauntleroy, Ty Dolla $ign, Kendrick Lamar, Snoop Dogg','DRONES','https://i.scdn.co/image/ab67616d00001e0248b8a1744d1166c4e48b2cfb',265357);
INSERT INTO TRACK VALUES ('0dWOFwdXrbBUYqD9DLsoyK','BLEACH','BROCKHAMPTON','SATURATION III','https://i.scdn.co/image/ab67616d00001e02ef51817e6a6563b6f7ce5872',273151);
INSERT INTO TRACK VALUES ('5hVnFTUmD5oa7Pl4ltn6KE','Not For Nothing (feat. Anderson .Paak)','Rick Ross, Anderson .Paak','Richer Than I Ever Been (Deluxe)','https://i.scdn.co/image/ab67616d00001e0223c1a5825c12fcbb44cbe524',236799);
INSERT INTO TRACK VALUES ('3XgGQ1wjo5khvq2UImjyNF','ALL MINE','Brent Faiyaz','WASTELAND','https://i.scdn.co/image/ab67616d00001e0269f63a842ea91ca7c522593a',216062);
INSERT INTO TRACK VALUES ('7ketv9r8Hm9lBpQdDekCXI','OPEN LETTER (feat. Teezo Touchdown)','MIA GLADSTONE, Teezo Touchdown','OPEN LETTER (feat. Teezo Touchdown)','https://i.scdn.co/image/ab67616d00001e02eaf13f301d87f06682a24728',246935);
INSERT INTO TRACK VALUES ('2sFEmuVVAa2klHwhFaT0rR','BOYFRIEND, GIRLFRIEND (2020 Demo) (feat. YG)','Tyler, The Creator, YG','CALL ME IF YOU GET LOST: The Estate Sale','https://i.scdn.co/image/ab67616d00001e02aa95a399fd30fbb4f6f59fca',204364);
INSERT INTO TRACK VALUES ('6PGoSes0D9eUDeeAafB2As','LOVE. FEAT. ZACARI.','Kendrick Lamar, Zacari','DAMN.','https://i.scdn.co/image/ab67616d00001e028b52c6b9bc4e43d873869699',213400);
INSERT INTO TRACK VALUES ('4S7YHmlWwfwArgd8LfSPud','L$D','A$AP Rocky','AT.LONG.LAST.A$AP','https://i.scdn.co/image/ab67616d00001e0281a6a2cafab2e7a4066b5eec',238306);
INSERT INTO TRACK VALUES ('03hqMhmCZiNKMSPmVabPLP','Groupie Love (feat. A$AP Rocky)','Lana Del Rey, A$AP Rocky','Lust For Life','https://i.scdn.co/image/ab67616d00001e0295e2fd1accb339fa14878190',264037);
INSERT INTO TRACK VALUES ('7umZiitjVsEjMQ6HNddpUI','Love Is Only a Feeling','Joey Bada$$','Love Is Only a Feeling','https://i.scdn.co/image/ab67616d00001e02b142bbe4a766121f8d6fad41',152041);
INSERT INTO TRACK VALUES ('2XILilAwcXHdGwZLNHteue','Love, of Money','MAVI','Let the Sun Talk','https://i.scdn.co/image/ab67616d00001e02655aaf07642a3042adb4ae89',64765);
INSERT INTO TRACK VALUES ('0t2myRMEMCi2SRyg5TEFLp','Love$ick','Mura Masa, A$AP Rocky','Love$ick','https://i.scdn.co/image/ab67616d00001e0233298f00975dcbaab9af3b51',192154);
INSERT INTO TRACK VALUES ('0B0jhczWfIdjY0p4KY1ArL','Another You (feat. Kanye West)','The WRLDFMS Tony Williams, Kanye West','The 7th Day','https://i.scdn.co/image/ab67616d00001e02ca0517e383b4533f835a235a',262986);
INSERT INTO TRACK VALUES ('2cHEJfLPCYxeq2YpGO5ys3','Hole Heart','Genesis Owusu','Hole Heart','https://i.scdn.co/image/ab67616d00001e02b9794d4510e5644db0f0de71',196093);
INSERT INTO TRACK VALUES ('1m8WpLYXEiNVZchsWEcCSy','Come Through and Chill (feat. J. Cole & Salaam Remi)','Miguel, J. Cole, Salaam Remi','War & Leisure','https://i.scdn.co/image/ab67616d00001e02f654e8e9ac3c24881239ab7c',322000);
INSERT INTO TRACK VALUES ('300DUx4tdtCdGEUXR032jA','Palace/Curse (feat. Tyler, The Creator & Steve Lacy)','The Internet, Tyler, The Creator, Steve Lacy','Ego Death','https://i.scdn.co/image/ab67616d00001e021c1c33c63cdbcb5788975a93',440013);
INSERT INTO TRACK VALUES ('6H0AwSQ20mo62jGlPGB8S6','It''s A Vibe','2 Chainz, Ty Dolla $ign, Trey Songz, Jhené Aiko','Pretty Girls Like Trap Music','https://i.scdn.co/image/ab67616d00001e02c0c05243a846dda6c84607f9',210200);
INSERT INTO TRACK VALUES ('6OquGsVTLqZHyxqG0PLwFz','PiLOT (feat. Snoop Dogg, Busta Rhymes, Anderson .Paak)','DOMi & JD BECK, Anderson .Paak, Busta Rhymes, Snoop Dogg','NOT TiGHT','https://i.scdn.co/image/ab67616d00001e028569040f689c3249eeb04345',202451);
INSERT INTO TRACK VALUES ('111ixdtGqBX2riiqg8m8Xx','Disco Pantz','Rejjie Snow, Tinashe, grouptherapy.','Baw Baw Black Sheep','https://i.scdn.co/image/ab67616d00001e024c7d79a229ee09aa173b4723',173666);
INSERT INTO TRACK VALUES ('5ugcpEprRXs0HnZ1iMFXed','Luckily I’m Having (feat. Teezo Touchdown)','Don Toliver, Teezo Touchdown','Love Sick (Deluxe)','https://i.scdn.co/image/ab67616d00001e02f5e27c2aa0b110c2b6611577',194453);
INSERT INTO TRACK VALUES ('270aLuFCbX32hhBr8MQyPM','Love U Better (feat. Lil Wayne & The-Dream)','Ty Dolla $ign, Nathaniel Alford, Twice As Nice, Lil Wayne, The-Dream','Beach House 3','https://i.scdn.co/image/ab67616d00001e0256f796c9039f52e90d015b4d',181880);
INSERT INTO TRACK VALUES ('50a8bKqlwDEqeiEknrzkTO','ball w/o you','21 Savage','i am > i was','https://i.scdn.co/image/ab67616d00001e02280689ecc5e4b2038bb5e4bd',195046);
INSERT INTO TRACK VALUES ('4brX8MJs5hxErgq48f9REO','Stay','Mac Miller','The Divine Feminine','https://i.scdn.co/image/ab67616d00001e022e92f776279eaf45d14a33fd',326426);
INSERT INTO TRACK VALUES ('3VRH0UqoAYXLj1WTqpuwHi','Bound','Ryan Trey, Mudi','august','https://i.scdn.co/image/ab67616d00001e020857bee8a830829401a4af38',198000);
INSERT INTO TRACK VALUES ('0H57lJQoHSzP4nE7EvTJPP','Have You Seen That Girl?','GoldLink','At What Cost','https://i.scdn.co/image/ab67616d00001e027bcd3cd54e8399ae38cc6e64',162277);
INSERT INTO TRACK VALUES ('3DCivYhjJMchrSQtoVzzWb','A Bitch Curious (feat. Sam Truth)','AG Club, Sam Truth','Fuck Your Expectations PT. 1','https://i.scdn.co/image/ab67616d00001e028a3c2e6e5a799caab8bc4e46',244871);
INSERT INTO TRACK VALUES ('0ZEFUsb2AVGup8SV3y3yXl','Nirvana','Skepta, J Balvin','Nirvana','https://i.scdn.co/image/ab67616d00001e02629f0ae002c430f0d73c8ff3',198496);
INSERT INTO TRACK VALUES ('63BcfK6YAzJYeISaTPr6IO','Big Poppa - 2007 Remaster','The Notorious B.I.G.','Greatest Hits','https://i.scdn.co/image/ab67616d00001e02639fea4197e676cfe9512e04',249866);
INSERT INTO TRACK VALUES ('0ycIrEpkyb4lrqE7M1emju','Inhale','Bryson Tiller','A N N I V E R S A R Y','https://i.scdn.co/image/ab67616d00001e02008d8077814ce15da0085b47',171173);
INSERT INTO TRACK VALUES ('1tkg4EHVoqnhR6iFEXb60y','What You Know Bout Love','Pop Smoke','Shoot For The Stars Aim For The Moon','https://i.scdn.co/image/ab67616d00001e0277ada0863603903f57b34369',160000);
INSERT INTO TRACK VALUES ('5VkuqayHiiU5ZHyYEH4Oeb','Dear Summer','Memphis Bleek, JAY-Z','534','https://i.scdn.co/image/ab67616d00001e028015e92cc0f118abac720d55',173200);
INSERT INTO TRACK VALUES ('5TRPicyLGbAF2LGBFbHGvO','Flashing Lights','Kanye West, Dwele','Graduation','https://i.scdn.co/image/ab67616d00001e0226f7f19c7f0381e56156c94a',237506);
INSERT INTO TRACK VALUES ('4HSAJpNocVNJbwbQvtCMdO','Signs','Snoop Dogg, Charlie Wilson, Justin Timberlake','R&G (Rhythm & Gangsta): The Masterpiece','https://i.scdn.co/image/ab67616d00001e02e803716268c173c3f9a0c057',236480);
INSERT INTO TRACK VALUES ('5SkRLpaGtvYPhw02vZhQQ9','All Falls Down','Kanye West, Syleena Johnson','The College Dropout','https://i.scdn.co/image/ab67616d00001e0225b055377757b3cdd6f26b78',223506);
INSERT INTO TRACK VALUES ('3mvYQKm8h6M5K5h0nVPY9S','After Dark (feat. Static Major & Ty Dolla $ign)','Drake, Static Major, Ty Dolla $ign','Scorpion','https://i.scdn.co/image/ab67616d00001e02f907de96b9a4fbc04accc0d5',289560);
INSERT INTO TRACK VALUES ('3thNB1fmi1wuhJ1vWCRuNz','Redemption (feat. SZA)','Jay Rock, SZA','Redemption','https://i.scdn.co/image/ab67616d00001e02c30d59775ce5ef3f59138f59',211613);
INSERT INTO TRACK VALUES ('0NjW4SKY3gbfl2orl1p8hr','IFHY (feat. Pharrell)','Tyler, The Creator, Pharrell Williams','Wolf','https://i.scdn.co/image/ab67616d00001e0222007a4aa8a55fe7b1de5632',319253);
INSERT INTO TRACK VALUES ('1eUGmzzvahJjOSWgDHuRlv','Girl With The Tattoo Enter.lewd','Miguel','All I Want Is You','https://i.scdn.co/image/ab67616d00001e02d5a8395b0d80b8c48a5d851c',102813);
INSERT INTO TRACK VALUES ('4HG1YiGBseVKzjyKcmAJen','Summer Games','Drake','Scorpion','https://i.scdn.co/image/ab67616d00001e02f907de96b9a4fbc04accc0d5',247893);
INSERT INTO TRACK VALUES ('2ZWlPOoWh0626oTaHrnl2a','Ivy','Frank Ocean','Blonde','https://i.scdn.co/image/ab67616d00001e02c5649add07ed3720be9d5526',249191);
INSERT INTO TRACK VALUES ('2FOX5q9f1ZZHyePbdkt5WT','Beyond Love','Beach House','Depression Cherry','https://i.scdn.co/image/ab67616d00001e0202859310b61e59756abb90ad',265186);
INSERT INTO TRACK VALUES ('2aPTvyE09vUCRwVvj0I8WK','Sundress','A$AP Rocky','Sundress','https://i.scdn.co/image/ab67616d00001e021ae967e4a02c7a39eb3c189b',158205);
INSERT INTO TRACK VALUES ('22MPIMPsoi0vd46wsbpzfE','Jesus Freak Lighter','Blood Orange','Jesus Freak Lighter','https://i.scdn.co/image/ab67616d00001e024d5caf410f05c73301e83a63',152380);
INSERT INTO TRACK VALUES ('0smgkpVia3VCXgY4qhVJvp','Guilty Conscience','070 Shake','Modus Vivendi','https://i.scdn.co/image/ab67616d00001e0220921767dd81e8f90ef9fc71',213333);
INSERT INTO TRACK VALUES ('3nAq2hCr1oWsIU54tS98pL','Waves','Kanye West','The Life Of Pablo','https://i.scdn.co/image/ab67616d00001e022a7db835b912dc5014bd37f4',181573);
INSERT INTO TRACK VALUES ('5QvBXUm5MglLJ3iBfTX2Wo','RUNNING OUT OF TIME','Tyler, The Creator','IGOR','https://i.scdn.co/image/ab67616d00001e027005885df706891a3c182a57',177226);
INSERT INTO TRACK VALUES ('2LtCEKs68u3RpNh4wybCF8','Hotel','Montell Fish','Her Love Still Haunts Me Like a Ghost','https://i.scdn.co/image/ab67616d00001e02f46e995aa84c6eb1080100a4',197333);
INSERT INTO TRACK VALUES ('2vtmY2mSccRzKGjtcHSzI3','Diet Mountain Dew','Lana Del Rey','Born To Die - The Paradise Edition','https://i.scdn.co/image/ab67616d00001e02ebc8cfac8b586bc475b04918',222920);
INSERT INTO TRACK VALUES ('1AtFSBJibfaqfiOByQCwZ5','Small girl (feat. 도경수(D.O.))','이영지, 도경수','16 Fantasy','https://i.scdn.co/image/ab67616d00001e02aa8e7da62fbfae5cb65f8e55',189706);
INSERT INTO TRACK VALUES ('351KkakA2YtGEXqSEIIasy','Supernova','aespa','Supernova','https://i.scdn.co/image/ab67616d00001e02d2ab7b4a8d0adf91b2167543',178880);
INSERT INTO TRACK VALUES ('3pDGJRDN3p6kCNZcD97FYY','Cosmic','Red Velvet','Cosmic','https://i.scdn.co/image/ab67616d00001e02a54b93bff4827437f56b7896',225864);
INSERT INTO TRACK VALUES ('7yRW1NpgQzFDQbkHat2lxQ','ABCD','나연','NA','https://i.scdn.co/image/ab67616d00001e02159a01a07fe294d4a44a59dd',162840);
INSERT INTO TRACK VALUES ('5eWcGfUCrVFMoYskyfkEPE','Armageddon','aespa','Armageddon - The 1st Album','https://i.scdn.co/image/ab67616d00001e020fc598038040859794c600e2',196466);
INSERT INTO TRACK VALUES ('2nRMW95dnOILirpjbksLTs','Never Let Go','정국','Never Let Go','https://i.scdn.co/image/ab67616d00001e02083f5a45d93b57cb65a97b83',166812);
INSERT INTO TRACK VALUES ('5juCu4WFTFRZ2XilopAMTy','밤양갱','비비','밤양갱','https://i.scdn.co/image/ab67616d00001e02c5543b3cce74f3edafcc8f59',146197);
INSERT INTO TRACK VALUES ('5XWlyfo0kZ8LF7VSyfS4Ew','Drama','aespa','Drama - The 4th Mini Album','https://i.scdn.co/image/ab67616d00001e02c54e39f2ae0dd10731f93c08',214973);
INSERT INTO TRACK VALUES ('0UTtK6hregIBOsefavRI26','홀씨','아이유','The Winning','https://i.scdn.co/image/ab67616d00001e025048ed32fafe7b9a50d0e410',190786);
INSERT INTO TRACK VALUES ('2gyCwrOcC6JBoaJ8JGJ7T8','To. X','태연','To. X - The 5th Mini Album','https://i.scdn.co/image/ab67616d00001e02ed4dcfaf5f63938ecd6c4d59',170386);
INSERT INTO TRACK VALUES ('0VPFT123HKoQ2J6ipeDcI1','Standing Next to You (USHER Remix)','정국, USHER','Standing Next to You (USHER Remix)','https://i.scdn.co/image/ab67616d00001e02c9912de0a8a9a44b450318e4',214760);
INSERT INTO TRACK VALUES ('5Avril3IZ26DPVFHbJX8o6','Seven (feat. Latto)','정국, Latto','Seven (feat. Latto)','https://i.scdn.co/image/ab67616d00001e02bf5cce5a0e1ed03a626bdd74',184160);
INSERT INTO TRACK VALUES ('1gXBi2I04CLJkTQnhNfEJT','Weight in Gold','Gallant','Ology','https://i.scdn.co/image/ab67616d00001e020927d398418d8dae1443e34e',203813);
INSERT INTO TRACK VALUES ('3z9s9hp6ouAxH0IUojkC6L','LOVE BLOSSOM (러브블러썸)','케이윌','The 3rd Album Part.2 ''Love Blossom (러브블러썸)''','https://i.scdn.co/image/ab67616d00001e0261bd11d3c300a9053672e1b1',215616);
INSERT INTO TRACK VALUES ('0Ebot4LzRKFpNmlW0gkqe6','봄날의 기억','비투비','Remember that','https://i.scdn.co/image/ab67616d00001e02eacd9ddbc86f245b9b65e134',249745);
INSERT INTO TRACK VALUES ('6YOXdy9jShw66iOnBzQMKv','봄인가 봐 (Spring Love)','웬디, 에릭남','봄인가 봐 Spring Love - SM STATION','https://i.scdn.co/image/ab67616d00001e02c2220e622cd370a4237727f8',198749);
INSERT INTO TRACK VALUES ('2vqbApjmIGDYunVMD4hXBB','너, 너 (N번째 연애 X 휘인 (Whee In))','휘인','너, 너 (N번째 연애 X 휘인 (Whee In))','https://i.scdn.co/image/ab67616d00001e02ceb44d95b343cf5ae31df9ac',271213);
INSERT INTO TRACK VALUES ('5sVe5IYLPuarlUiLOT6cFe','내사람','SG 워너비','The 3rd Masterpiece','https://i.scdn.co/image/ab67616d00001e02f440617be17b769d41c9e49a',298162);
INSERT INTO TRACK VALUES ('3AblMxPcKPDSODskCzJBEE','언젠가 (SOMEDAY)','비투비','Feel''eM','https://i.scdn.co/image/ab67616d00001e02caa4628eb3b716d518f90feb',287583);
INSERT INTO TRACK VALUES ('1z7Se5atTjuRjmRkONnHKs','꽃이 핀다','케이윌','[RE:]','https://i.scdn.co/image/ab67616d00001e02760686b872fbc11247d6f3ad',234920);
INSERT INTO TRACK VALUES ('2zlgwqw8BLX2JGB76LIFeF','그리워하다','비투비','Brother Act.','https://i.scdn.co/image/ab67616d00001e0217477a7434c66ac5548b6ab7',236829);
INSERT INTO TRACK VALUES ('2XaGO56qH03kX7MHLCHiw2','PARADISE','육성재','Piece of BTOB Vol.6','https://i.scdn.co/image/ab67616d00001e0211e2aeeecfe0dec884ead9d5',227861);
INSERT INTO TRACK VALUES ('0KVClXxsZEKkyWRNXeRFrE','내 손을 잡아','아이유','최고의 사랑 OST Part.4','https://i.scdn.co/image/ab67616d00001e02f1efb467ac4c748630ffd22f',195216);
INSERT INTO TRACK VALUES ('5rZN0PP6xZsf5SWxkpMm7k','우연히 봄','로꼬, 유주','냄새를 보는 소녀 (Original Television Soundtrack), Pt.2','https://i.scdn.co/image/ab67616d00001e02c29f93bd445c533d682296ed',201000);
INSERT INTO TRACK VALUES ('3hvWpX7wY89END0v5M0XJX','그립고 그립고 그립다','케이윌','그립고 그립고 그립다.','https://i.scdn.co/image/ab67616d00001e0293f1c6032920f43bfc6e95b1',257566);
INSERT INTO TRACK VALUES ('6HyuufaEeIcdajh1tHHVEQ','니가 필요해 (I NEED YOU)','케이윌','니가 필요해','https://i.scdn.co/image/ab67616d00001e020c762acb85f7fe0a0c1ea5e0',217808);
INSERT INTO TRACK VALUES ('6oAHHl93XiWHglVLI4SfBX','가슴이 뛴다','케이윌','가슴이 뛴다','https://i.scdn.co/image/ab67616d00001e02d60b9e77256ecfefc24b10ba',210426);
INSERT INTO TRACK VALUES ('5rGMxvUu4su0Vg3BaV9BGe','시간을 거슬러 (낮에 뜨는 달 X 케이윌)','케이윌','시간을 거슬러 (낮에 뜨는 달 X 케이윌)','https://i.scdn.co/image/ab67616d00001e02a117d85f6c294b322bb23a7c',225120);
INSERT INTO TRACK VALUES ('5NkpsRKvSBukdYQtl3WLZW','태양의 후예 (Original Television Soundtrack) Pt.6 - 말해! 뭐해?','케이윌','태양의 후예 (Original Television Soundtrack) Pt.6 - 말해! 뭐해?','https://i.scdn.co/image/ab67616d00001e0209a2ff74f461003a4d33b2bc',216555);
INSERT INTO TRACK VALUES ('5dh87xGcp4YqDFBc86Mh47','이러지마 제발 (PLEASE DON’T…)','케이윌','The 3rd Album Part.1','https://i.scdn.co/image/ab67616d00001e021b768cdd327e8efa59a94f25',212976);
INSERT INTO TRACK VALUES ('5zWWdqa4BF8tjygCS8E3rO','촌스럽게 왜 이래 (YOU DON’T KNOW LOVE)','케이윌','Will in FALL','https://i.scdn.co/image/ab67616d00001e028914c4df29fec0c2d8cf7df6',233900);
INSERT INTO TRACK VALUES ('1IdM9JrXYuMYiTdM983oH4','봄 사랑 벚꽃 말고','하이포, 아이유','봄 사랑 벚꽃 말고','https://i.scdn.co/image/ab67616d00001e02762badbc5b89a2fa65d13f67',195265);
INSERT INTO TRACK VALUES ('0g1AmSKokPboFrxmG1dxKx','썸 (feat. 릴보이)','소유, 정기고, 릴보이','썸','https://i.scdn.co/image/ab67616d00001e0261166666e32b86c3e9a7b78b',211374);
INSERT INTO TRACK VALUES ('1t2qYCAjUAoGfeFeoBlK51','Black Mamba','aespa','Black Mamba','https://i.scdn.co/image/ab67616d00001e026f248f7695eb544a3a1955c5',174933);
INSERT INTO TRACK VALUES ('0yB4jrSwN0bFtFRDR5vyMj','Love Shot','EXO','LOVE SHOT– The 5th Album Repackage','https://i.scdn.co/image/ab67616d00001e02f7da7c0f322b7a1c95190d92',200306);
INSERT INTO TRACK VALUES ('7pm5uhK7xiEM9fQvuCE78l','심쿵해 (HEART ATTACK)','AOA','Heart Attack','https://i.scdn.co/image/ab67616d00001e023bab219d2c91bbfc6fe6fec9',196522);
INSERT INTO TRACK VALUES ('05G51ez5Z73NRE0l2QtZfH','단발머리 (SHORT HAIR)','AOA','단발머리','https://i.scdn.co/image/ab67616d00001e023f5721ce0a6f6c072a2969e6',214588);
INSERT INTO TRACK VALUES ('548FKDwnyPFkfWmtoK6ETA','사뿐사뿐','AOA','사뿐사뿐','https://i.scdn.co/image/ab67616d00001e02f95a5985be3ec564ae6aaa05',219533);
INSERT INTO TRACK VALUES ('6Yj8kVuVR3UPxx9r5eFEoV','짧은 치마 (MINISKIRT)','AOA','짧은 치마','https://i.scdn.co/image/ab67616d00001e0236adcea4e93245f1fec547df',179808);
INSERT INTO TRACK VALUES ('1exnDFdC34GyBcaLt9ZJfX','벌써 12시','청하','벌써 12시','https://i.scdn.co/image/ab67616d00001e0225767b4fe7a3b04df1096b49',221813);
INSERT INTO TRACK VALUES ('42tFTth2jcF7iSo0RBjfJF','피카부 (Peek-A-Boo)','Red Velvet','Perfect Velvet - The 2nd Album','https://i.scdn.co/image/ab67616d00001e026538b8e1b5c7b2a9d2211769',189049);
INSERT INTO TRACK VALUES ('4ljXOIFNSjnGA2VuCYHQTS','살짝 설렜어 (Nonstop)','오마이걸','NONSTOP','https://i.scdn.co/image/ab67616d00001e02774ede43eb295a97a6f8bf94',202760);
INSERT INTO TRACK VALUES ('7nKQ5WAcjnG48knyLuo8gO','빨간 맛 (Red Flavor)','Red Velvet','The Red Summer - Summer Mini Album','https://i.scdn.co/image/ab67616d00001e028164cd1a2e03b7ca2db9ff5e',191139);
INSERT INTO TRACK VALUES ('5pCaf7SR1fPW95Ua1CrJYu','Yours Faithfully','Rebbie Jackson','Yours Faithfully','https://i.scdn.co/image/ab67616d00001e020bd9877d1b6457a6fb70f7d4',272506);
INSERT INTO TRACK VALUES ('6344mzqvYpXiLxl723UVyE','YOU (Feat. 크라운제이, 베이빌론)(Prod by D.O)','이현도, 베이빌론, CROWN J','D.O.P.E.','https://i.scdn.co/image/ab67616d00001e02c77398a2692afad127f5108f',212083);
INSERT INTO TRACK VALUES ('0DW7eEkraNLUv94eAaxn4v','This One''s for You','Joe Public','Joe Public','https://i.scdn.co/image/ab67616d00001e02233b6404ed87261ad2d8cc36',278600);
INSERT INTO TRACK VALUES ('76P9PzvAk51CqtOeCIEGBQ','U Will Know - US Radio Mix','B.M.U. (Black Men United)','U Will Know','https://i.scdn.co/image/ab67616d00001e02131f93cd630d0651f0975321',244026);
INSERT INTO TRACK VALUES ('1IkdRtsgZCtWIekX8NrLdN','Hot 뜨거','1TYM','Once N 4 All','https://i.scdn.co/image/ab67616d00001e0212031d07e7ad259efa2cf74f',218333);
INSERT INTO TRACK VALUES ('6R6FlagrCC7HuFZnapXO5o','Slide','El DeBarge','Heart, Mind & Soul','https://i.scdn.co/image/ab67616d00001e029050760ed68116eaaebcd699',344733);
INSERT INTO TRACK VALUES ('2EQaWLbkUcZ92sLKQsSeDv','Simple Pleasures','Karyn White','Make Him Do Right','https://i.scdn.co/image/ab67616d00001e02db58077a8675dded730530f1',276893);
INSERT INTO TRACK VALUES ('6ipZiTWO0fuhs8lul00e4w','Hangin''','Jade','Mind, Body & Soul','https://i.scdn.co/image/ab67616d00001e0251f655b4c82421f3ca7e6159',239000);
INSERT INTO TRACK VALUES ('6vhjkSvhOxU5ZyUshIAPCY','I Don''t Mind','Big Bub','Comin'' At Cha','https://i.scdn.co/image/ab67616d00001e02b8077a102f6a3e8cd245a3d6',255600);
INSERT INTO TRACK VALUES ('1GztRvzpFWGhe00N3jv91q','Not to Be','Unv','The Lost Remixes','https://i.scdn.co/image/ab67616d00001e026c0eaac2136719f24fd26904',318902);
INSERT INTO TRACK VALUES ('1w09YJ2UvJvCR4q0W44snv','Do You Believe in Me','Eric Gadd','Do You Believe In Me','https://i.scdn.co/image/ab67616d00001e027b1361614dcdff8c48b606b9',258266);
INSERT INTO TRACK VALUES ('7ujVDENgCDD77JxBuw4Mhu','Judy Had A Boyfriend - Mucho 12" no rap','Riff','To Whom It May Concern','https://i.scdn.co/image/ab67616d00001e023c50c3468f71d042aa481b6b',229400);
INSERT INTO TRACK VALUES ('5hyHsOQUnWQMBPWX8KZuID','Lies','En Vogue, Debbie T.','Born to Sing','https://i.scdn.co/image/ab67616d00001e020e43e9832aedfcd1899471b7',256333);
INSERT INTO TRACK VALUES ('3SYqmao3YLyGYzmvBJ7Bhe','Have You Got What It Takes','Starpoint','Have You Got What It Takes','https://i.scdn.co/image/ab67616d00001e02eb28a11a028b55b53f093943',274666);
INSERT INTO TRACK VALUES ('5EGIJVtcmlFdw21fTwGf3u','La La La','Harold Travis, B. Brown Posse','B. Brown Posse','https://i.scdn.co/image/ab67616d00001e020ae494cf8b0a48d41a6ca647',234133);
INSERT INTO TRACK VALUES ('5ocSQW5sIUIOFojwXEz9Ki','Supernatural','NewJeans','Supernatural','https://i.scdn.co/image/ab67616d00001e027e1eeb0d7cc374a168369c80',191000);
INSERT INTO TRACK VALUES ('53svtkdl7Hl0RZgAuTgON8','If You Let It','Alexander O''Neal','Love Makes No Sense','https://i.scdn.co/image/ab67616d00001e02e630d291553206ca08add84e',314200);
INSERT INTO TRACK VALUES ('6SaeXxdt0Id6ZzmX0ZGTQK','Fastlove, Pt. 1','George Michael','Older','https://i.scdn.co/image/ab67616d00001e02721aa94703c1a94c735aacd0',324666);
INSERT INTO TRACK VALUES ('2Sv7RMNFfNofAOmA32mLA4','Waiting For The Day','Shai','If I Ever Fall In Love','https://i.scdn.co/image/ab67616d00001e02b7bc7394a6a5995a887330ef',285173);
INSERT INTO TRACK VALUES ('7G0bBRiFDs1sDsiRqzZbmT','Nasty Girl','Nuttin'' Nyce','Down 4 Whateva','https://i.scdn.co/image/ab67616d00001e025ee4f56f2096aeb00c8683ce',340906);
INSERT INTO TRACK VALUES ('4xw1SakICm1K8xgeLdElyB','Take A Step Back','DeDe Lopez','TBA (Totally Bombastic Anecdotes)','https://i.scdn.co/image/ab67616d00001e02d80dd4ea660d87be61773595',246733);
INSERT INTO TRACK VALUES ('070bDNenZlWcjzZGAc2npp','Sax-A-Go-Go','Candy Dulfer','Sax-A-Go-Go','https://i.scdn.co/image/ab67616d00001e02bd3020ee94e5c47101847893',294760);
INSERT INTO TRACK VALUES ('6TSM5vkz0WzyZsNAKKYDcw','Someday','Mariah Carey','Mariah Carey','https://i.scdn.co/image/ab67616d00001e025084c69ed3f70e8fb139e1ea',246106);
INSERT INTO TRACK VALUES ('0h9SUGpAofhus8HUgNXVwW','I Bet My Life','Imagine Dragons','Smoke + Mirrors (Deluxe)','https://i.scdn.co/image/ab67616d00001e0259ac0a9acb7bf0d315301152',192706);
INSERT INTO TRACK VALUES ('4jnFqNWeJCeCRHc4HCdxfd','Remember the Time','Michael Jackson','Dangerous','https://i.scdn.co/image/ab67616d00001e023b9f8b18cc685e1502128aa8',239226);
INSERT INTO TRACK VALUES ('3HGE6Is63CrKHS9DZ26RIO','Rub You The Right Way','Johnny Gill','Johnny Gill','https://i.scdn.co/image/ab67616d00001e02e44407586df5456493482202',333800);
INSERT INTO TRACK VALUES ('3Xtn6ND8fGALF41WWztGF1','You Make The Difference','Tracie Spencer','Make The Difference','https://i.scdn.co/image/ab67616d00001e02f14b49620afd34100dd682b8',306693);
INSERT INTO TRACK VALUES ('45SiHmjLBcPWFsNFzB547Y','Summer Madness','Mato','Summer Madness / Use Me','https://i.scdn.co/image/ab67616d00001e023ef22b025ff4bc7148767105',198128);
INSERT INTO TRACK VALUES ('1hkPTehvUqLaidlQUOfDmP','Love Mission','George Duke','Thief In The Night','https://i.scdn.co/image/ab67616d00001e022396ee50e174329d3fa9d9be',264866);
INSERT INTO TRACK VALUES ('4QySScdQnRDZjDaAdpY0AM','2 Much','Qendresa','2 Much','https://i.scdn.co/image/ab67616d00001e022036eba92d71a1d19bce76b2',200000);
INSERT INTO TRACK VALUES ('3lgG9DGpDpR1VUH9ACi1EE','내부순환','Sultan of the Disco','Easy Listening For Love','https://i.scdn.co/image/ab67616d00001e02e11245033e759b81e5e9c172',200500);
INSERT INTO TRACK VALUES ('3g1ekuXAKuFuEfarqTIxIH','Sticky Rice','Santino Surfers','Santino Surfers','https://i.scdn.co/image/ab67616d00001e026ecd0ed56bee548e2b3d5d84',250000);
INSERT INTO TRACK VALUES ('1UwD1ovEx84rBdpJRJt99O','Try Me','Starpoint','Wanting You','https://i.scdn.co/image/ab67616d00001e028e4c8baae1be1ba1456dbe30',304133);
INSERT INTO TRACK VALUES ('3b2DShkYT32XIVmybU1xmf','Can''t Give You Up','Midnight Star','Standing Together','https://i.scdn.co/image/ab67616d00001e0216ea280507fefc50f34e8d93',253693);
INSERT INTO TRACK VALUES ('2vMMyG4iw5OppGOh23kXIe','Action Speaks Louder Than Words','Chocolate Milk','Action Speaks Louder Than Words','https://i.scdn.co/image/ab67616d00001e025217c39f9c0eb9b5df0b0b53',211186);
INSERT INTO TRACK VALUES ('1rVP30BW6y7uA8iJrp7wl1','It''ll All Come Around','Patsy Gallant','Patsy!','https://i.scdn.co/image/ab67616d00001e02a47fab3c141cf6b9129cacad',263400);
INSERT INTO TRACK VALUES ('1uzaFntXR5Q9K99LlduyhP','Holding On to Love','Rose Royce','Music Magic','https://i.scdn.co/image/ab67616d00001e02323e538b7b98da975161a4de',200106);
INSERT INTO TRACK VALUES ('18iyA5BPmU3Htj2YZnMHdo','더위','이소라','이소라 1집','https://i.scdn.co/image/ab67616d00001e024a60b99b94289a435a30748c',277760);
INSERT INTO TRACK VALUES ('0beJBpWGM17KeMTI5v1SBS','숙녀예찬','morning','아침 1집','https://i.scdn.co/image/ab67616d00001e021ef935cbf367450803febfcc',252506);
INSERT INTO TRACK VALUES ('7i6h8cg9E1Z7Dyy48gj2kw','Baby Come Back','Lisa Stansfield','Lisa Stansfield (Deluxe)','https://i.scdn.co/image/ab67616d00001e0296a6b96a548b55d60d5c540e',214373);
INSERT INTO TRACK VALUES ('2dbx9A36sJQXrBWQtI4Fsl','All Over','State Cows','Challenges','https://i.scdn.co/image/ab67616d00001e022eae732b55a1fbb615b17abc',250542);
INSERT INTO TRACK VALUES ('64KIbKLoCuMATvUM9laI91','Touch the Star','Soulpersona, Princess Freesia','Extended Pleasure','https://i.scdn.co/image/ab67616d00001e029e9c7ed20407df5cc8977d56',338472);
INSERT INTO TRACK VALUES ('67t5MpxDL4XREv387RPyYT','The Dealmaker','Daniel Andersson','Days in L.A.','https://i.scdn.co/image/ab67616d00001e027177d767047b2d792fd7cc4a',328440);
INSERT INTO TRACK VALUES ('0juMDnoo3u3uDJ32wjK2BF','Hold Me Up (Thank You)','Khruangbin','A LA SALA','https://i.scdn.co/image/ab67616d00001e023854b553506134a1421ed58c',229437);
INSERT INTO TRACK VALUES ('7DcJ6fEBb7BaKuYKTwiDxK','Homage','Mild High Club','Skiptracing','https://i.scdn.co/image/ab67616d00001e0296bc7d5bd0b6488de76598ab',177493);
INSERT INTO TRACK VALUES ('3cqZ2Vsxt5Gi5ZLx3h5DAW','Cloud','Galdive','Cloud','https://i.scdn.co/image/ab67616d00001e02b82509299dd1e36c5d9c645e',232000);
INSERT INTO TRACK VALUES ('2bTvNKT8bxyyPhzHu4A2Wx','Going up the Coast','Clay and Friends','Going up the Coast','https://i.scdn.co/image/ab67616d00001e02c3b0dc769a4a8d8ce7357e55',174613);
INSERT INTO TRACK VALUES ('1vxw6aYJls2oq3gW0DujAo','Crazy','Gnarls Barkley','St. Elsewhere','https://i.scdn.co/image/ab67616d00001e02ceb0b3423d21e3da43c58b0b',177933);
INSERT INTO TRACK VALUES ('4ZaRg5Sf4TKr0YcFRLh7QJ','Love Affair','UMI','Love Language','https://i.scdn.co/image/ab67616d00001e02434fca871f8262f28c5a1481',190960);
INSERT INTO TRACK VALUES ('6KfoDhO4XUWSbnyKjNp9c4','Maniac','Conan Gray','Kid Krow','https://i.scdn.co/image/ab67616d00001e0288e3cda6d29b2552d4d6bc43',185773);
INSERT INTO TRACK VALUES ('1WCOna34eEMPgjfOOZkGQc','Bad Boy','청하, Christopher','Bad Boy','https://i.scdn.co/image/ab67616d00001e0290ee0d4d3906192283bae657',182586);
INSERT INTO TRACK VALUES ('6Dg2RJihNlbkLSmtXY3p5f','Warm on a Cold Night','HONNE','Warm on a Cold Night (Deluxe)','https://i.scdn.co/image/ab67616d00001e0298ba0f90dd1805629ce4c53e',261594);
INSERT INTO TRACK VALUES ('0VjIjW4GlUZAMYd2vXMi3b','Blinding Lights','The Weeknd','After Hours','https://i.scdn.co/image/ab67616d00001e028863bc11d2aa12b54f5aeb36',200040);
INSERT INTO TRACK VALUES ('2SLwbpExuoBDZBpjfefCtV','Out of Time','The Weeknd','Dawn FM','https://i.scdn.co/image/ab67616d00001e024ab2520c2c77a1d66b9ee21d',214193);
INSERT INTO TRACK VALUES ('2QYnONicU24TXbkhtaemOM','Obsessed','Ayumu Imazu','Obsessed','https://i.scdn.co/image/ab67616d00001e024db004259495cf37df5a9bd5',196500);
INSERT INTO TRACK VALUES ('6dquCx5KAW5jCgGgoTlghL','Every Second','Mina Okabe','Every Second','https://i.scdn.co/image/ab67616d00001e02fc03b97c30ce11e30e65e389',182076);
INSERT INTO TRACK VALUES ('7uoFMmxln0GPXQ0AcCBXRq','Snowman','Sia','Everyday Is Christmas (Deluxe Edition)','https://i.scdn.co/image/ab67616d00001e02d1410c1372fab1e516328fa8',165900);
INSERT INTO TRACK VALUES ('3oUEzTAoOxqZHN4xiqTGqJ','Bécane - A COLORS SHOW','Yamê','Bécane - A COLORS SHOW','https://i.scdn.co/image/ab67616d00001e027dfba3f3ae607f250cdd969c',182440);
INSERT INTO TRACK VALUES ('0O6u0VJ46W86TxN9wgyqDj','I Like You (A Happier Song) (with Doja Cat)','Post Malone, Doja Cat','Twelve Carat Toothache','https://i.scdn.co/image/ab67616d00001e0234362676667a4322838ccc97',192840);
INSERT INTO TRACK VALUES ('1RBIzko2PMY5CP0d3MIkwl','Scooter','Lolo Zouaï','Scooter','https://i.scdn.co/image/ab67616d00001e020fb6d4857bd587c629dce57e',128770);
INSERT INTO TRACK VALUES ('2SL6pRmKNyug2DqhoVjVXq','睨めっ娘','友成空','睨めっ娘','https://i.scdn.co/image/ab67616d00001e02cf0c82a1b6e15eb079ab4b15',159000);
INSERT INTO TRACK VALUES ('64yajM6CxtLghmgB53VeXT','インフェルノ','Mrs. GREEN APPLE','インフェルノ','https://i.scdn.co/image/ab67616d00001e021a4e99f0c693fecc9038d3dd',212546);
INSERT INTO TRACK VALUES ('6y4GYuZszeXNOXuBFsJlos','Kaikai Kitan','Eve','Kaikai Kitan / Ao No Waltz','https://i.scdn.co/image/ab67616d00001e024b54d2a72484832db80a0fe9',221426);
INSERT INTO TRACK VALUES ('6sIx7Cn37DGEhjy9hBP8Gx','猫','DISH//','僕たちがやりました','https://i.scdn.co/image/ab67616d00001e02ece6b6818c2b96a559508acc',276040);
INSERT INTO TRACK VALUES ('72uSoNIf7eScfGZFQjNHrR','Dramaturgy','Eve','Bunka','https://i.scdn.co/image/ab67616d00001e029794fc0e54d795a65d732967',238181);
INSERT INTO TRACK VALUES ('1XT0cpl9g0GuRQJao2nqXd','Kanzen kankaku Dreamer','ONE OK ROCK','Niche Syndrome','https://i.scdn.co/image/ab67616d00001e023e4b149dd3110f1432bfeca0',252200);
INSERT INTO TRACK VALUES ('2iOvMtA1u9s95NF6mJDOuT','香水','Eito','香水','https://i.scdn.co/image/ab67616d00001e028c619e91247463929b384517',252594);
INSERT INTO TRACK VALUES ('7LHAKF7pBqHch8o6Yo0ad5','Suzume','RADWIMPS, Toaka','Suzume','https://i.scdn.co/image/ab67616d00001e025cde862db0ec9bb1e1566dd7',236390);
INSERT INTO TRACK VALUES ('1YXot2MLAG9sttepCtBRM7','踊り子','Vaundy','replica','https://i.scdn.co/image/ab67616d00001e028d88fae79a837318aadcc056',229328);
INSERT INTO TRACK VALUES ('2iXZA6Ecf9AZHw92tZBNLv','TSUNAMI','サザンオールスターズ','TSUNAMI','https://i.scdn.co/image/ab67616d00001e0243ea9e1f2ebeb01786d83676',315500);
INSERT INTO TRACK VALUES ('7163xpL9SvNzMY6tk7nL8L','くらべられっ子','TUYU','やっぱり雨は降るんだね','https://i.scdn.co/image/ab67616d00001e024b5faf2955056fc97ee144ce',214155);
INSERT INTO TRACK VALUES ('4W3rP2KZkKEykdWvlWLgyc','フライデー・ナイト','natori','劇場','https://i.scdn.co/image/ab67616d00001e020ac0f324b55a0e56b62670ca',176240);
INSERT INTO TRACK VALUES ('5Rqj6lHkIkKSD3OUgae6bw','絶頂讃歌','和ぬか','審美眼','https://i.scdn.co/image/ab67616d00001e0271c5dfb6f5c24d3d23de1c98',183080);
INSERT INTO TRACK VALUES ('0jyxo8MlRDZu0S0e7yUBDD','アディオス','DAZBEE','orbit','https://i.scdn.co/image/ab67616d00001e023bacfa0b41f0085798642635',202106);
INSERT INTO TRACK VALUES ('1hAloWiinXLPQUJxrJReb1','アイドル','YOASOBI','THE BOOK 3','https://i.scdn.co/image/ab67616d00001e02f3527c2e1ffc2e99bb6a072e',211733);
INSERT INTO TRACK VALUES ('2cxcqKwQtfKq7giphxjzOu','晩餐歌','tuki.','晩餐歌','https://i.scdn.co/image/ab67616d00001e0255e029fef14405c5d536453b',215853);
INSERT INTO TRACK VALUES ('1uhx7CG8DLhCkAV0IoqYCe','청록','이츠','청록','https://i.scdn.co/image/ab67616d00001e0242a685253270bbac3889da2b',205922);
INSERT INTO TRACK VALUES ('6q5qD963d6AuwUF7NAcVhl','새벽에 걸려온 너의 전화는','한동근','미련을 말하는','https://i.scdn.co/image/ab67616d00001e02957b2a67a3265b77799d6fa3',237653);
INSERT INTO TRACK VALUES ('6GI5AwV6rXiAItDCA822NS','사실 나는 (Feat.전건호)','경서예지, 전건호','사실 나는','https://i.scdn.co/image/ab67616d00001e02bcf5e157f0e0623ee33912e5',254140);
INSERT INTO TRACK VALUES ('3VwwxnQlYfAIIIWwgvdAWR','연애의 발명 (웹툰 ''연애의 발견'' X BIG Naughty (서동현))','BIG Naughty (서동현)','연애의 발명 (웹툰 ''연애의 발견'' X BIG Naughty (서동현))','https://i.scdn.co/image/ab67616d00001e025b853678c8b454a8044d4d45',179853);
INSERT INTO TRACK VALUES ('2IMPPA9UZpqTnnVIy9lDHU','Love Me Back','프로미스나인','Love Me Back (From "작전명 순정")','https://i.scdn.co/image/ab67616d00001e02824e970a5f7636c79f5d4a74',186293);
INSERT INTO TRACK VALUES ('7mlPsRdAV93pgaoZcc0KI0','후라이의 꿈','AKMU','LOVE EPISODE','https://i.scdn.co/image/ab67616d00001e02370408df34b170c3402e84f2',204576);
INSERT INTO TRACK VALUES ('05jnwo3kEZaHL5uOM0Enfx','Love Lee','AKMU','LOVE EPISODE','https://i.scdn.co/image/ab67616d00001e02370408df34b170c3402e84f2',179683);
INSERT INTO TRACK VALUES ('4BcyvGnKg8DaHfXAjzFqhs','Show Your Smile (핑계)','김건모','In My Pops & Live','https://i.scdn.co/image/ab67616d00001e02454788d0530541aa3d59f3c4',222933);
INSERT INTO PLYY VALUES (1,'Chill','P1.jpg','2024-08-03 06:25:02',NULL,'감성적인 R&B와 매력적인 힙합이 조화를 이루는 곡들로 구성된 플레이리스트입니다. Zacari의 "Don''t Trip"부터 H.E.R.와 Ty Dolla $ign의 "Back of My Mind", Wizkid의 "Balance"까지 다양한 음악적 색깔을 경험하며, 일상적인 순간을 특별하게 만들어 줄 완벽한 사운드트랙을 즐겨보세요!','1','3');
INSERT INTO PLYY VALUES (2,'나그녀랑친구하고싶어서그녀한테사귀자고했더니그녀가나보고친구하재','P2.jpg','2024-08-03 06:25:02','2024-08-04 06:25:02','화란아 나도 순정이 있다_래퍼의 사랑 노래 모음','1','2');
INSERT INTO PLYY VALUES (3,'💔','P3.jpg','2022-07-16 06:25:02','2023-07-16 06:25:02','진짜 내 마음은 뭘까..','1','8');
INSERT INTO PLYY VALUES (4,'Bronze','P4.jpg','2024-08-03 06:25:02',NULL,'동','2','4');
INSERT INTO PLYY VALUES (5,'Gold','P5.jpg','2023-05-01 06:25:02','2024-07-23 06:25:02','금','2','1');
INSERT INTO PLYY VALUES (6,'Silver','P6.jpg','2023-08-03 06:25:02',NULL,'은','2','4');
INSERT INTO PLYY VALUES (7,'Last Summer Swing Vol. 3 / LL YOON J MIX #12','P7.jpg','2024-03-03 06:25:02','2024-05-03 06:25:02','90년대 이후 뉴잭스윙은 한국 음악씬에서 주목받지 못했지만, New Jeans의 "Supernatural" 발매로 다시 메인스트림에 떠오른 것에 기쁩니다. 기념으로 Murakami Takashi의 오마주 아트웍과 함께 여름 믹스셋을 업로드합니다. 오래 기다리셨습니다! 즐겁게 들어 주세요. ☀️','4','20');
INSERT INTO PLYY VALUES (8,'24.7.22. Soul, Slowjam','P8.jpg','2024-06-30 06:25:02',NULL,'피로한 하루를 릴렉스 해주는 완벽한 슬로우잼','4','20');
INSERT INTO PLYY VALUES (9,'🧇 my_collection.zip 🥐','P9.jpg','2024-06-03 06:25:02','2024-08-03 06:25:02','큐레이터가 엄선한 빌보드 명곡! ~ 틱톡, 유투브, 인스타에서 한번쯤은 들어본 띵곡이지만 제목은 모르는 여러분들을 위해 엄선한 곡 ~','3','1');
INSERT INTO PLYY VALUES (10,'知ってる？','P10.jpg','2024-01-03 06:25:02','2024-08-03 06:25:02','큐레이터 취저 J-Pop! ~ 애니 OP, EP부터 시대를 거슬러 전설처럼 내려오는 명곡들까지 ~','3','17');
INSERT INTO PLYY VALUES (11,'내맘대로 한국 🩰','P11.jpg','2024-05-03 06:25:02',NULL,'큐레이터가 굳이 꾸역꾸역 찾아 듣는 한국노래들 ~ 인디같지만 인디는 아니고 아이돌 노래같지만 아이돌노래는 아닌 아리송한 곡들!','3','4');
INSERT INTO PLYY VALUES (12,'Chill ver.2','P12.jpg','2024-08-13 03:16:59',NULL,'믿고 들어봐','1','3');
INSERT INTO SONG VALUES (0,'','https://www.youtube.com/embed/ldzmYDDPnz4',0,1,'1eEX2HigE7rmIT7bwVBqtj');
INSERT INTO SONG VALUES (1,'','https://www.youtube.com/embed/P5lmb5-tnM0',0,12,'0gPQTLaqHDgdupKEok7J2x');
INSERT INTO SONG VALUES (2,'','https://www.youtube.com/embed/jtM0RcOJlNs',1,1,'0a4x22Cu8ix2C0ylPLl7A7');
INSERT INTO SONG VALUES (3,'','https://www.youtube.com/embed/uiaRAvxlciM',2,1,'0NYEdeOOdXN6Nw2AeKecSJ');
INSERT INTO SONG VALUES (4,'','https://www.youtube.com/embed/xcC3UQl3V-U',1,12,'360NCp4XoQ0sFi5jgu5Ww7');
INSERT INTO SONG VALUES (5,'','https://www.youtube.com/embed/oDjxlN92L98',3,1,'2VSnwBXZLxPJoAHyDRyxrW');
INSERT INTO SONG VALUES (6,'맛깔난 아프로비트','https://www.youtube.com/embed/aIUHjpBhLJQ',4,1,'0sHyVWNc3nfxAYOTOwOlPx');
INSERT INTO SONG VALUES (7,'','https://www.youtube.com/embed/uIQRJ71Aa9Q',8,1,'01JPQ87UHeGysPVwTqMJHK');
INSERT INTO SONG VALUES (8,'','https://www.youtube.com/embed/atyPXBQfCaY',14,1,'6IaieqiCVvsNvEt6Y7yOFa');
INSERT INTO SONG VALUES (9,'','https://www.youtube.com/embed/v0lzuXGXLE0',9,1,'20jLHaXVhMFjwHs1JPjL4S');
INSERT INTO SONG VALUES (10,'','https://www.youtube.com/embed/t1YHv1wHAxo',10,1,'4s1HdR4GZb9OQtfTq1avcq');
INSERT INTO SONG VALUES (11,'','https://www.youtube.com/embed/ijYpfI_sCy8',11,1,'4VY32hdU4byJ6cpEBAXRul');
INSERT INTO SONG VALUES (12,'','https://www.youtube.com/embed/84d64ets6sY',12,1,'1DJsyU4yU3cnONCun42snt');
INSERT INTO SONG VALUES (13,'','https://www.youtube.com/embed/gejbbL1AaJk',6,1,'4HDCLYli2SUdkq9OjmvhSD');
INSERT INTO SONG VALUES (14,'','https://www.youtube.com/embed/snH91WGT1UE',13,1,'2IlT65thKQQw248mhk2PjQ');
INSERT INTO SONG VALUES (15,'','https://www.youtube.com/embed/ZLJT7KXQhOs',15,1,'439zbDDCpOPntEFlZFHKbY');
INSERT INTO SONG VALUES (16,'칸예표 사랑노래는 믿듣이지','https://www.youtube.com/embed/oFK8bdAZY3A',7,1,'4E3XDKil4ElJt6sXuz5cc6');
INSERT INTO SONG VALUES (17,'','https://www.youtube.com/embed/kcr3NC7fsKY',17,1,'4qiBiP5cXKG6JZD1sW28u5');
INSERT INTO SONG VALUES (18,'','https://www.youtube.com/embed/LsnQOwZXYc0',18,1,'0dDI9Y0qEQspYedfdi1vau');
INSERT INTO SONG VALUES (19,'미고스는 추임새만 잘하는 게 아니다','https://www.youtube.com/embed/Tpy5r2UGdo0',19,1,'1qMnyfVxKKlAxYrFPYTuph');
INSERT INTO SONG VALUES (20,'','https://www.youtube.com/embed/1JltlSJH5bY',20,1,'4nFrcGM7MY1mpoQCC7Kefj');
INSERT INTO SONG VALUES (21,'','https://www.youtube.com/embed/421w1j87fEM',21,1,'5YbPxJwPfrj7uswNwoF1pJ');
INSERT INTO SONG VALUES (22,'','https://www.youtube.com/embed/bWMw4vE3J8s',22,1,'2LLFl56eIFGFlnrplUC26f');
INSERT INTO SONG VALUES (23,'','https://www.youtube.com/embed/YbciBJ3IUPs',23,1,'6FXsrAH7Zol1jusSeJIoYA');
INSERT INTO SONG VALUES (24,'','https://www.youtube.com/embed/Dg7ldnW2inQ',16,1,'36DGvM1cGXimKtQ3rSi03a');
INSERT INTO SONG VALUES (25,'','https://www.youtube.com/embed/we_JGhM5-Ao',5,1,'6GPXq76JUWrOvlt2MHqzai');
INSERT INTO SONG VALUES (26,'','https://www.youtube.com/embed/BBAtAM7vtgc',0,2,'3sNVsP50132BTNlImLx70i');
INSERT INTO SONG VALUES (27,'','https://www.youtube.com/embed/SeLo34-BDJk',1,2,'2rbSlNYTYboHHWelF0xSAQ');
INSERT INTO SONG VALUES (28,'','https://www.youtube.com/embed/Gb76TgCUqAY',2,2,'5TxRUOsGeWeRl3xOML59Ai');
INSERT INTO SONG VALUES (29,'','https://www.youtube.com/embed/yrHQka9XchA',3,2,'0Gt4nGWoATcQFL38a1NRao');
INSERT INTO SONG VALUES (30,'','https://www.youtube.com/embed/5fFV0dWpQPE',4,2,'1jhdCONafFj1hzJsPvZx27');
INSERT INTO SONG VALUES (31,'','https://www.youtube.com/embed/NJea386275c',5,2,'5B0kgjHULYJhAQkK5XsMoC');
INSERT INTO SONG VALUES (32,'','https://www.youtube.com/embed/5tSDhGea27E',6,2,'3GKL13lkM5nRc4zC1lIOrR');
INSERT INTO SONG VALUES (33,'','https://www.youtube.com/embed/8DL1XiYWjpk',7,2,'7yoe9vbbzakNAXwb1UaWLS');
INSERT INTO SONG VALUES (34,'','https://www.youtube.com/embed/_Gcaa7rGKr8',8,2,'1rJUbH0v2E8t1GY4OAUTeC');
INSERT INTO SONG VALUES (35,'','https://www.youtube.com/embed/DJi7WupFqPQ',9,2,'3rsOs39rDAYxIOrDTHAgR9');
INSERT INTO SONG VALUES (36,'','https://www.youtube.com/embed/YbciBJ3IUPs',10,2,'6FXsrAH7Zol1jusSeJIoYA');
INSERT INTO SONG VALUES (37,'','https://www.youtube.com/embed/aeCE435Ll1c',11,2,'4Z2hR3qjHR4r7dwt7dKd1s');
INSERT INTO SONG VALUES (38,'','https://www.youtube.com/embed/hHXfCOjb3fk',12,2,'0q75NwOoFiARAVp4EXU4Bs');
INSERT INTO SONG VALUES (39,'','https://www.youtube.com/embed/OxWCfqZhZX4',13,2,'3zdsJOO5FIAgukJUMgboV8');
INSERT INTO SONG VALUES (40,'','https://www.youtube.com/embed/cTMucy4PR2k',14,2,'0dWOFwdXrbBUYqD9DLsoyK');
INSERT INTO SONG VALUES (41,'','https://www.youtube.com/embed/DQmqCJFWaLU',15,2,'5hVnFTUmD5oa7Pl4ltn6KE');
INSERT INTO SONG VALUES (42,'','https://www.youtube.com/embed/sqgerBkCCWM',16,2,'3XgGQ1wjo5khvq2UImjyNF');
INSERT INTO SONG VALUES (43,'','https://www.youtube.com/embed/jb0YEeU9CZo',17,2,'7ketv9r8Hm9lBpQdDekCXI');
INSERT INTO SONG VALUES (44,'','https://www.youtube.com/embed/nteYkDKLnps',18,2,'2sFEmuVVAa2klHwhFaT0rR');
INSERT INTO SONG VALUES (45,'','https://www.youtube.com/embed/ox7RsX1Ee34',19,2,'6PGoSes0D9eUDeeAafB2As');
INSERT INTO SONG VALUES (46,'','https://www.youtube.com/embed/yEG2VTHS9yg',20,2,'4S7YHmlWwfwArgd8LfSPud');
INSERT INTO SONG VALUES (47,'','https://www.youtube.com/embed/tBwoRviPvVw',21,2,'03hqMhmCZiNKMSPmVabPLP');
INSERT INTO SONG VALUES (48,'','https://www.youtube.com/embed/93ufch_2mfw',22,2,'7umZiitjVsEjMQ6HNddpUI');
INSERT INTO SONG VALUES (49,'','https://www.youtube.com/embed/AVLe3Uk1qB8',23,2,'2XILilAwcXHdGwZLNHteue');
INSERT INTO SONG VALUES (50,'','https://www.youtube.com/embed/ZJM4AQSbZDk',24,2,'0t2myRMEMCi2SRyg5TEFLp');
INSERT INTO SONG VALUES (51,'','https://www.youtube.com/embed/lnADp4vGBAg',25,2,'0B0jhczWfIdjY0p4KY1ArL');
INSERT INTO SONG VALUES (52,'','https://www.youtube.com/embed/6NMBHsh_mi8',26,2,'2cHEJfLPCYxeq2YpGO5ys3');
INSERT INTO SONG VALUES (53,'','https://www.youtube.com/embed/u_C4onVrr8U',27,2,'1m8WpLYXEiNVZchsWEcCSy');
INSERT INTO SONG VALUES (54,'','https://www.youtube.com/embed/Uml5YDmbiQw',28,2,'300DUx4tdtCdGEUXR032jA');
INSERT INTO SONG VALUES (55,'','https://www.youtube.com/embed/tU3p6mz-uxU',29,2,'6H0AwSQ20mo62jGlPGB8S6');
INSERT INTO SONG VALUES (56,'','https://www.youtube.com/embed/rPC1g9oe2_8',30,2,'6OquGsVTLqZHyxqG0PLwFz');
INSERT INTO SONG VALUES (57,'','https://www.youtube.com/embed/H0qVhi01Lp4',31,2,'111ixdtGqBX2riiqg8m8Xx');
INSERT INTO SONG VALUES (58,'','https://www.youtube.com/embed/1sbbWXjAro8',32,2,'5ugcpEprRXs0HnZ1iMFXed');
INSERT INTO SONG VALUES (59,'','https://www.youtube.com/embed/r6OHG5JiuDc',33,2,'270aLuFCbX32hhBr8MQyPM');
INSERT INTO SONG VALUES (60,'','https://www.youtube.com/embed/_4gUVl5pjps',34,2,'50a8bKqlwDEqeiEknrzkTO');
INSERT INTO SONG VALUES (61,'','https://www.youtube.com/embed/5WU7oGiwiao',35,2,'4brX8MJs5hxErgq48f9REO');
INSERT INTO SONG VALUES (62,'','https://www.youtube.com/embed/pY6IijST_pw',36,2,'3VRH0UqoAYXLj1WTqpuwHi');
INSERT INTO SONG VALUES (63,'','https://www.youtube.com/embed/jfjnI_jbzew',37,2,'0H57lJQoHSzP4nE7EvTJPP');
INSERT INTO SONG VALUES (64,'','https://www.youtube.com/embed/u49K6WIhH84',38,2,'3DCivYhjJMchrSQtoVzzWb');
INSERT INTO SONG VALUES (65,'','https://www.youtube.com/embed/cg14EVOxiuQ',39,2,'0ZEFUsb2AVGup8SV3y3yXl');
INSERT INTO SONG VALUES (66,'','https://www.youtube.com/embed/QceVTChhlJM',40,2,'63BcfK6YAzJYeISaTPr6IO');
INSERT INTO SONG VALUES (67,'','https://www.youtube.com/embed/zew8SOatV0U',41,2,'0ycIrEpkyb4lrqE7M1emju');
INSERT INTO SONG VALUES (68,'','https://www.youtube.com/embed/uuodbSVO3z0',42,2,'1tkg4EHVoqnhR6iFEXb60y');
INSERT INTO SONG VALUES (69,'','https://www.youtube.com/embed/LBOmocitDfA',43,2,'5VkuqayHiiU5ZHyYEH4Oeb');
INSERT INTO SONG VALUES (70,'','https://www.youtube.com/embed/ila-hAUXR5U',44,2,'5TRPicyLGbAF2LGBFbHGvO');
INSERT INTO SONG VALUES (71,'','https://www.youtube.com/embed/Cs2d7qrVbB8',45,2,'4HSAJpNocVNJbwbQvtCMdO');
INSERT INTO SONG VALUES (72,'','https://www.youtube.com/embed/8kyWDhB_QeI',46,2,'5SkRLpaGtvYPhw02vZhQQ9');
INSERT INTO SONG VALUES (73,'','https://www.youtube.com/embed/COilSLHbdqs',47,2,'3mvYQKm8h6M5K5h0nVPY9S');
INSERT INTO SONG VALUES (74,'','https://www.youtube.com/embed/S38Y9LHoRh4',48,2,'3thNB1fmi1wuhJ1vWCRuNz');
INSERT INTO SONG VALUES (75,'','https://www.youtube.com/embed/3lDqMx4rmFU',49,2,'0NjW4SKY3gbfl2orl1p8hr');
INSERT INTO SONG VALUES (76,'','https://www.youtube.com/embed/XDOaT7nqqvI',0,3,'1eUGmzzvahJjOSWgDHuRlv');
INSERT INTO SONG VALUES (77,'','https://www.youtube.com/embed/rTNmdqzZllE',1,3,'4HG1YiGBseVKzjyKcmAJen');
INSERT INTO SONG VALUES (78,'','https://www.youtube.com/embed/tBwoRviPvVw',2,3,'03hqMhmCZiNKMSPmVabPLP');
INSERT INTO SONG VALUES (79,'','https://www.youtube.com/embed/AE005nZeF-A',3,3,'2ZWlPOoWh0626oTaHrnl2a');
INSERT INTO SONG VALUES (80,'','https://www.youtube.com/embed/wy5iwc1NwXg',4,3,'2FOX5q9f1ZZHyePbdkt5WT');
INSERT INTO SONG VALUES (81,'','https://www.youtube.com/embed/Ec3LoKpGJxY',5,3,'2aPTvyE09vUCRwVvj0I8WK');
INSERT INTO SONG VALUES (82,'','https://www.youtube.com/embed/f21gWR8NdC0',6,3,'22MPIMPsoi0vd46wsbpzfE');
INSERT INTO SONG VALUES (83,'','https://www.youtube.com/embed/X0t8zeEiqEY',7,3,'0smgkpVia3VCXgY4qhVJvp');
INSERT INTO SONG VALUES (84,'','https://www.youtube.com/embed/ML8Yq1Rd6I0',8,3,'3nAq2hCr1oWsIU54tS98pL');
INSERT INTO SONG VALUES (85,'','https://www.youtube.com/embed/Uyf_lImpdRw',9,3,'5QvBXUm5MglLJ3iBfTX2Wo');
INSERT INTO SONG VALUES (86,'','https://www.youtube.com/embed/GWhGT66FteU',10,3,'2LtCEKs68u3RpNh4wybCF8');
INSERT INTO SONG VALUES (87,'','https://www.youtube.com/embed/sEetXo3R-aM',11,3,'2vtmY2mSccRzKGjtcHSzI3');
INSERT INTO SONG VALUES (88,'영Z의 SOUL','https://www.youtube.com/embed/11iZcYbq_is',0,4,'1AtFSBJibfaqfiOByQCwZ5');
INSERT INTO SONG VALUES (89,'','https://www.youtube.com/embed/phuiiNCxRMg',1,4,'351KkakA2YtGEXqSEIIasy');
INSERT INTO SONG VALUES (90,'','https://www.youtube.com/embed/FyG21rXCxlY',2,4,'3pDGJRDN3p6kCNZcD97FYY');
INSERT INTO SONG VALUES (91,'','https://www.youtube.com/embed/oUZttxRcPZw',3,4,'7yRW1NpgQzFDQbkHat2lxQ');
INSERT INTO SONG VALUES (92,'','https://www.youtube.com/embed/nFYwcndNuOY',4,4,'5eWcGfUCrVFMoYskyfkEPE');
INSERT INTO SONG VALUES (93,'','https://www.youtube.com/embed/weRxoGz-rtE',5,4,'2nRMW95dnOILirpjbksLTs');
INSERT INTO SONG VALUES (94,'','https://www.youtube.com/embed/Iz1mVUw436g',6,4,'5juCu4WFTFRZ2XilopAMTy');
INSERT INTO SONG VALUES (95,'','https://www.youtube.com/embed/D8VEhcPeSlc',7,4,'5XWlyfo0kZ8LF7VSyfS4Ew');
INSERT INTO SONG VALUES (96,'','https://www.youtube.com/embed/bZEv7tzFORo',8,4,'0UTtK6hregIBOsefavRI26');
INSERT INTO SONG VALUES (97,'','https://www.youtube.com/embed/5_n6t9G2TUQ',9,4,'2gyCwrOcC6JBoaJ8JGJ7T8');
INSERT INTO SONG VALUES (98,'','https://www.youtube.com/embed/UNo0TG9LwwI',10,4,'0VPFT123HKoQ2J6ipeDcI1');
INSERT INTO SONG VALUES (99,'','https://www.youtube.com/embed/QU9c0053UAU',11,4,'5Avril3IZ26DPVFHbJX8o6');
INSERT INTO SONG VALUES (100,'','https://www.youtube.com/embed/p7qpwl0vHjo',0,5,'1gXBi2I04CLJkTQnhNfEJT');
INSERT INTO SONG VALUES (101,'','https://www.youtube.com/embed/iRGOb6aKcgw',1,5,'3z9s9hp6ouAxH0IUojkC6L');
INSERT INTO SONG VALUES (102,'','https://www.youtube.com/embed/ZJGz5ZPDFPI',2,5,'0Ebot4LzRKFpNmlW0gkqe6');
INSERT INTO SONG VALUES (103,'','https://www.youtube.com/embed/erErBFKPbMY',3,5,'6YOXdy9jShw66iOnBzQMKv');
INSERT INTO SONG VALUES (104,'','https://www.youtube.com/embed/78cOydTJMfU',4,5,'2vqbApjmIGDYunVMD4hXBB');
INSERT INTO SONG VALUES (105,'','https://www.youtube.com/embed/G5hbOrbfSRY',5,5,'5sVe5IYLPuarlUiLOT6cFe');
INSERT INTO SONG VALUES (106,'','https://www.youtube.com/embed/I-NRzzmmG_Q',6,5,'3AblMxPcKPDSODskCzJBEE');
INSERT INTO SONG VALUES (107,'','https://www.youtube.com/embed/PILCSOBWeh8',7,5,'1z7Se5atTjuRjmRkONnHKs');
INSERT INTO SONG VALUES (108,'','https://www.youtube.com/embed/qVYDICwngMA',8,5,'2zlgwqw8BLX2JGB76LIFeF');
INSERT INTO SONG VALUES (109,'','https://www.youtube.com/embed/WtUOsEVapz4',9,5,'2XaGO56qH03kX7MHLCHiw2');
INSERT INTO SONG VALUES (110,'','https://www.youtube.com/embed/ZKszvaLQiF4',10,5,'0KVClXxsZEKkyWRNXeRFrE');
INSERT INTO SONG VALUES (111,'','https://www.youtube.com/embed/9BJTZmmK62Y',11,5,'5rZN0PP6xZsf5SWxkpMm7k');
INSERT INTO SONG VALUES (112,'','https://www.youtube.com/embed/QN-H-f2dfzU',12,5,'3hvWpX7wY89END0v5M0XJX');
INSERT INTO SONG VALUES (113,'','https://www.youtube.com/embed/mrYZHMr_Uu0',13,5,'6HyuufaEeIcdajh1tHHVEQ');
INSERT INTO SONG VALUES (114,'','https://www.youtube.com/embed/V9WnRQmPuFc',14,5,'6oAHHl93XiWHglVLI4SfBX');
INSERT INTO SONG VALUES (115,'','https://www.youtube.com/embed/tLRN0n2-zyU',15,5,'5rGMxvUu4su0Vg3BaV9BGe');
INSERT INTO SONG VALUES (116,'','https://www.youtube.com/embed/SdHQkkRc-hc',16,5,'5NkpsRKvSBukdYQtl3WLZW');
INSERT INTO SONG VALUES (117,'','https://www.youtube.com/embed/HGpyXfCqBCk',17,5,'5dh87xGcp4YqDFBc86Mh47');
INSERT INTO SONG VALUES (118,'','https://www.youtube.com/embed/6jxi8Tjv33E',18,5,'5zWWdqa4BF8tjygCS8E3rO');
INSERT INTO SONG VALUES (119,'','https://www.youtube.com/embed/ouR4nn1G9r4',19,5,'1IdM9JrXYuMYiTdM983oH4');
INSERT INTO SONG VALUES (120,'','https://www.youtube.com/embed/lDsJFiprilo',20,5,'0g1AmSKokPboFrxmG1dxKx');
INSERT INTO SONG VALUES (121,'','https://www.youtube.com/embed/ZeerrnuLi5E',0,6,'1t2qYCAjUAoGfeFeoBlK51');
INSERT INTO SONG VALUES (122,'','https://www.youtube.com/embed/pSudEWBAYRE',1,6,'0yB4jrSwN0bFtFRDR5vyMj');
INSERT INTO SONG VALUES (123,'','https://www.youtube.com/embed/cYXyzXBhecI',2,6,'7pm5uhK7xiEM9fQvuCE78l');
INSERT INTO SONG VALUES (124,'','https://www.youtube.com/embed/odBtcACwF0o',3,6,'05G51ez5Z73NRE0l2QtZfH');
INSERT INTO SONG VALUES (125,'','https://www.youtube.com/embed/HU7ndIT06Ys',4,6,'548FKDwnyPFkfWmtoK6ETA');
INSERT INTO SONG VALUES (126,'','https://www.youtube.com/embed/clr4ghJk_Bs',5,6,'6Yj8kVuVR3UPxx9r5eFEoV');
INSERT INTO SONG VALUES (127,'','https://www.youtube.com/embed/nFYwcndNuOY',6,6,'5eWcGfUCrVFMoYskyfkEPE');
INSERT INTO SONG VALUES (128,'','https://www.youtube.com/embed/HlN2BXNJzxA',7,6,'1exnDFdC34GyBcaLt9ZJfX');
INSERT INTO SONG VALUES (129,'','https://www.youtube.com/embed/2q3Yaz0MxNg',8,6,'42tFTth2jcF7iSo0RBjfJF');
INSERT INTO SONG VALUES (130,'','https://www.youtube.com/embed/iDjQSdN_ig8',9,6,'4ljXOIFNSjnGA2VuCYHQTS');
INSERT INTO SONG VALUES (131,'','https://www.youtube.com/embed/bUwHblpMX1M',10,6,'7nKQ5WAcjnG48knyLuo8gO');
INSERT INTO SONG VALUES (132,'','https://www.youtube.com/embed/EWxt0KtkHlY',0,7,'5pCaf7SR1fPW95Ua1CrJYu');
INSERT INTO SONG VALUES (133,'','https://www.youtube.com/embed/fBAGzCDntMM',1,7,'6344mzqvYpXiLxl723UVyE');
INSERT INTO SONG VALUES (134,'','https://www.youtube.com/embed/nvgT3kr-rj4',2,7,'0DW7eEkraNLUv94eAaxn4v');
INSERT INTO SONG VALUES (135,'','https://www.youtube.com/embed/a9eHvgCsng8',3,7,'76P9PzvAk51CqtOeCIEGBQ');
INSERT INTO SONG VALUES (136,'','https://www.youtube.com/embed/gh2B1RtJbXg',4,7,'1IkdRtsgZCtWIekX8NrLdN');
INSERT INTO SONG VALUES (137,'','https://www.youtube.com/embed/EHMF0xh_z3k',5,7,'6R6FlagrCC7HuFZnapXO5o');
INSERT INTO SONG VALUES (138,'','https://www.youtube.com/embed/hPFGRakaRuY',6,7,'2EQaWLbkUcZ92sLKQsSeDv');
INSERT INTO SONG VALUES (139,'','https://www.youtube.com/embed/QdVicDf3qbM',7,7,'6ipZiTWO0fuhs8lul00e4w');
INSERT INTO SONG VALUES (140,'','https://www.youtube.com/embed/nU-khJbkyk4',8,7,'6vhjkSvhOxU5ZyUshIAPCY');
INSERT INTO SONG VALUES (141,'','https://www.youtube.com/embed/-gc1moD2Y2w',9,7,'1GztRvzpFWGhe00N3jv91q');
INSERT INTO SONG VALUES (142,'','https://www.youtube.com/embed/ynQJ9otDE90',10,7,'1w09YJ2UvJvCR4q0W44snv');
INSERT INTO SONG VALUES (143,'','https://www.youtube.com/embed/t4J0rBzPh4s',11,7,'7ujVDENgCDD77JxBuw4Mhu');
INSERT INTO SONG VALUES (144,'','https://www.youtube.com/embed/kVpWes8MFm4',12,7,'5hyHsOQUnWQMBPWX8KZuID');
INSERT INTO SONG VALUES (145,'','https://www.youtube.com/embed/LXtYMZ4LZvc',13,7,'3SYqmao3YLyGYzmvBJ7Bhe');
INSERT INTO SONG VALUES (146,'','https://www.youtube.com/embed/wJqdwRSARWg',14,7,'5EGIJVtcmlFdw21fTwGf3u');
INSERT INTO SONG VALUES (147,'','https://www.youtube.com/embed/M5aEiDSx7kI',15,7,'5ocSQW5sIUIOFojwXEz9Ki');
INSERT INTO SONG VALUES (148,'','https://www.youtube.com/embed/zkvhVYJvErU',16,7,'53svtkdl7Hl0RZgAuTgON8');
INSERT INTO SONG VALUES (149,'','https://www.youtube.com/embed/SHAQlFq6TFg',17,7,'6SaeXxdt0Id6ZzmX0ZGTQK');
INSERT INTO SONG VALUES (150,'','https://www.youtube.com/embed/_EJUDRpvIs0',18,7,'2Sv7RMNFfNofAOmA32mLA4');
INSERT INTO SONG VALUES (151,'','https://www.youtube.com/embed/EqaVNi6SHZc',19,7,'7G0bBRiFDs1sDsiRqzZbmT');
INSERT INTO SONG VALUES (152,'','https://www.youtube.com/embed/x7n9kcxBiuw',20,7,'4xw1SakICm1K8xgeLdElyB');
INSERT INTO SONG VALUES (153,'','https://www.youtube.com/embed/NiyJgOcBBqo',21,7,'070bDNenZlWcjzZGAc2npp');
INSERT INTO SONG VALUES (154,'','https://www.youtube.com/embed/4RWfSUWVP2I',22,7,'6TSM5vkz0WzyZsNAKKYDcw');
INSERT INTO SONG VALUES (155,'','https://www.youtube.com/embed/4ht80uzIhNs',23,7,'0h9SUGpAofhus8HUgNXVwW');
INSERT INTO SONG VALUES (156,'','https://www.youtube.com/embed/LeiFF0gvqcc',24,7,'4jnFqNWeJCeCRHc4HCdxfd');
INSERT INTO SONG VALUES (157,'','https://www.youtube.com/embed/VUvtlmlBbDg',25,7,'3HGE6Is63CrKHS9DZ26RIO');
INSERT INTO SONG VALUES (158,'','https://www.youtube.com/embed/IXIDl_5XcQw',26,7,'3Xtn6ND8fGALF41WWztGF1');
INSERT INTO SONG VALUES (159,'','https://www.youtube.com/embed/nmZCDBUIzhI',0,8,'45SiHmjLBcPWFsNFzB547Y');
INSERT INTO SONG VALUES (160,'','https://www.youtube.com/embed/VDhfK2EYfeY',1,8,'1hkPTehvUqLaidlQUOfDmP');
INSERT INTO SONG VALUES (161,'','https://www.youtube.com/embed/yV6786cwS-s',2,8,'4QySScdQnRDZjDaAdpY0AM');
INSERT INTO SONG VALUES (162,'','https://www.youtube.com/embed/3gO1aG0gTeI',3,8,'3lgG9DGpDpR1VUH9ACi1EE');
INSERT INTO SONG VALUES (163,'','https://www.youtube.com/embed/fJfuMtK_yug',4,8,'3g1ekuXAKuFuEfarqTIxIH');
INSERT INTO SONG VALUES (164,'','https://www.youtube.com/embed/et8yMXGkCMI',5,8,'1UwD1ovEx84rBdpJRJt99O');
INSERT INTO SONG VALUES (165,'','https://www.youtube.com/embed/Z2L5uqXMGOc',6,8,'3b2DShkYT32XIVmybU1xmf');
INSERT INTO SONG VALUES (166,'','https://www.youtube.com/embed/SgoZUHO4uMc',7,8,'2vMMyG4iw5OppGOh23kXIe');
INSERT INTO SONG VALUES (167,'','https://www.youtube.com/embed/pz-J1sPJjzA',8,8,'1rVP30BW6y7uA8iJrp7wl1');
INSERT INTO SONG VALUES (168,'','https://www.youtube.com/embed/JnzqAhOfDAw',9,8,'1uzaFntXR5Q9K99LlduyhP');
INSERT INTO SONG VALUES (169,'','https://www.youtube.com/embed/pUMlv14M5MQ',10,8,'18iyA5BPmU3Htj2YZnMHdo');
INSERT INTO SONG VALUES (170,'','https://www.youtube.com/embed/J5PrBdnHEhQ',11,8,'0beJBpWGM17KeMTI5v1SBS');
INSERT INTO SONG VALUES (171,'','https://www.youtube.com/embed/stT2gYRvTf8',12,8,'7i6h8cg9E1Z7Dyy48gj2kw');
INSERT INTO SONG VALUES (172,'','https://www.youtube.com/embed/p9hZ6spg1PY',13,8,'2dbx9A36sJQXrBWQtI4Fsl');
INSERT INTO SONG VALUES (173,'','https://www.youtube.com/embed/LJLB5JqdPc0',14,8,'64KIbKLoCuMATvUM9laI91');
INSERT INTO SONG VALUES (174,'','https://www.youtube.com/embed/0bbpI9D9FDE',15,8,'67t5MpxDL4XREv387RPyYT');
INSERT INTO SONG VALUES (175,'','https://www.youtube.com/embed/csILUDfmtqM',16,8,'0juMDnoo3u3uDJ32wjK2BF');
INSERT INTO SONG VALUES (176,'초반 20초만 유명한 곡. 후반 리듬을 처음 들어보시는 분들도 많을 것 같아요. 후반부의 몽환적인 리듬을 느껴보세요. 몸이 나른해 질 거에요 ~.~','https://www.youtube.com/embed/oRGDhgITetc',0,9,'7DcJ6fEBb7BaKuYKTwiDxK');
INSERT INTO SONG VALUES (177,'','https://www.youtube.com/embed/r_zDx_TwljU',1,9,'3cqZ2Vsxt5Gi5ZLx3h5DAW');
INSERT INTO SONG VALUES (178,'','https://www.youtube.com/embed/D1v3_8xVha8',2,9,'2bTvNKT8bxyyPhzHu4A2Wx');
INSERT INTO SONG VALUES (179,'','https://www.youtube.com/embed/-N4jf6rtyuw',3,9,'1vxw6aYJls2oq3gW0DujAo');
INSERT INTO SONG VALUES (180,'','https://www.youtube.com/embed/hmsyIT8OVZk',4,9,'4ZaRg5Sf4TKr0YcFRLh7QJ');
INSERT INTO SONG VALUES (181,'','https://www.youtube.com/embed/-E-_IRJU5w0',5,9,'6KfoDhO4XUWSbnyKjNp9c4');
INSERT INTO SONG VALUES (182,'','https://www.youtube.com/embed/JXgiOvHU0AY',6,9,'1WCOna34eEMPgjfOOZkGQc');
INSERT INTO SONG VALUES (183,'','https://www.youtube.com/embed/CX5f0NcqlMs',7,9,'6Dg2RJihNlbkLSmtXY3p5f');
INSERT INTO SONG VALUES (184,'','https://www.youtube.com/embed/4NRXx6U8ABQ',8,9,'0VjIjW4GlUZAMYd2vXMi3b');
INSERT INTO SONG VALUES (185,'','https://www.youtube.com/embed/kxgj5af8zg4',9,9,'2SLwbpExuoBDZBpjfefCtV');
INSERT INTO SONG VALUES (186,'','https://www.youtube.com/embed/DyWgcE9EpKw',10,9,'2QYnONicU24TXbkhtaemOM');
INSERT INTO SONG VALUES (187,'요즘 내 최애곡 ㅠ^ㅠ','https://www.youtube.com/embed/qiqT0rJ7zIo',11,9,'6dquCx5KAW5jCgGgoTlghL');
INSERT INTO SONG VALUES (188,'','https://www.youtube.com/embed/J_QGZspO4gg',12,9,'7uoFMmxln0GPXQ0AcCBXRq');
INSERT INTO SONG VALUES (189,'','https://www.youtube.com/embed/lukT_WB5IB0',13,9,'3oUEzTAoOxqZHN4xiqTGqJ');
INSERT INTO SONG VALUES (190,'','https://www.youtube.com/embed/n-UIRqgXjGA',14,9,'0O6u0VJ46W86TxN9wgyqDj');
INSERT INTO SONG VALUES (191,'','https://www.youtube.com/embed/OQiy0vk6Ss4',15,9,'1RBIzko2PMY5CP0d3MIkwl');
INSERT INTO SONG VALUES (192,'','https://www.youtube.com/embed/-oaddU3pPdA',0,10,'2SL6pRmKNyug2DqhoVjVXq');
INSERT INTO SONG VALUES (193,'','https://www.youtube.com/embed/wfCcs0vLysk',1,10,'64yajM6CxtLghmgB53VeXT');
INSERT INTO SONG VALUES (194,'','https://www.youtube.com/embed/1tk1pqwrOys',2,10,'6y4GYuZszeXNOXuBFsJlos');
INSERT INTO SONG VALUES (195,'','https://www.youtube.com/embed/gsT6eKsnT0M',3,10,'6sIx7Cn37DGEhjy9hBP8Gx');
INSERT INTO SONG VALUES (196,'','https://www.youtube.com/embed/jJzw1h5CR-I',4,10,'72uSoNIf7eScfGZFQjNHrR');
INSERT INTO SONG VALUES (197,'','https://www.youtube.com/embed/xGbxsiBZGPI',5,10,'1XT0cpl9g0GuRQJao2nqXd');
INSERT INTO SONG VALUES (198,'','https://www.youtube.com/embed/9MjAJSoaoSo',6,10,'2iOvMtA1u9s95NF6mJDOuT');
INSERT INTO SONG VALUES (199,'스즈메 고양이 귀여워.. 근데 무서워.. 근데 귀여워 ..','https://www.youtube.com/embed/5mvCVJIZWtA',7,10,'7LHAKF7pBqHch8o6Yo0ad5');
INSERT INTO SONG VALUES (200,'','https://www.youtube.com/embed/7HgJIAUtICU',8,10,'1YXot2MLAG9sttepCtBRM7');
INSERT INTO SONG VALUES (201,'','https://www.youtube.com/embed/uOv48wstbgY',9,10,'2iXZA6Ecf9AZHw92tZBNLv');
INSERT INTO SONG VALUES (202,'','https://www.youtube.com/embed/olWvy0PiLfA',10,10,'7163xpL9SvNzMY6tk7nL8L');
INSERT INTO SONG VALUES (203,'','https://www.youtube.com/embed/4Pls29qqg6Y',11,10,'4W3rP2KZkKEykdWvlWLgyc');
INSERT INTO SONG VALUES (204,'','https://www.youtube.com/embed/pLBX9vdrtn4',12,10,'5Rqj6lHkIkKSD3OUgae6bw');
INSERT INTO SONG VALUES (205,'','https://www.youtube.com/embed/Y732jibDixc',13,10,'0jyxo8MlRDZu0S0e7yUBDD');
INSERT INTO SONG VALUES (206,'','https://www.youtube.com/embed/ZRtdQ81jPUQ',14,10,'1hAloWiinXLPQUJxrJReb1');
INSERT INTO SONG VALUES (207,'','https://www.youtube.com/embed/oZpYEEcvu5I',15,10,'2cxcqKwQtfKq7giphxjzOu');
INSERT INTO SONG VALUES (208,'여름에 한 상쾌함 합니다!','https://www.youtube.com/embed/jzxJkfcYCDs',0,11,'1uhx7CG8DLhCkAV0IoqYCe');
INSERT INTO SONG VALUES (209,'','https://www.youtube.com/embed/Y01d2hLvsM0',1,11,'6q5qD963d6AuwUF7NAcVhl');
INSERT INTO SONG VALUES (210,'','https://www.youtube.com/embed/YJInKpVsBQA',2,11,'6GI5AwV6rXiAItDCA822NS');
INSERT INTO SONG VALUES (211,'','https://www.youtube.com/embed/-hlxyeiTvNc',3,11,'3VwwxnQlYfAIIIWwgvdAWR');
INSERT INTO SONG VALUES (212,'','https://www.youtube.com/embed/l9RvsMrk_l4',4,11,'2IMPPA9UZpqTnnVIy9lDHU');
INSERT INTO SONG VALUES (213,'','https://www.youtube.com/embed/ZHFxEnxq9Rs',5,11,'7mlPsRdAV93pgaoZcc0KI0');
INSERT INTO SONG VALUES (214,'','https://www.youtube.com/embed/XBVauz0iN8c',6,11,'05jnwo3kEZaHL5uOM0Enfx');
INSERT INTO SONG VALUES (215,'썸녀/썸남에게 불러주면 바로 넘어올 수밖에 없는 노래 \ ^오^ /','https://www.youtube.com/embed/VmpAhOuLNlE',7,11,'4BcyvGnKg8DaHfXAjzFqhs');

COMMIT;
