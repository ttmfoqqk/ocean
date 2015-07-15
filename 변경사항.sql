/* userId 칼럼 길이 변경 
alter table [OCEAN_USER_MEMBER] alter column [UserId] varchar(320) null
*/

/* 커뮤니티 키 생성
INSERT INTO [dbo].[OCEAN_BOARD_CODE]([Type],[Name],[UseLv],[State],[Order],[Replylfg],[CommentFg])VALUES('NOTICE','커뮤니티',0,0,30,0,0)
*/