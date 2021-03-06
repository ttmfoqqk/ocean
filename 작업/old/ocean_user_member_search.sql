USE [ocean]
GO
/****** Object:  StoredProcedure [dbo].[ocean_user_member_search]    Script Date: 08/05/2015 16:26:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SPWEB
-- Create date: 2014-12-15
-- Description:	회원 정보 찾기
-- =============================================
ALTER PROCEDURE [dbo].[ocean_user_member_search]
	 @actType	varchar(30)	= ''
	,@id		varchar(320)= ''
	,@FirstName	varchar(30) = ''
	,@LastName	varchar(30)	= ''
	,@cIdx		INT			= 0
AS
BEGIN
	SET NOCOUNT ON;
	
	IF @actType = 'id'
	BEGIN
		SELECT TOP 1 
			 [UserIdx]
			,[UserId]
			,[UserEmail]
			,CONVERT(VARCHAR(16),[UserIndate],20) AS [UserIndate] 
		FROM [dbo].[OCEAN_USER_MEMBER] 
		WHERE [UserName] = @FirstName 
		AND CASE @LastName WHEN '' THEN '' ELSE [UserNameLast] END = @LastName
		AND [companyIdx] = @cIdx
		AND [UserDelFg] = 0
		order by [UserIdx] desc
	END
	ELSE IF @actType = 'pwd'
	BEGIN
		SELECT TOP 1 
			 [UserIdx]
			,[UserId]
			,[UserEmail]
			,CONVERT(VARCHAR(16),[UserIndate],20) AS [UserIndate] 
		FROM [dbo].[OCEAN_USER_MEMBER] 
		WHERE [UserName] = @FirstName 
		AND CASE @LastName WHEN '' THEN '' ELSE [UserNameLast] END = @LastName
		AND [companyIdx] = @cIdx
		AND [UserId] = @id
		AND [UserDelFg] = 0
		order by [UserIdx] desc
	END
	
	ELSE IF @actType = 'complete'
	BEGIN
		-- @cIdx = userIdx 임시사용
		DECLARE @RESULT INT , @EMAIL_FG INT
		DECLARE @CNT INT , @CNT_C INT ,@COMPANY INT ,@state INT
		
		SET @RESULT = 1
		SET @EMAIL_FG = 1
		/* 대표자 체크 */
		SET @CNT = ( SELECT COUNT(*) FROM [dbo].[OCEAN_USER_MEMBER] WHERE [UserIdx] = @cIdx AND [UserId] = @id AND [ceo] = 1 AND [UserDelFg] = 0  )
		
		IF @CNT > 0 
		BEGIN
			SET @COMPANY = (SELECT [companyIdx] FROM [dbo].[OCEAN_USER_MEMBER] WHERE [UserIdx] = @cIdx  )
			SET @CNT_C   = (SELECT COUNT(*) FROM [dbo].[OCEAN_USER_MEMBER] WHERE [companyIdx] = @COMPANY AND [UserIdx] != @cIdx AND [ceo] = 1 AND [UserDelFg] = 0 )
			
			/* 대표자 중복 체크 */
			IF @CNT_C = 0 
			BEGIN
				SET @state = (SELECT [state] FROM [dbo].[OCEAN_USER_MEMBER] WHERE [UserIdx] = @cIdx)
				
				
				/* 대표자 승인요청으로 상태변환 */
				IF @state = 3 
				BEGIN
					UPDATE [dbo].[OCEAN_USER_MEMBER] SET 
						[state] = 2
					WHERE [UserIdx] = @cIdx
					
					SET @EMAIL_FG = 0
				END
				
				SET @RESULT = 0
			END
		END 
		
		SELECT @RESULT AS [RESULT],@EMAIL_FG AS [EMAIL_FG]
		
	END
	
END
