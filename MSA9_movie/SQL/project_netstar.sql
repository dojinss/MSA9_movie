DROP TABLE IF EXISTS `posts`;

CREATE TABLE `posts` (
	`post_no`		int	NOT NULL 	primary key auto_increment				COMMENT '게시글 번호',
	`keyword_no`	int	NOT NULL											COMMENT '키워드 번호',
	`user_no`		int	NOT NULL											COMMENT '회원번호',
	`content`		varchar(200)	NOT NULL								COMMENT '내용',
	`like`			int	NOT NULL	DEFAULT 0								COMMENT '좋아요',
	`reg_date`		timestamp		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '등록일자',
	`upd_date`		timestamp		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '수정일자'
);

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
	`user_no`		int				NOT NULL 	primary key auto_increment	COMMENT '회원번호',
	`rule_no`		int				NOT NULL	DEFAULT	1					COMMENT '권한번호',
	`user_id`		varchar(100)	NOT NULL								COMMENT '아이디',
	`user_pwd`		varchar(255)	NOT NULL								COMMENT '비밀번호',
	`email`			varchar(100)	NOT NULL								COMMENT '이메일',
	`profile_url`	varchar(255)	NULL									COMMENT '프로필이미지',
	`enabled`		boolean			NOT NULL	DEFAULT false				COMMENT '휴면여부',
	`reg_date`		timestamp		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '등록일자',
	`upd_date`		timestamp		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '수정일자'
);

DROP TABLE IF EXISTS `rules`;

CREATE TABLE `rules` (
	`rule_no`	int				NOT NULL primary key auto_increment	COMMENT '권한번호',
	`info`		varchar(100)	NOT NULL							COMMENT '권한이름'
);

/* 권환 정보 입력 */
insert into movie.rules (rule_no,info) values (1,'common_user');
insert into movie.rules (rule_no,info) values (2,'prime_user');
insert into movie.rules (rule_no,info) values (3,'admin_user');

DROP TABLE IF EXISTS `replies`;

CREATE TABLE `replies` (
	`reply_no`	int				NOT NULL primary key auto_increment		COMMENT '댓글id',
	`post_no`	int				NOT NULL								COMMENT '게시글 번호',
	`user_no`	int				NOT NULL								COMMENT '회원번호',
	`content`	varchar(200)	NOT NULL								COMMENT '댓글내용',
	`reg_date`	timestamp		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '등록일자',
	`upd_date`	timestamp		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '수정일자'
);

DROP TABLE IF EXISTS `movies`;

CREATE TABLE `movies` (
	`movie_no`	int				NOT NULL primary key auto_increment 	COMMENT '영화번호',
	`image_url`	varchar(255)	NOT NULL								COMMENT '이미지경로',
	`title`		varchar(255)	NOT NULL								COMMENT '제목',
	`cate`		varchar(100)	NOT NULL								COMMENT '장르',
	`content`	text			NOT NULL								COMMENT '내용',
	`cast`		varchar(255)	NOT NULL								COMMENT '출연진',
	`notice`	boolean			NOT NULL	DEFAULT false				COMMENT '공지사항여부',
	`reg_date`	TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '등록일자',
	`upd_date`	TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '수정일자'
);

DROP TABLE IF EXISTS `ads`;

CREATE TABLE `ads` (
	`ad_no`			int			NOT NULL	primary key auto_increment		COMMENT '광고번호',
    `keyword_no`	int			NOT NULL									COMMENT '키워드번호',
	`prime_no`		int			NOT NULL									COMMENT '광고주번호',
	`content`		text		NOT NULL									COMMENT '내용',
	`reg_date`		TIMESTAMP	NOT NULL	DEFAULT CURRENT_TIMESTAMP		COMMENT '등록일자',
	`upd_date`		TIMESTAMP	NOT NULL	DEFAULT CURRENT_TIMESTAMP		COMMENT '수정일자'
);

DROP TABLE IF EXISTS `keywords`;

CREATE TABLE `keywords` (
	`keyword_no`	int				NOT NULL	primary key auto_increment	COMMENT '키워드번호',
	`movie_no`		int				NOT NULL								COMMENT '영화번호',
	`title`			varchar(255)	NOT NULL								COMMENT '키워드명',
	`type`			varchar(100)	NOT NULL								COMMENT '종류',
	`image_url`		varchar(255)	NOT NULL								COMMENT '이미지경로',
	`content`		text			NOT NULL								COMMENT '내용',
    `reg_date`		timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP		COMMENT '등록일자',
	`upd_date`		timestamp	NOT NULL	DEFAULT CURRENT_TIMESTAMP		COMMENT '수정일자'
);

DROP TABLE IF EXISTS `files`;

CREATE TABLE `files` (
	`file_no`	int				NOT NULL	primary key auto_increment		COMMENT '파일번호',
	`post_no`	int				NOT NULL									COMMENT '게시글 번호',
	`file_url`	varchar(255)	NOT NULL									COMMENT '파일경로',
	`reg_date`	timestamp		NOT NULL	DEFAULT CURRENT_TIMESTAMP		COMMENT '등록일자',
	`upd_date`	timestamp		NOT NULL	DEFAULT CURRENT_TIMESTAMP		COMMENT '수정일자'
);

DROP TABLE IF EXISTS `primes`;

CREATE TABLE `primes` (
	`prime_no`		int				NOT NULL	primary key auto_increment	COMMENT '광고주번호',
	`ad_info_no`	int				NOT NULL								COMMENT '광고정보번호',
	`user_no`		int				NOT NULL								COMMENT '회원번호',
	`name`			varchar(100)	NOT NULL								COMMENT '사업자명',
    `image_url`		varchar(255)	NOT NULL								COMMENT '이미지경로',
	`number`		varchar(255)	NOT NULL								COMMENT '사업자등록번호',
	`addr`			VARCHAR(255)	NOT NULL								COMMENT '주소',
	`start_time`	TIMESTAMP		NOT NULL								COMMENT '시작일자',
	`end_time`		TIMESTAMP		NOT NULL								COMMENT '종료일자',
	`reg_date`		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '등록일자',
	`upd_date`		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '수정일자'
);

DROP TABLE IF EXISTS `tokens`;

CREATE TABLE `tokens` (
	`token_no`	int				NOT NULL	primary key auto_increment	COMMENT '토큰번호',
	`user_no`	int				NOT NULL								COMMENT '회원번호',
	`token`		varchar(255)	NOT NULL								COMMENT '토큰',
	`reg_date`	timestamp		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '등록일자',
	`upd_date`	timestamp		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '수정일자'
);

DROP TABLE IF EXISTS `ad_infos`;

CREATE TABLE `ad_infos` (
	`ad_info_no`	int			NOT NULL	primary key auto_increment	COMMENT '광고정보번호',
	`price`			int			NOT NULL								COMMENT '금액',
	`type`			varchar(10)	NOT NULL								COMMENT '타입(month/year)',
	`content`		text		NOT NULL								COMMENT '내용'
);

DROP TABLE IF EXISTS `popups`;

CREATE TABLE `popups` (
	`popup_no`		int				NOT NULL	primary key auto_increment	COMMENT '팝업번호',
	`image_url`		varchar(255)	NOT NULL								COMMENT '이미지경로',
	`content`		text			NOT NULL								COMMENT '내용',
	`start_time`	TIMESTAMP		NOT NULL								COMMENT '사작일자',
	`end_time`		TIMESTAMP		NOT NULL								COMMENT '종료일자',
	`reg_date`		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '등록일자',
	`upd_date`		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP	COMMENT '수정일자'
);


