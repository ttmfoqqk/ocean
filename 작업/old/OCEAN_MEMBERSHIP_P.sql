USE [ocean]
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_MEMBERSHIP_P]    Script Date: 08/06/2015 20:48:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		SPWEB
-- Create date: 2014-12-15
-- Description:	기업회원 입력/수정/삭제
-- =============================================
ALTER PROCEDURE [dbo].[OCEAN_MEMBERSHIP_P]
		 @actType		varchar(10)		= ''
		,@idx			varchar(max)	= ''
		,@cName			varchar(200)	= ''
		,@Country		INT				= 0
		,@addr			varchar(max)	= ''
		,@cPhone		varchar(200)	= ''
		,@homepage		varchar(200)	= ''
		,@cStaff		INT				= ''
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
		,@files2		varchar(200)	= ''
		,@bigo			text			= ''
		,@State			int				= 0		/* 0:정상 ,1:삭제, ..  */
		,@order			int				= 0

AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @CNT INT
	SET @CNT = 0
	
	IF @actType = 'INSERT' 
		BEGIN
		
		SET @CNT = (SELECT COUNT(*) FROM [dbo].[OCEAN_MEMBERSHIP] WHERE [cName] = @cName and [State] = 0)
		
		IF @CNT = 0
		BEGIN
			INSERT INTO [dbo].[OCEAN_MEMBERSHIP](
				 [cName]
				,[Country]
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
				,[bigo]
				,[State]
				,[inDate]
				,[order]
			)VALUES(
				 @cName
				,@Country
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
				,@bigo
				,@State
				,GETDATE()
				,@order
			)
		END
	END
	ELSE IF @actType = 'UPDATE'
	BEGIN
		
		
		IF @State = 0 
		BEGIN
			SET @CNT = (SELECT COUNT(*) FROM [dbo].[OCEAN_MEMBERSHIP] WHERE [cName] = @cName and [State] = 0 and [idx] != @idx)
		END
		
		
		IF @CNT = 0
		BEGIN
			UPDATE [dbo].[OCEAN_MEMBERSHIP] SET
				 [cName]			= @cName
				,[Country]			= @Country
				,[addr]				= @addr
				,[cPhone]			= @cPhone
				,[homepage]			= @homepage
				,[cStaff]			= @cStaff
				,[business]			= @business
				,[business1]		= @business1
				,[business2]		= @business2
				,[business3]		= @business3
				,[business4]		= @business4
				,[business5]		= @business5
				,[business6]		= @business6
				,[business7]		= @business7
				,[business8]		= @business8
				,[business9]		= @business9
				,[business10]		= @business10
				,[business11]		= @business11
				,[business12]		= @business12
				,[files2]			= @files2
				,[bigo]				= @bigo
				,[State]			= @State
				,[order]			= @order
			WHERE [idx] = @idx
		END
	END
	ELSE IF @actType = 'DELETE'
	BEGIN
		DECLARE @S VARCHAR (max)
		DECLARE @T TABLE(T_INT INT)
		SET @S=@idx

		WHILE CHARINDEX(',',@S)<>0
		BEGIN
			INSERT INTO @T(T_INT) VALUES( SUBSTRING(@S,1,CHARINDEX(',',@S)-1) )
			SET @S=SUBSTRING(@S,CHARINDEX(',',@S)+1,LEN(@S)) 
		END
		
		IF CHARINDEX(',',@S)=0
		BEGIN
			INSERT INTO @T(T_INT) VALUES( SUBSTRING(@S,1,LEN(@S)) )
		END
		
		UPDATE [dbo].[OCEAN_MEMBERSHIP] SET
			[State]	= 1
		WHERE [idx] = @idx

	END

	SELECT @CNT AS [CNT];

END


