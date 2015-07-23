/* 
/*userId 칼럼 길이 변경*/
alter table [OCEAN_USER_MEMBER] alter column [UserId] varchar(320) null
/*userName(first name) 칼럼 길이 변경*/
alter table [OCEAN_USER_MEMBER] alter column [UserName] varchar(100) null

/*맴버 lastName,hphone,phone 칼럼 추가*/
alter table [OCEAN_USER_MEMBER] add [UserNameLast] varchar(100) null
alter table [OCEAN_USER_MEMBER] add [UserHPhone] varchar(200) null
alter table [OCEAN_USER_MEMBER] add [UserPhone] varchar(200) null

/*기업맴버 Country,bigo 칼럼 추가*/
alter table [OCEAN_MEMBERSHIP] add [Country] varchar(100) null
alter table [OCEAN_MEMBERSHIP] add [bigo] TEXT null
alter table [OCEAN_MEMBERSHIP] add [addr] varchar(max) null




/*OCEAN_BOARD 상태 칼럼 추가*/
alter table [OCEAN_BOARD] add [status] INT null

/*OCEAN_BOARD file 칼럼 추가 - 미적용*/
alter table [OCEAN_BOARD] add [File_name11] varchar(200) null


/*커뮤니티 키 생성*/
INSERT INTO [keti].[dbo].[OCEAN_BOARD_CODE]([Type],[Name],[UseLv],[State],[Order],[Replylfg],[CommentFg])VALUES('NOTICE','커뮤니티',0,0,30,0,0)


/*기초코드 국가 키, 직원수 생성*/
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE1]([Name],[Order],[Bigo],[UsFg])VALUES('국가',40,'',0)
DECLARE @IDENTITY INT 
SET @IDENTITY = SCOPE_IDENTITY()
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'korea',0,0,'')

INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE1]([Name],[Order],[Bigo],[UsFg])VALUES('직원수',50,'',0)
DECLARE @IDENTITY INT 
SET @IDENTITY = SCOPE_IDENTITY()
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'5',0,0,'')



/* 
	OCEAN_MEMBERSHIP_V 체크
	
	OCEAN_BOARD_CONT_L 수정
	OCEAN_BOARD_CONT_V 수정
	OCEAN_BOARD_CONT_P 수정
	OCEAN_BOARD_CONT_MINI_L 수정
	
	OCEAN_USER_MEMBER_P 수정
	OCEAN_USER_MEMBER_L 수정
	OCEAN_USER_MEMBER_LOGIN 수정
	OCEAN_USER_MEMBER_CEO_STATE 수정
	ocean_user_member_search 수정
	
	OCEAN_MEMBERSHIP_V 수정
	OCEAN_MEMBERSHIP_L 수정
*/

*/