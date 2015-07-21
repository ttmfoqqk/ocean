USE [keti]
GO
/****** Object:  StoredProcedure [dbo].[ocean_user_member_search]    Script Date: 07/21/2015 18:51:42 ******/
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
			,[UserIndate] 
		FROM [dbo].[OCEAN_USER_MEMBER] 
		WHERE [UserName] = @FirstName 
		AND [UserNameLast] = @LastName
		AND [companyIdx] = @cIdx
		AND [UserDelFg] = 0
	END
	ELSE IF @actType = 'pwd'
	BEGIN
		SELECT TOP 1 
			 [UserIdx]
			,[UserId]
			,[UserEmail]
			,[UserIndate]
		FROM [dbo].[OCEAN_USER_MEMBER] 
		WHERE [UserName] = @FirstName 
		AND [UserNameLast] = @LastName
		AND [companyIdx] = @cIdx
		AND [UserId] = @id
		AND [UserDelFg] = 0
	END
	
END
