USE [ocean]
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_ADMIN_MEMBER_V]    Script Date: 08/03/2015 16:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: SPWEB
-- Create date: 2012-09-14
-- Description:	관리자 상세
-- =============================================
ALTER PROCEDURE [dbo].[OCEAN_ADMIN_MEMBER_V]
	 @Idx int = 0
AS
BEGIN
	SET NOCOUNT ON;

    SELECT 
		 [Idx]
		,[Id]
		,[Pwd]
		,[Name]
		,[pHone1]
		,[pHone2]
		,[pHone3]
		,[Hphone1]
		,[Hphone2]
		,[Hphone3]
		,[ExtNum]
		,[DirNum]
		,[email]
		,[MsgAddr]
		,[Bigo]
		,CONVERT(VARCHAR,[Indata],23) AS [Indata]
  FROM [dbo].[OCEAN_ADMIN_MEMBER]
  WHERE [Idx] = @Idx
  
  SELECT 
	 [uIdx]
	,[key]
	,[tab]
  FROM [dbo].[OCEAN_ADMIN_MEMBER_BOARD_permission]
  WHERE [uIdx] = @Idx
  
END

