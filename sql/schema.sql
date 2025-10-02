-- Create database
DROP DATABASE IF EXISTS crime_db;
CREATE DATABASE crime_db;
USE crime_db;


CREATE TABLE IF NOT EXISTS Audit_Log (
    Log_ID INT AUTO_INCREMENT PRIMARY KEY,
    Table_Name VARCHAR(50),
    Operation VARCHAR(20),
    Record_ID INT,
    Changed_On TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Changed_By VARCHAR(100) DEFAULT NULL,
    Details TEXT
);

-- Officers
CREATE TABLE IF NOT EXISTS Officer (
    Officer_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Rank_name VARCHAR(50),
    Station VARCHAR(100),
    Contact_No VARCHAR(20) UNIQUE
);
CREATE TABLE IF NOT EXISTS Crime_Location (
    Location_ID INT AUTO_INCREMENT PRIMARY KEY,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS FIR (
    FIR_ID INT AUTO_INCREMENT PRIMARY KEY,
    Date_Filed DATE NOT NULL,
    Description TEXT,
    Officer_ID INT,
    Location_ID INT,
    FOREIGN KEY (Officer_ID) REFERENCES Officer(Officer_ID),
    FOREIGN KEY (Location_ID) REFERENCES Crime_Location(Location_ID)
);
CREATE TABLE IF NOT EXISTS Criminal (
    Criminal_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT,
    Gender VARCHAR(10),
    Address VARCHAR(255),
    Crime_History TEXT
);
CREATE TABLE IF NOT EXISTS Suspect (
    Suspect_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT,
    Gender VARCHAR(10),
    Address VARCHAR(255)
);
CREATE TABLE IF NOT EXISTS CaseFile (
    Case_ID INT AUTO_INCREMENT PRIMARY KEY,
    Case_Title VARCHAR(200) NOT NULL,
    Status VARCHAR(50) DEFAULT 'Open',
    FIR_ID INT,
    Criminal_ID INT,
    Suspect_ID INT,
    FOREIGN KEY (FIR_ID) REFERENCES FIR(FIR_ID),
    FOREIGN KEY (Criminal_ID) REFERENCES Criminal(Criminal_ID),
    FOREIGN KEY (Suspect_ID) REFERENCES Suspect(Suspect_ID)
);
CREATE TABLE IF NOT EXISTS Evidence (
    Evidence_ID INT AUTO_INCREMENT PRIMARY KEY,
    Case_ID INT,
    Evidence_Type VARCHAR(100),
    Description TEXT,
    Collected_On DATE,
    FOREIGN KEY (Case_ID) REFERENCES CaseFile(Case_ID)
);

