USE [ocean]
GO

/****** Object:  StoredProcedure [dbo].[OCEAN_ADMIN_MEMBER_L]    Script Date: 08/03/2015 17:18:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author: SPWEB
-- Create date: 2015-08-03
-- Description:	관리자 게시판 이메일 리스트
-- =============================================
CREATE PROCEDURE [dbo].[OCEAN_ADMIN_MEMBER_EMAIL_L]
	 @key	int	= 0
	,@tab	int	= 0
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		 [uIdx]
		,[key]
		,[tab]
		,B.[email]
	FROM [dbo].[OCEAN_ADMIN_MEMBER_BOARD_permission] A
	INNER JOIN [dbo].[OCEAN_ADMIN_MEMBER] B
	ON(A.uIdx = B.Idx)
	WHERE B.Dellfg = 0
	AND A.[key] = @key
	AND A.[tab] = @tab
  
  
END


GO


