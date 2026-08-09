/*
===============================================================================
Project: Climate Impact on Olive Yield
File: 01_create_database.sql
Purpose: Create the project database if it does not already exist.
Database system: Microsoft SQL Server
Execution order: 1
===============================================================================
*/

USE master;
GO

IF DB_ID(N'Climate_Impact_Olive_Yield') IS NULL
BEGIN
    CREATE DATABASE Climate_Impact_Olive_Yield;
END;
GO

USE Climate_Impact_Olive_Yield;
GO