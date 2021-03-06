USE [ocean]
GO
/****** Object:  StoredProcedure [dbo].[OCEAN_ADMIN_MEMBER_P]    Script Date: 08/03/2015 16:14:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SPWEB
-- Create date: 2012-09-14
-- Description:	관리자 입력/수정/삭제
-- =============================================
ALTER PROCEDURE [dbo].[OCEAN_ADMIN_MEMBER_P]
	 @actType	VARCHAR(10)		= ''
	,@Idx		VARCHAR(MAX)	= ''
	,@Id		VARCHAR(50)		= ''
	,@Pwd		VARCHAR(50)		= ''
	,@Name		VARCHAR(50)		= ''
	,@pHone1	VARCHAR(4)		= ''
	,@pHone2	VARCHAR(4)		= ''
	,@pHone3	VARCHAR(4)		= ''
	,@Hphone1	VARCHAR(4)		= ''
	,@Hphone2	VARCHAR(4)		= ''
	,@Hphone3	VARCHAR(4)		= ''
	,@ExtNum	VARCHAR(50)		= ''
	,@DirNum	VARCHAR(50)		= ''
	,@email		VARCHAR(200)	= ''
	,@MsgAddr	VARCHAR(200)	= ''
	,@Bigo		TEXT			= ''
	,@Indata	VARCHAR(10)		= ''
	,@cumunity_key	INT			= 0
	,@cumunity_tab	VARCHAR(MAX) = ''
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @IN_CNT INT
	DECLARE @IDENTITY INT
	
	DECLARE @S VARCHAR (max)
	DECLARE @T TABLE(T_INT INT)
	
	IF @actType = 'INSERT' 
		BEGIN
		
		SET @IN_CNT = (
			SELECT COUNT(*) FROM [dbo].[OCEAN_ADMIN_MEMBER] WHERE [Id] = @Id
		)
		
		IF @IN_CNT = 0
			BEGIN
		
			INSERT INTO [dbo].[OCEAN_ADMIN_MEMBER](
				 [Id]
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
				,[Indata]
				,[Dellfg]
			)VALUES(
				 @Id
				,@Pwd
				,@Name
				,@pHone1
				,@pHone2
				,@pHone3
				,@Hphone1
				,@Hphone2
				,@Hphone3
				,@ExtNum
				,@DirNum
				,@email
				,@MsgAddr
				,@Bigo
				,getdate()
				,0
			)
			
			SET @IDENTITY = SCOPE_IDENTITY()
			
			/* 게시판-커뮤니티 권한 입력 */
			SET @S = @cumunity_tab

			WHILE CHARINDEX(',',@S)<>0
			BEGIN
				INSERT INTO @T(T_INT) VALUES( SUBSTRING(@S,1,CHARINDEX(',',@S)-1) )
				SET @S=SUBSTRING(@S,CHARINDEX(',',@S)+1,LEN(@S)) 
			END
			
			IF CHARINDEX(',',@S)=0
			BEGIN
				INSERT INTO @T(T_INT) VALUES( SUBSTRING(@S,1,LEN(@S)) )
			END
			
			INSERT INTO [dbo].[OCEAN_ADMIN_MEMBER_BOARD_permission](
				 [uIdx]
				,[key]
				,[tab]
			)
			SELECT
				 @IDENTITY
				,@cumunity_key
				,[T_INT]
			FROM @T
			/* 게시판-커뮤니티 권한 입력 */
			
		END
		
	END
	ELSE IF @actType = 'UPDATE'
		BEGIN
		
		UPDATE [dbo].[OCEAN_ADMIN_MEMBER] SET
			 --[Id]		= @Id
			 [Pwd]		= @Pwd
			,[Name]		= @Name
			,[pHone1]	= @pHone1
			,[pHone2]	= @pHone2
			,[pHone3]	= @pHone3
			,[Hphone1]	= @Hphone1
			,[Hphone2]	= @Hphone2
			,[Hphone3]	= @Hphone3
			,[ExtNum]	= @ExtNum
			,[DirNum]	= @DirNum
			,[email]	= @email
			,[MsgAddr]	= @MsgAddr
			,[Bigo]		= @Bigo
		WHERE [Idx] = @Idx
		
		/* 게시판-커뮤니티 권한 입력 */
		SET @S = @cumunity_tab

		WHILE CHARINDEX(',',@S)<>0
		BEGIN
			INSERT INTO @T(T_INT) VALUES( SUBSTRING(@S,1,CHARINDEX(',',@S)-1) )
			SET @S=SUBSTRING(@S,CHARINDEX(',',@S)+1,LEN(@S)) 
		END
		
		IF CHARINDEX(',',@S)=0
		BEGIN
			INSERT INTO @T(T_INT) VALUES( SUBSTRING(@S,1,LEN(@S)) )
		END
		/* 삭제 재입력 */
		DELETE FROM [dbo].[OCEAN_ADMIN_MEMBER_BOARD_permission] WHERE [uIdx] = @Idx
		
		INSERT INTO [dbo].[OCEAN_ADMIN_MEMBER_BOARD_permission](
			 [uIdx]
			,[key]
			,[tab]
		)
		SELECT
			 @Idx
			,@cumunity_key
			,[T_INT]
		FROM @T
		/* 게시판-커뮤니티 권한 입력 */
	END
	ELSE IF @actType = 'DELETE'
		BEGIN

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
		
		UPDATE [dbo].[OCEAN_ADMIN_MEMBER] SET
			[Dellfg] = 1
		WHERE [Idx] in(SELECT T_INT FROM @T)
		
		--DELETE FROM [dbo].[OCEAN_ADMIN_MEMBER] WHERE [Idx] in(SELECT T_INT FROM @T)
	END
	
	SELECT @IN_CNT AS [IN_CNT]

END

