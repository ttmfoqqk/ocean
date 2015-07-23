/* 
/*userId Į�� ���� ����*/
alter table [OCEAN_USER_MEMBER] alter column [UserId] varchar(320) null
/*userName(first name) Į�� ���� ����*/
alter table [OCEAN_USER_MEMBER] alter column [UserName] varchar(100) null

/*�ɹ� lastName,hphone,phone Į�� �߰�*/
alter table [OCEAN_USER_MEMBER] add [UserNameLast] varchar(100) null
alter table [OCEAN_USER_MEMBER] add [UserHPhone] varchar(200) null
alter table [OCEAN_USER_MEMBER] add [UserPhone] varchar(200) null

/*����ɹ� Country,bigo Į�� �߰�*/
alter table [OCEAN_MEMBERSHIP] add [Country] varchar(100) null
alter table [OCEAN_MEMBERSHIP] add [bigo] TEXT null
alter table [OCEAN_MEMBERSHIP] add [addr] varchar(max) null




/*OCEAN_BOARD ���� Į�� �߰�*/
alter table [OCEAN_BOARD] add [status] INT null

/*OCEAN_BOARD file Į�� �߰� - ������*/
alter table [OCEAN_BOARD] add [File_name11] varchar(200) null


/*Ŀ�´�Ƽ Ű ����*/
INSERT INTO [keti].[dbo].[OCEAN_BOARD_CODE]([Type],[Name],[UseLv],[State],[Order],[Replylfg],[CommentFg])VALUES('NOTICE','Ŀ�´�Ƽ',0,0,30,0,0)


/*�����ڵ� ���� Ű, ������ ����*/
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE1]([Name],[Order],[Bigo],[UsFg])VALUES('����',40,'',0)
DECLARE @IDENTITY INT 
SET @IDENTITY = SCOPE_IDENTITY()
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'korea',0,0,'')

INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE1]([Name],[Order],[Bigo],[UsFg])VALUES('������',50,'',0)
DECLARE @IDENTITY INT 
SET @IDENTITY = SCOPE_IDENTITY()
INSERT INTO [keti].[dbo].[OCEAN_COMM_CODE2]([PIdx],[Name],[Order],[UsFg],[Bigo])VALUES(@IDENTITY,'5',0,0,'')



/* 
	OCEAN_MEMBERSHIP_V üũ
	
	OCEAN_BOARD_CONT_L ����
	OCEAN_BOARD_CONT_V ����
	OCEAN_BOARD_CONT_P ����
	OCEAN_BOARD_CONT_MINI_L ����
	
	OCEAN_USER_MEMBER_P ����
	OCEAN_USER_MEMBER_L ����
	OCEAN_USER_MEMBER_LOGIN ����
	OCEAN_USER_MEMBER_CEO_STATE ����
	ocean_user_member_search ����
	
	OCEAN_MEMBERSHIP_V ����
	OCEAN_MEMBERSHIP_L ����
*/

*/