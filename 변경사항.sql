/* 
/*userId Į�� ���� ����*/
alter table [OCEAN_USER_MEMBER] alter column [UserId] varchar(320) null

/*Ŀ�´�Ƽ Ű ����*/
INSERT INTO [dbo].[OCEAN_BOARD_CODE]([Type],[Name],[UseLv],[State],[Order],[Replylfg],[CommentFg])VALUES('NOTICE','Ŀ�´�Ƽ',0,0,30,0,0)

/*OCEAN_BOARD ���� Į�� �߰�*/
alter table [OCEAN_BOARD] add [status] INT null


/* 
	OCEAN_MEMBERSHIP_V üũ
	
	OCEAN_BOARD_CONT_L ����
	OCEAN_BOARD_CONT_V ����
	OCEAN_BOARD_CONT_P ����
*/

*/