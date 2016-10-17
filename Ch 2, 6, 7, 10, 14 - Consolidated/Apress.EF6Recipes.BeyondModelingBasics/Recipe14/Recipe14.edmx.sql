
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 11/22/2013 23:53:49
-- Generated from EDMX file: C:\Users\brian.driscoll\Dropbox\Apress\EF 6 Recipes\SampleCode\EF6 Recipes\Apress.EF6Recipes.BeyondModelingBasics\Recipe14\Recipe14.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [EF6Recipes];
GO
IF SCHEMA_ID(N'Chapter6') IS NULL EXECUTE(N'CREATE SCHEMA [Chapter6]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------


-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Users'
CREATE TABLE [Chapter6].[Users] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [UserName] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'PasswordHistories'
CREATE TABLE [Chapter6].[PasswordHistories] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [LastLogin] datetime  NOT NULL,
    [UserId] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Users'
ALTER TABLE [Chapter6].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'PasswordHistories'
ALTER TABLE [Chapter6].[PasswordHistories]
ADD CONSTRAINT [PK_PasswordHistories]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [UserId] in table 'PasswordHistories'
ALTER TABLE [Chapter6].[PasswordHistories]
ADD CONSTRAINT [FK_UserPasswordHistory]
    FOREIGN KEY ([UserId])
    REFERENCES [Chapter6].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_UserPasswordHistory'
CREATE INDEX [IX_FK_UserPasswordHistory]
ON [Chapter6].[PasswordHistories]
    ([UserId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------