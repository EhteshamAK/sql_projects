/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [sofifa_id]  
      ,[short_name]
      ,[full_name]
      ,[age]
      ,[dob]
      ,[height_cm]
      ,[weight_kg]
      ,[nationality]
      ,[club_name]
      ,[league_name]
      ,[league_rank]
      ,[overall]
      ,[potential]
      ,[value_eur]
      ,[wage_eur]
      ,[player_positions]
      ,[preferred_foot]
      ,[international_reputation]
      --,[weak_foot]
      ,[skill_moves]
      ,[work_rate]
     [body_type] 
      ,[player_tags]
      ,[team_position]
     [team_jersey_number]
      ,[loaned_from]
      ,[joined]
      ,[contract_valid_until]
      ,[nation_position]
      ,[nation_jersey_number]

  FROM [Fifa].[dbo].[fifa21]

  -- rename column long_name to full_name

sp_rename 'fifa21.long_name', 'full_name';

-- convert the datatype of dob and joined columns 

alter table fifa21
alter column dob date;

alter table fifa21
alter column joined date;

