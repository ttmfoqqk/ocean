USE [ocean]
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_BOARD_CONT_P]    Script Date: 07/27/2015 17:51:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: SPWEB
-- Create date: 2012-09-21
-- Description:	게시판 글 등록/수정/삭제
-- =============================================
ALTER PROCEDURE [dbo].[OCEAN_BOARD_CONT_P]
	 @actType		varchar(20) = ''
	,@Idx			varchar(MAX)= ''
	,@Key			INT			= 0
	,@UserIdx		INT			= 0
	,@Title			varchar(200)= ''
	,@Contants		TEXT		= ''
	,@File_name		varchar(200)= ''
	,@File_name2	varchar(200)= ''
	,@File_name3	varchar(200)= ''
	,@File_name4	varchar(200)= ''
	,@File_name5	varchar(200)= ''
	,@File_name6	varchar(200)= ''
	,@File_name7	varchar(200)= ''
	,@File_name8	varchar(200)= ''
	,@File_name9	varchar(200)= ''
	,@File_name10	varchar(200)= ''
	,@Secret		INT			= 0
	,@Notice		INT			= 0
	,@Pass			varchar(20) = ''
	,@Ip			varchar(20) = ''
	,@AdminIdx		INT			= 0
	,@website		varchar(200)= ''
	,@tag			varchar(200)= ''
	,@tab			INT			= 0
	,@tab2			INT			= 0
	,@status		varchar(10)	= NULL
	,@user			varchar(10)	= ''
AS
BEGIN
	SET NOCOUNT ON;

    IF @actType = 'INSERT'
	BEGIN
	
		DECLARE @Ord_no INT
		DECLARE @Depth_no INT
		DECLARE @Parent_no INT
		DECLARE @CommentCnt INT
		DECLARE @TMP_IDX INT
		SET @TMP_IDX = 0
		
		SET @Ord_no = ISNULL( (
			CASE @Idx
			WHEN '' THEN 0
			ELSE( SELECT [Ord_no]+1 FROM [dbo].[OCEAN_BOARD] WHERE [Idx] = @Idx )
			END
		) ,0)
		SET @Depth_no = ISNULL( (
			CASE @Idx
			WHEN '' THEN 0
			ELSE( SELECT [Depth_no]+1 FROM [dbo].[OCEAN_BOARD] WHERE [Idx] = @Idx )
			END
		) ,0)
		SET @Parent_no = ISNULL( (
			CASE @Idx
			WHEN '' THEN 0
			ELSE( SELECT [Parent_no] FROM [dbo].[OCEAN_BOARD] WHERE [Idx] = @Idx )
			END
		) ,0)
		SET @CommentCnt = (SELECT COUNT(*) FROM [dbo].[OCEAN_BOARD] WHERE [Idx] = @Idx )
		--답변용 순서 업데이트
		IF @Parent_no > 0
		BEGIN
			UPDATE [dbo].[OCEAN_BOARD] SET
				[Ord_no] = [Ord_no] + 1
			WHERE [Parent_no] = @Parent_no AND [Ord_no] >= @Ord_no
		END
		
		--답글수 업데이트
		IF @CommentCnt > 0
		BEGIN
			UPDATE [dbo].[OCEAN_BOARD] SET
				[CommentCnt] = [CommentCnt] + 1
			WHERE [Idx] = @Idx
		END
	
		INSERT INTO [dbo].[OCEAN_BOARD](
			 [Key]
			,[Ord_no]
			,[Depth_no]
			,[Parent_no]
			,[UserIdx]
			,[Title]
			,[Contants]
			,[File_name]
			,[File_name2]
			,[File_name3]
			,[File_name4]
			,[File_name5]
			,[File_name6]
			,[File_name7]
			,[File_name8]
			,[File_name9]
			,[File_name10]
			,[Secret]
			,[Notice]
			,[Pass]
			,[Read_cnt]
			,[Dellfg]
			,[Ip]
			,[Indate]
			,[AdminIdx]
			,[CommentCnt]
			,[website]
			,[tag]
			,[tab]
			,[tab2]
			,[status]
			,[parent_idx]
		)VALUES(
			 @Key
			,@Ord_no
			,@Depth_no
			,@Parent_no
			,@UserIdx
			,@Title
			,@Contants
			,@File_name
			,@File_name2
			,@File_name3
			,@File_name4
			,@File_name5
			,@File_name6
			,@File_name7
			,@File_name8
			,@File_name9
			,@File_name10
			,@Secret
			,@Notice
			,@Pass
			,0
			,0
			,@Ip
			,GETDATE()
			,@AdminIdx
			,0
			,@website
			,@tag
			,@tab
			,@tab2
			,@status
			,@Idx
		)
		
		IF @Parent_no = 0
		BEGIN
			UPDATE [dbo].[OCEAN_BOARD] SET
				[Parent_no] = [Idx]
			WHERE [Idx] = SCOPE_IDENTITY()
		END 
		
	END
	ELSE IF @actType = 'UPDATE'
	BEGIN
		SET @TMP_IDX = ISNULL((
			SELECT [Idx] FROM [dbo].[OCEAN_BOARD] 
			WHERE [Idx] = @Idx
			AND (case @user when '' then '' else [UserIdx] end) = (case @user when '' then '' else @UserIdx end)
		),0)
		
		UPDATE [dbo].[OCEAN_BOARD] SET
			 [Title]		= @Title
			,[Contants]		= @Contants
			,[File_name]	= @File_name
			,[File_name2]	= @File_name2
			,[File_name3]	= @File_name3
			,[File_name4]	= @File_name4
			,[File_name5]	= @File_name5
			,[File_name6]	= @File_name6
			,[File_name7]	= @File_name7
			,[File_name8]	= @File_name8
			,[File_name9]	= @File_name9
			,[File_name10]	= @File_name10
			,[Notice]		= @Notice
			,[Secret]		= @Secret
			,[website]		= @website
			,[tag]			= @tag
			,[tab]			= @tab
			,[tab2]			= @tab2
			,[status]		= (case @user when '' then @status else [status] end)
		WHERE [Idx] = @TMP_IDX
		

	END
	ELSE IF @actType = 'DELETE'
	BEGIN
		DECLARE @S VARCHAR (MAX)
		DECLARE @T TABLE(T_INT INT)
		SET @S=@idx
		
		

		WHILE CHARINDEX(',',@S)<>0
			BEGIN
			SET @TMP_IDX = ISNULL((
				SELECT [Idx] FROM [dbo].[OCEAN_BOARD] 
				WHERE [Idx] = (SUBSTRING(@S,1,CHARINDEX(',',@S)-1))
				AND case @user when '' then '' else [UserIdx] end = @UserIdx
			),0)
			
			IF @TMP_IDX > 0 
			BEGIN
				INSERT INTO @T(T_INT) VALUES( @TMP_IDX )
			END
			
			SET @S=SUBSTRING(@S,CHARINDEX(',',@S)+1,LEN(@S)) 
		END
		IF CHARINDEX(',',@S)=0
			BEGIN
			INSERT INTO @T(T_INT) VALUES( @S )
		END
	
		UPDATE [dbo].[OCEAN_BOARD] SET
			[Dellfg] = 1
		WHERE [Idx] in(SELECT T_INT FROM @T)

	END
END

