

-- 기존 시퀀스 삭제
DROP SEQUENCE seq_board;

-- 시퀀스 재생성
CREATE SEQUENCE seq_board
    START WITH 1          -- 시작 값
    INCREMENT BY 1        -- 증가 값
    NOCACHE               -- 시퀀스 캐싱 안함
    NOCYCLE;              -- 최대값 도달 시 다시 시작하지 않음



    
DECLARE
    v_userid VARCHAR2(50 BYTE);
    v_nickname VARCHAR2(50 BYTE);
    TYPE nickname_array IS VARRAY(10) OF VARCHAR2(50 BYTE);
    TYPE userid_array IS VARRAY(10) OF VARCHAR2(50 BYTE);
    v_nicknames nickname_array := nickname_array('토끼', '사자', '호랑이', '곰', '여우', '늑대', '고양이', '강아지', '코끼리', '기린');
    v_userids userid_array := userid_array('rabbit', 'lion', 'tiger', 'bear', 'fox', 'wolf', 'cat', 'dog', 'elephant', 'giraffe');
    v_index PLS_INTEGER;
    v_boardtypeno NUMBER;
    v_category VARCHAR2(20);
BEGIN
    FOR i IN 1..505 LOOP
        v_index := TRUNC(DBMS_RANDOM.VALUE(1, 11)); -- 1부터 10까지의 정수 생성
        v_userid := v_userids(v_index);
        v_nickname := v_nicknames(v_index);
        v_boardtypeno := TRUNC(DBMS_RANDOM.VALUE(1, 13)); -- 1부터 12까지의 정수 생성

        -- 카테고리 결정
        CASE MOD(i-1, 5) + 1
            WHEN 1 THEN v_category := '음식';
            WHEN 2 THEN v_category := '자동차';
            WHEN 3 THEN v_category := '장소';
            WHEN 4 THEN v_category := '핫딜';
            WHEN 5 THEN v_category := '행사';
        END CASE;

        INSERT INTO TBL_BOARD (
            BOARDNO, TITLE, CONTENT, USERID, NICKNAME, BOARDTYPENO, REGDATE, UPDATEDATE, VIEWS, LIKES, REPLYCOUNT
        ) VALUES (
            seq_board.NEXTVAL,
            '[' || v_category || '] 글제목-' || i,
            '글내용-' || i,
            v_userid,
            v_nickname,
            v_boardtypeno,
            SYSDATE,
            SYSDATE,
            0,
            0,
            0
        );
    END LOOP;
END;
/


INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 속초에서 캠핑을 하며 해돋이를 보았습니다. 저녁으로는 고등어구이를 해먹었어요.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 가평에서 캠핑을 하며 산 속에서 고기 구워 먹으며 여유를 만끽했습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 공주에서 캠핑을 하며 고즈넉한 풍경 속에서 삼겹살을 구워 먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 해남에서 캠핑을 하며 바다에서 잡은 해산물로 회를 떠서 먹었어요.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('서울 근교 남산에서 도심 속 캠핑을 즐기며 치맥으로 하루를 마무리했습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 통영에서 캠핑을 하며 통영굴을 맛보았습니다. 싱싱한 해산물이 정말 맛있었어요.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 평창에서 캠핑을 하며 평창한우 스테이크를 구워 먹었습니다. 고기가 정말 부드러웠어요.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 연천에서 캠핑을 하며 야외에서 떡볶이를 끓여 먹었습니다. 매콤한 떡볶이가 아주 맛있었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('제주도 우도에서 캠핑을 하며 전복죽으로 아침을 해결했습니다. 신선한 전복이 일품이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 보령에서 캠핑을 하며 바지락칼국수를 먹었습니다. 바지락이 정말 신선했어요.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 철원에서 캠핑을 하며 강원도 감자를 쪄서 먹었습니다. 고소한 맛이 일품이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 남양주에서 캠핑을 하며 고기 구워 먹으며 여유를 즐겼습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('부산 송정에서 캠핑을 하며 바다를 보며 고등어 구이를 해먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 울진에서 캠핑을 하며 국립공원의 자연을 만끽했습니다. 저녁으로는 전복구이를 해먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 예산에서 캠핑을 하며 예산사과로 만든 디저트를 즐겼습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 남원에서 캠핑을 하며 남원추어탕을 먹었습니다. 진한 국물 맛이 아주 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 파주에서 캠핑을 하며 김치찌개를 끓여 먹었습니다. 추운 날씨에 뜨거운 김치찌개가 아주 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 춘천에서 캠핑을 하며 춘천 닭갈비를 먹었습니다. 매콤한 닭갈비가 일품이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 평택에서 캠핑을 하며 한우로 만든 스테이크를 구워먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 영광에서 캠핑을 하며 굴비를 구워 먹었습니다. 신선한 굴비의 맛이 아주 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('제주도 성산일출봉에서 캠핑을 하며 아침 일출을 감상했습니다. 아침 식사로는 제주산 전복죽을 먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 대구에서 캠핑을 하며 대구막창을 구워먹었습니다. 특유의 쫄깃한 식감이 캠핑의 재미를 더했습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 보령에서 캠핑을 하며 보령머드를 체험하고 저녁으로는 바지락칼국수를 먹었습니다. 신선한 바지락의 맛이 일품이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 평창에서 캠핑을 하며 저녁에는 평창한우로 만든 스테이크를 구워먹었습니다. 부드럽고 진한 맛이 인상적이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 공주에서 캠핑을 하며 공주알밤으로 만든 간식을 즐겼습니다. 캠핑장에서 먹는 밤 간식은 정말 최고였습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 안산에서 캠핑을 하며 저녁으로 안산순대볶음을 해먹었습니다. 매콤하고 짭짤한 맛이 일품이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 남원에서 캠핑을 하며 남원추어탕을 먹었습니다. 진한 국물 맛이 아주 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 통영에서 캠핑을 하며 통영굴을 맛보았습니다. 싱싱한 해산물이 캠핑을 더욱 특별하게 만들어줬어요.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 양양에서 캠핑을 하며 양양송이버섯을 구워먹었습니다. 향긋한 버섯 향이 인상적이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('제주도 한라산에서 캠핑을 하며 한라봉 주스를 마셨습니다. 제주도의 상쾌한 공기와 잘 어울렸어요.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 단양에서 캠핑을 하며 단양마늘로 만든 요리를 즐겼습니다. 마늘향이 가득한 음식이 아주 맛있었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 하남에서 캠핑을 하며 하남돼지집에서 먹었던 삼겹살 맛이 기억에 남습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 해남에서 캠핑을 하며 해남배추로 만든 김치가 일품이었습니다. 김치와 함께 먹은 고기는 더욱 맛있었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 구미에서 캠핑을 하며 구미의 밤거리와 함께 한 치킨과 맥주가 일품이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('서울 남산에서 캠핑을 하며 도심 속에서의 휴식을 즐겼습니다. 저녁으로 먹은 치킨은 여느 때보다 맛있었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 의정부에서 캠핑을 하며 의정부부대찌개를 먹었습니다. 매콤한 국물 맛이 캠핑의 피로를 풀어줬습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 고창에서 캠핑을 하며 고창복분자로 만든 음료를 마셨습니다. 달콤한 복분자 맛이 인상적이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 김해에서 캠핑을 하며 김해의 전통시장에 들러 다양한 먹거리를 즐겼습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 춘천에서 캠핑을 하며 춘천막국수를 먹었습니다. 시원하고 깔끔한 맛이 캠핑의 즐거움을 더했습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('제주도 우도에서 캠핑을 하며 우도땅콩아이스크림을 먹었습니다. 땅콩의 고소한 맛이 일품이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 청주에서 캠핑을 하며 청주순댓국을 먹었습니다. 깊고 진한 국물 맛이 아주 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 용인에서 캠핑을 하며 용인의 자연 속에서 하루를 보냈습니다. 저녁으로는 된장찌개를 끓여 먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 여수에서 캠핑을 하며 여수밤바다를 보며 회를 떠서 먹었습니다. 신선한 해산물이 아주 맛있었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 포항에서 캠핑을 하며 포항물회로 더위를 식혔습니다. 시원한 물회 국물이 일품이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 양평에서 캠핑을 하며 양평 한우로 만든 스테이크를 구워먹었습니다. 고기의 맛이 아주 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 고성에서 캠핑을 하며 고성의 깨끗한 바닷가를 즐겼습니다. 저녁으로는 고등어 구이를 해먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 예산에서 캠핑을 하며 예산사과로 만든 디저트를 즐겼습니다. 사과의 달콤함이 아주 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 강진에서 캠핑을 하며 강진의 특산물로 만든 한정식을 먹었습니다. 풍성한 한정식이 캠핑을 더욱 특별하게 만들어줬습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 거창에서 캠핑을 하며 거창의 청정 자연 속에서 힐링했습니다. 저녁으로는 삼겹살을 구워 먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('제주도 서귀포에서 캠핑을 하며 서귀포 바다를 보며 제주도 전복구이를 즐겼습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 금산에서 캠핑을 하며 금산인삼으로 만든 음료를 마셨습니다. 인삼의 건강한 맛이 인상적이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 광주에서 캠핑을 하며 광주리버사이드에서 강변 산책을 즐겼습니다. 저녁으로는 바베큐를 해먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 함평에서 캠핑을 하며 함평나비축제를 즐겼습니다. 나비축제와 함께한 캠핑은 특별했습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 영천에서 캠핑을 하며 영천포도로 만든 와인을 마셨습니다. 달콤한 포도주가 캠핑의 낭만을 더해줬습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 가평에서 캠핑을 하며 가평잣으로 만든 음식을 즐겼습니다. 잣의 고소한 맛이 일품이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 정선에서 캠핑을 하며 정선아리랑을 들으며 하루를 보냈습니다. 저녁으로는 된장찌개를 끓여 먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 보은에서 캠핑을 하며 보은대추로 만든 간식을 즐겼습니다. 대추의 달콤한 맛이 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 영광에서 캠핑을 하며 영광굴비를 구워먹었습니다. 싱싱한 굴비의 맛이 아주 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 창원에서 캠핑을 하며 창원의 푸른 바다를 즐겼습니다. 저녁으로는 고기를 구워먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('제주도 중문에서 캠핑을 하며 중문관광단지를 둘러보았습니다. 저녁으로는 흑돼지 바베큐를 즐겼습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 홍성에서 캠핑을 하며 홍성 한우로 만든 요리를 즐겼습니다. 한우의 부드러운 맛이 아주 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 평택에서 캠핑을 하며 평택한우를 구워먹었습니다. 신선한 고기의 맛이 아주 일품이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 목포에서 캠핑을 하며 목포항에서 해산물을 사와 회를 떠 먹었습니다. 신선한 해산물이 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 공주에서 캠핑을 하며 공주알밤으로 만든 간식을 즐겼습니다. 캠핑장에서 먹는 밤 간식은 정말 최고였습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 안산에서 캠핑을 하며 저녁으로 안산순대볶음을 해먹었습니다. 매콤하고 짭짤한 맛이 일품이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 남원에서 캠핑을 하며 남원추어탕을 먹었습니다. 진한 국물 맛이 아주 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 통영에서 캠핑을 하며 통영굴을 맛보았습니다. 싱싱한 해산물이 캠핑을 더욱 특별하게 만들어줬어요.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 양양에서 캠핑을 하며 양양송이버섯을 구워먹었습니다. 향긋한 버섯 향이 인상적이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('제주도 한라산에서 캠핑을 하며 한라봉 주스를 마셨습니다. 제주도의 상쾌한 공기와 잘 어울렸어요.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 단양에서 캠핑을 하며 단양마늘로 만든 요리를 즐겼습니다. 마늘향이 가득한 음식이 아주 맛있었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 하남에서 캠핑을 하며 하남돼지집에서 먹었던 삼겹살 맛이 기억에 남습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 해남에서 캠핑을 하며 해남배추로 만든 김치가 일품이었습니다. 김치와 함께 먹은 고기는 더욱 맛있었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 구미에서 캠핑을 하며 구미의 밤거리와 함께 한 치킨과 맥주가 일품이었습니다.');

INSERT INTO TBL_BOARD (CONTENT) VALUES ('서울 남산에서 캠핑을 하며 도심 속에서의 휴식을 즐겼습니다. 저녁으로 먹은 치킨은 여느 때보다 맛있었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 의정부에서 캠핑을 하며 의정부부대찌개를 먹었습니다. 매콤한 국물 맛이 캠핑의 피로를 풀어줬습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 고창에서 캠핑을 하며 고창복분자로 만든 음료를 마셨습니다. 달콤한 복분자 맛이 인상적이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 김해에서 캠핑을 하며 김해의 전통시장에 들러 다양한 먹거리를 즐겼습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 춘천에서 캠핑을 하며 춘천막국수를 먹었습니다. 시원하고 깔끔한 맛이 캠핑의 즐거움을 더했습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('제주도 우도에서 캠핑을 하며 우도땅콩아이스크림을 먹었습니다. 땅콩의 고소한 맛이 일품이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 청주에서 캠핑을 하며 청주순댓국을 먹었습니다. 깊고 진한 국물 맛이 아주 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 용인에서 캠핑을 하며 용인의 자연 속에서 하루를 보냈습니다. 저녁으로는 된장찌개를 끓여 먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 여수에서 캠핑을 하며 여수밤바다를 보며 회를 떠서 먹었습니다. 신선한 해산물이 아주 맛있었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 포항에서 캠핑을 하며 포항물회로 더위를 식혔습니다. 시원한 물회 국물이 일품이었습니다.');

INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 양평에서 캠핑을 하며 양평 한우로 만든 스테이크를 구워먹었습니다. 고기의 맛이 아주 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 고성에서 캠핑을 하며 고성의 깨끗한 바닷가를 즐겼습니다. 저녁으로는 고등어 구이를 해먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 예산에서 캠핑을 하며 예산사과로 만든 디저트를 즐겼습니다. 사과의 달콤함이 아주 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 강진에서 캠핑을 하며 강진의 특산물로 만든 한정식을 먹었습니다. 풍성한 한정식이 캠핑을 더욱 특별하게 만들어줬습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 거창에서 캠핑을 하며 거창의 청정 자연 속에서 힐링했습니다. 저녁으로는 삼겹살을 구워 먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('제주도 서귀포에서 캠핑을 하며 서귀포 바다를 보며 제주도 전복구이를 즐겼습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 금산에서 캠핑을 하며 금산인삼으로 만든 음료를 마셨습니다. 인삼의 건강한 맛이 인상적이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 광주에서 캠핑을 하며 광주리버사이드에서 강변 산책을 즐겼습니다. 저녁으로는 바베큐를 해먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 함평에서 캠핑을 하며 함평나비축제를 즐겼습니다. 나비축제와 함께한 캠핑은 특별했습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 영천에서 캠핑을 하며 영천포도로 만든 와인을 마셨습니다. 달콤한 포도주가 캠핑의 낭만을 더해줬습니다.');

INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 가평에서 캠핑을 하며 가평잣으로 만든 음식을 즐겼습니다. 잣의 고소한 맛이 일품이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 정선에서 캠핑을 하며 정선아리랑을 들으며 하루를 보냈습니다. 저녁으로는 된장찌개를 끓여 먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 보은에서 캠핑을 하며 보은대추로 만든 간식을 즐겼습니다. 대추의 달콤한 맛이 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 영광에서 캠핑을 하며 영광굴비를 구워먹었습니다. 싱싱한 굴비의 맛이 아주 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 창원에서 캠핑을 하며 창원의 푸른 바다를 즐겼습니다. 저녁으로는 고기를 구워먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('제주도 중문에서 캠핑을 하며 중문관광단지를 둘러보았습니다. 저녁으로는 흑돼지 바베큐를 즐겼습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 홍성에서 캠핑을 하며 홍성 한우로 만든 요리를 즐겼습니다. 한우의 부드러운 맛이 아주 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 평택에서 캠핑을 하며 평택한우를 구워먹었습니다. 신선한 고기의 맛이 아주 일품이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 목포에서 캠핑을 하며 목포항에서 해산물을 사와 회를 떠 먹었습니다. 신선한 해산물이 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 경주에서 캠핑을 하며 경주의 역사 유적지를 둘러보았습니다. 저녁으로는 한식뷔페를 즐겼습니다.');

INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 고양에서 캠핑을 하며 고양시 일산호수를 따라 산책을 즐겼습니다. 저녁으로는 김밥을 먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 속초에서 캠핑을 하며 속초의 맛집을 탐방했습니다. 오징어순대를 먹으며 하루를 마무리했습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 서천에서 캠핑을 하며 서천의 자연을 만끽했습니다. 저녁으로는 해물탕을 끓여먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 완도에서 캠핑을 하며 완도의 바다를 즐겼습니다. 저녁으로는 신선한 회를 떠 먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('이번 주말 강원도 설악산으로 캠핑을 떠나려 합니다. 신형 카니발을 타고 떠나니 너무 편했어요. 저녁에는 불고기를 구워 먹을 예정입니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('부산 해운대에서 바닷가 캠핑을 즐겼어요. 파도 소리를 들으며 치맥을 즐겼습니다. 랜턴 빛이 은은하게 비추는 바다도 너무 멋졌어요.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 순천만에서의 캠핑은 정말 여유로웠습니다. 제네시스 GV80 덕분에 짐이 많아도 편하게 이동할 수 있었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 가평에서 가족들과 캠핑을 다녀왔습니다. 김치찌개를 끓여 먹었는데, 캠핑장에서 먹으니 더욱 맛있었어요.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('서울 근교 남산에서 간단히 캠핑을 즐겼습니다. 도시와 자연의 조화가 참 인상적이었고, 새우구이가 일품이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('울산 대왕암에서의 캠핑은 바다를 가까이에서 느낄 수 있어 좋았습니다. 아침 산책 후 라면으로 아침을 해결했습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 담양에서의 캠핑은 대나무 숲이 인상적이었습니다. 저녁에는 삼겹살을 구워 먹으며 휴식을 취했습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 대청호에서의 캠핑은 호수 전망이 정말 멋졌습니다. SUV로 가서 편하게 짐을 옮길 수 있었어요. 저녁엔 김밥을 싸서 먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 동해에서 새벽에 일어나 해돋이를 보았습니다. 프라이드 치킨과 맥주로 하루를 마무리했어요.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 안동에서 캠핑을 하며 전통적인 한국 문화를 느낄 수 있었습니다. 저녁으로는 된장찌개를 끓여 먹었어요.');

INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 포천에서 캠핑을 즐기며 근처 산을 등반했습니다. 산 정상에서 먹은 참치김밥은 잊을 수 없는 맛이었어요.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('제주도에서 캠핑을 하며 바다를 바라보며 하루를 보냈습니다. 전기차 덕분에 이동도 쉬웠고, 저녁으로는 고등어 구이를 해먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 서산에서 캠핑을 하며 서해 바다를 바라보았습니다. 노을이 지는 해변에서 수육을 먹으니 최고의 시간이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('부산 송정에서 캠핑을 즐기며 해변에서 BBQ 파티를 열었습니다. 맥주와 함께 한 여유로운 시간이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 울진에서 캠핑을 하며 국립공원의 자연을 만끽했습니다. 쏘렌토를 타고 드라이브도 즐겼습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('서울 한강변에서의 캠핑은 도시 속에서 즐기는 자연이 참 특별했습니다. 한강에서의 밤은 더욱 매력적이었고, 스팸 김치볶음밥이 아주 맛있었어요.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 철원에서 캠핑을 즐기며 비무장지대를 둘러보았습니다. 저녁엔 칼국수를 끓여먹었습니다. SUV 덕분에 이동도 편했습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 연천에서 캠핑을 하며 역사의 흔적을 느낄 수 있었습니다. 자연 속에서 떡볶이와 어묵탕으로 간단하게 식사를 해결했습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경남 거제도에서 캠핑을 하며 해변을 따라 걷다보니 저녁식사로 회를 떠서 먹었습니다. 신선한 해산물이 정말 최고였어요.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 평창에서 캠핑을 즐기며 산채비빔밥을 만들어 먹었습니다. 맑은 공기와 함께하니 음식이 더 맛있었어요.');

INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 남양주에서 캠핑을 하며 저녁으로 제육볶음을 해먹었습니다. 맛있는 음식과 함께한 자연 속의 시간이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 광주에서 캠핑을 하며 저녁으로 떡갈비를 구워먹었습니다. 그 후 남도의 매력을 느낄 수 있었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 문경에서 캠핑을 즐기며 전통 한옥에서 지내는 특별한 시간을 보냈습니다. 저녁으로는 따뜻한 삼계탕을 먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('제주도에서 캠핑을 하며 아침에 해장국으로 속을 달래고, 이후 드라이브를 즐겼습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 파주에서 캠핑을 하며 저녁에는 한우불고기를 구워먹었습니다. 고기의 맛이 정말 일품이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 예산에서 캠핑을 하며 자연 속에서 전복구이를 해먹었습니다. 해산물의 신선함이 캠핑을 더욱 특별하게 만들어줬어요.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 인제에서 캠핑을 즐기며 산속에서 느끼는 상쾌한 공기와 함께 아침에 김치찌개를 끓여먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('부산 태종대에서 캠핑을 하며 바다를 보며 하루를 보냈습니다. 저녁으로는 해산물 파스타를 요리했습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 나주에서 캠핑을 하며 나주곰탕을 먹었습니다. 따뜻하고 깊은 맛이 인상적이었어요.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 진주에서 캠핑을 하며 진주냉면을 먹었습니다. 시원하고 깔끔한 맛이 캠핑의 피로를 풀어줬습니다.');

INSERT INTO TBL_BOARD (CONTENT) VALUES ('경기도 이천에서 캠핑을 하며 저녁으로 이천쌀로 만든 쌀밥과 된장찌개를 먹었습니다. 고향의 맛이 느껴지는 시간이었어요.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 홍천에서 캠핑을 하며 저녁에는 홍천옥수수를 구워먹었습니다. 달콤하고 고소한 맛이 일품이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 태안에서 캠핑을 하며 해변에서의 아침을 즐겼습니다. 아침 식사로는 따뜻한 계란국을 끓여먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 창녕에서 캠핑을 하며 자연 속에서의 시간을 만끽했습니다. 저녁으로는 창녕양파를 곁들인 고기구이를 해먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('전라도 보성에서 캠핑을 하며 보성녹차밭을 둘러본 후 녹차라떼를 즐겼습니다. 녹차의 향이 정말 좋았습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('제주도 성산일출봉에서 캠핑을 하며 아침 일출을 감상했습니다. 아침 식사로는 제주산 전복죽을 먹었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('경상도 대구에서 캠핑을 하며 대구막창을 구워먹었습니다. 특유의 쫄깃한 식감이 캠핑의 재미를 더했습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('충청도 보령에서 캠핑을 하며 보령머드를 체험하고 저녁으로는 바지락칼국수를 먹었습니다. 신선한 바지락의 맛이 일품이었습니다.');
INSERT INTO TBL_BOARD (CONTENT) VALUES ('강원도 평창에서 캠핑을 하며 저녁에는 평창한우로 만든 스테이크를 구워먹었습니다. 부드럽고 진한 맛이 인상적이었습니다.');
