USE [ocean]
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_USER_MEMBER_P]    Script Date: 08/12/2015 14:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SPWEB
-- Create date: 2012-09-20
-- Description:	회원 입력/수정/삭제
-- =============================================
ALTER PROCEDURE [dbo].[OCEAN_USER_MEMBER_P]
	 @actType		VARCHAR(20)	= ''
	,@UserIdx		INT			= 0
	,@UserId		VARCHAR(50)	= ''
	,@FirstName		VARCHAR(50)	= ''
	,@LastName		VARCHAR(50)	= ''
	,@UserPass		VARCHAR(50)	= ''
	,@NewUserPass	VARCHAR(50)	= ''
	,@UserDelFg		INT			= 0
	,@UserBigo		TEXT		= ''
	,@UserHPhone	VARCHAR(50)  = ''
	,@UserPhone		VARCHAR(50)  = ''
	,@userPosition	VARCHAR(200)  = ''
	
	,@companySelect	VARCHAR(50) = ''
	,@userState		INT			= 1		-- 0:승인 , 1:승인요청 , 2:대표승인
	,@ceoFg			INT			= 0
	,@DELETE_ADMIN_KEY	INT		= 1
	
	-- 신규회원가입에 회사 입력 만들기
	
	,@cName			varchar(200)	= ''
	,@Country		varchar(100)	= ''
	,@addr			varchar(max)	= ''
	,@cPhone		varchar(200)	= ''
	,@homepage		varchar(200)	= ''
	,@cStaff		varchar(200)	= ''
	,@business		varchar(200)	= ''
	,@business1		int				= 0
	,@business2		int				= 0
	,@business3		int				= 0
	,@business4		int				= 0
	,@business5		int				= 0
	,@business6		int				= 0
	,@business7		int				= 0
	,@business8		int				= 0
	,@business9		int				= 0
	,@business10	int				= 0
	,@business11	int				= 0
	,@business12	int				= 0
	,@bigo			TEXT			= ''
	,@files2		varchar(200)	= ''
	,@State			int				= 0		/* 0:정상 ,1:삭제, ..  */
	,@order			int				= 100
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @IN_CNT INT ,@CO_CNT INT , @EMAIL VARCHAR(200)
	DECLARE @CEO_FG INT
	
	SET @CEO_FG = 0
	SET @CO_CNT = 0
	SET @EMAIL = ''
	
	IF @actType = 'INSERT' 
		BEGIN
		
		SET @IN_CNT = (SELECT COUNT(*) FROM [dbo].[OCEAN_USER_MEMBER] WHERE [UserId] = @UserId and [UserDelFg] = 0)
		
		
		IF @companySelect = 'NEW'
		BEGIN
			SET @CO_CNT = (SELECT COUNT(*) FROM [dbo].[OCEAN_MEMBERSHIP] WHERE [cName] = @cName and [State] = 0)
		END
		
		
		DECLARE @IDENTITY INT ,@USER_IDENTITY INT
		SET @USER_IDENTITY = 0
		
		IF @IN_CNT = 0 AND @CO_CNT = 0 AND @companySelect = 'NEW'
		BEGIN
			
			INSERT INTO [dbo].[OCEAN_MEMBERSHIP](
				 [cName]
				,[addr]
				,[cPhone]
				,[homepage]
				,[cStaff]
				,[business]
				,[business1]
				,[business2]
				,[business3]
				,[business4]
				,[business5]
				,[business6]
				,[business7]
				,[business8]
				,[business9]
				,[business10]
				,[business11]
				,[business12]
				,[files2]
				,[Country]
				,[bigo]
				,[State]
				,[inDate]
				,[order]
			)VALUES(
				 @cName
				,@addr
				,@cPhone
				,@homepage
				,@cStaff
				,@business
				,@business1
				,@business2
				,@business3
				,@business4
				,@business5
				,@business6
				,@business7
				,@business8
				,@business9
				,@business10
				,@business11
				,@business12
				,@files2
				,@Country
				,@bigo
				,@State
				,GETDATE()
				,@order
			)
			
			SET @IDENTITY = SCOPE_IDENTITY()
			SET @CEO_FG   = 1
			
		END
		
		
		IF @IN_CNT = 0 AND @CO_CNT = 0
			BEGIN
		
			INSERT INTO [dbo].[OCEAN_USER_MEMBER](
				 [UserId]
				,[UserName]
				,[UserNameLast]
				,[UserPass]
				,[UserIndate]
				,[UserDelFg]
				,[UserHPhone]
				,[UserPhone]
				,[companyIdx]
				,[state]
				,[ceo]
				,[UserPOsition]
			)VALUES(
				 @UserId
				,@FirstName
				,@LastName
				,pwdencrypt(@UserPass)
				,GETDATE()
				,@UserDelFg
				,@UserHPhone
				,@UserPhone
				,(CASE @companySelect WHEN 'NEW' THEN @IDENTITY ELSE @companySelect END)
				,(case @CEO_FG WHEN 1 THEN 3 ELSE @userState END)
				,@CEO_FG
				,@userPosition
			)
			SET @USER_IDENTITY = SCOPE_IDENTITY()
			
			IF @CEO_FG = 0 
			BEGIN
				SET @EMAIL = (SELECT TOP 1 [UserId] FROM [dbo].[OCEAN_USER_MEMBER] WHERE [companyIdx] = @companySelect AND [UserDelFg] = 0 AND [state] = 0 AND [ceo] = 1 )
			END
			
			
		END
		
	END
	ELSE IF @actType = 'UPDATE'
		BEGIN
		
		IF @ceoFg = 1
		BEGIN
			SET @CEO_FG = (SELECT COUNT(*) FROM [dbo].[OCEAN_USER_MEMBER] WHERE [companyIdx] = @companySelect AND [UserDelFg] = 0 AND [state] = 0 AND [ceo] = 1 and [UserIdx] != @UserIdx)
		END
		ELSE
		BEGIN
			SET @CEO_FG = 0
		END
		
		SET @IN_CNT = (SELECT COUNT(*) FROM [dbo].[OCEAN_USER_MEMBER] WHERE [UserId] = @UserId and [UserDelFg] = 0 and [UserIdx] != @UserIdx)
		
		IF @CEO_FG = 0 AND @IN_CNT = 0
		BEGIN
			UPDATE [dbo].[OCEAN_USER_MEMBER] SET
				 [UserId]		= @UserId
				,[UserBigo]		= @UserBigo
				,[UserDelFg]	= @UserDelFg
				,[UserHPhone]	= @UserHPhone
				,[UserPhone]	= @UserPhone
				,[companyIdx]	= @companySelect
				,[state]		= @userState
				,[ceo]			= @ceoFg
				,[UserPOsition]	= @userPosition
			WHERE [UserIdx] = @UserIdx
			
			IF @DELETE_ADMIN_KEY = 0 AND @NewUserPass <> ''
				BEGIN
				
				UPDATE [dbo].[OCEAN_USER_MEMBER] SET
					 [UserPass] = pwdencrypt(@NewUserPass)
				WHERE [UserIdx] = @UserIdx
			END
		END
	END
	
	ELSE IF @actType = 'INFO_UPDATE'
		BEGIN
		
		UPDATE [dbo].[OCEAN_USER_MEMBER] SET
			 [UserName]		= @FirstName
			,[UserNameLast]	= @LastName
			,[UserHPhone]	= @UserHPhone
			,[UserPhone]	= @UserPhone
			,[UserPOsition]	= @userPosition
		WHERE [UserIdx] = @UserIdx

	END
	
	ELSE IF @actType = 'ID_UPDATE'
		BEGIN
		/*
			중복아이디 체크
		*/
		SET @IN_CNT = (SELECT COUNT(*) FROM [dbo].[OCEAN_USER_MEMBER] WHERE [UserId] = @UserId and [UserDelFg] = 0 and [UserIdx] != @UserIdx)
		
		IF @IN_CNT = 0
		BEGIN
			UPDATE [dbo].[OCEAN_USER_MEMBER] SET
				 [UserId]		= @UserId
				,[UserName]		= @FirstName
				,[UserNameLast]	= @LastName
				,[UserHPhone]	= @UserHPhone
				,[UserPhone]	= @UserPhone
				,[UserPOsition]	= @userPosition
			WHERE [UserIdx] = @UserIdx
		END

	END
	
	ELSE IF @actType = 'PWUPDATE'
	BEGIN
		SET @IN_CNT = (
			SELECT pwdcompare(@UserPass,[UserPass]) 
			FROM [dbo].[OCEAN_USER_MEMBER] 
			WHERE [UserIdx] = @UserIdx
		)
		SET @EMAIL = (SELECT [UserId] FROM [dbo].[OCEAN_USER_MEMBER] WHERE [UserIdx] = @UserIdx)
				
		IF @IN_CNT = 1
		BEGIN
			UPDATE [dbo].[OCEAN_USER_MEMBER] SET
				[UserPass] = pwdencrypt(@NewUserPass)
			where [UserIdx] = @UserIdx
		END
	END
	
	ELSE IF @actType = 'S_PWD'
	BEGIN
		
		UPDATE [dbo].[OCEAN_USER_MEMBER] SET
			[UserPass] = pwdencrypt(@NewUserPass)
		where [UserIdx] = @UserIdx

	END
	
	ELSE IF @actType = 'DELETE'
		BEGIN
		SET @EMAIL = (SELECT [UserId] FROM [dbo].[OCEAN_USER_MEMBER] WHERE [UserIdx] = @UserIdx)
		/*
		SET @IN_CNT = (
			CASE @DELETE_ADMIN_KEY
			WHEN 0 THEN 1
			ELSE(
				SELECT pwdcompare(@UserPass,[UserPass]) 
				FROM [dbo].[OCEAN_USER_MEMBER] 
				WHERE [UserIdx] = @UserIdx
				)
			END
		)
		*/
		
		--IF @IN_CNT = 1 
		--BEGIN
			UPDATE [dbo].[OCEAN_USER_MEMBER] SET
				 [UserOutdate]	= GETDATE()
				,[UserDelFg]	= 1
			WHERE [UserIdx] = @UserIdx
		--END
	END
	
	ELSE IF @actType = 'DELETE_DATA'
		BEGIN
		-- update 로 변경시 [DataDelFg] 사용 [UserDelFg] 도 같이 update 탈퇴 처리
		DELETE FROM [dbo].[OCEAN_USER_MEMBER] WHERE [UserIdx] = @UserIdx
	END
	
	SELECT @IN_CNT AS [IN_CNT],@EMAIL AS [EMAIL],@CO_CNT AS [CO_CNT] , @CEO_FG AS [CEO_FG] , @USER_IDENTITY AS [USER_IDENTITY]

END

