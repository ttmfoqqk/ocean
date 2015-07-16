/* 
/*userId 칼럼 길이 변경*/
alter table [OCEAN_USER_MEMBER] alter column [UserId] varchar(320) null

/*커뮤니티 키 생성*/
INSERT INTO [dbo].[OCEAN_BOARD_CODE]([Type],[Name],[UseLv],[State],[Order],[Replylfg],[CommentFg])VALUES('NOTICE','커뮤니티',0,0,30,0,0)

/*OCEAN_BOARD 상태 칼럼 추가*/
alter table [OCEAN_BOARD] add [status] INT null


/* 
	OCEAN_MEMBERSHIP_V 체크
	
	OCEAN_BOARD_CONT_L 수정
	OCEAN_BOARD_CONT_V 수정
	OCEAN_BOARD_CONT_P 수정
*/

*/