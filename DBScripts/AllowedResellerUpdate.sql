if exists(select * from [dbo].[Configs] WHERE Id=23 and Value=N'test@test.com')
     begin
            UPDATE [dbo].[Configs] SET Value ='$(key7)' WHERE Id=23;
    end
    