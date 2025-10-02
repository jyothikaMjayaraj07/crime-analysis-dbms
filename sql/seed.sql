USE crime_db;

-- Clear old data
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Evidence;
TRUNCATE TABLE CaseFile;
TRUNCATE TABLE Suspect;
TRUNCATE TABLE Criminal;
TRUNCATE TABLE FIR;
TRUNCATE TABLE Crime_Location;
TRUNCATE TABLE Officer;
SET FOREIGN_KEY_CHECKS = 1;

-- Officers (20)
INSERT INTO Officer (Name, Rank_name, Station, Contact_No) VALUES
('Rajesh Kumar', 'Inspector', 'Delhi Central', '9876543210'),
('Anjali Sharma', 'Sub-Inspector', 'Mumbai North', '9876543211'),
('Arjun Verma', 'Inspector', 'Chennai South', '9876543212'),
('Priya Nair', 'Constable', 'Kolkata East', '9876543213'),
('Vikram Singh', 'Superintendent', 'Bangalore West', '9876543214'),
('Sunita Joshi', 'Inspector', 'Pune City', '9876543215'),
('Manoj Tiwari', 'Constable', 'Lucknow Central', '9876543216'),
('Deepa Reddy', 'Sub-Inspector', 'Hyderabad North', '9876543217'),
('Sanjay Patel', 'Inspector', 'Ahmedabad South', '9876543218'),
('Ayesha Khan', 'Superintendent', 'Jaipur West', '9876543219'),
('Ramesh Yadav', 'Inspector', 'Patna Central', '9876543220'),
('Farhan Ali', 'Sub-Inspector', 'Bhopal North', '9876543221'),
('Kiran Desai', 'Inspector', 'Surat City', '9876543222'),
('Jyoti Mishra', 'Constable', 'Varanasi East', '9876543223'),
('Harish Rao', 'Superintendent', 'Hyderabad West', '9876543224'),
('Nandita Ghosh', 'Inspector', 'Howrah City', '9876543225'),
('Prakash Menon', 'Inspector', 'Cochin Port', '9876543226'),
('Alok Pandey', 'Constable', 'Kanpur South', '9876543227'),
('Seema Bhat', 'Sub-Inspector', 'Srinagar Central', '9876543228'),
('Dinesh Patil', 'Superintendent', 'Nagpur City', '9876543229');

-- Crime Locations (20)
INSERT INTO Crime_Location (City, State) VALUES
('Delhi', 'Delhi'),
('Mumbai', 'Maharashtra'),
('Chennai', 'Tamil Nadu'),
('Kolkata', 'West Bengal'),
('Bangalore', 'Karnataka'),
('Pune', 'Maharashtra'),
('Lucknow', 'Uttar Pradesh'),
('Hyderabad', 'Telangana'),
('Ahmedabad', 'Gujarat'),
('Jaipur', 'Rajasthan'),
('Patna', 'Bihar'),
('Bhopal', 'Madhya Pradesh'),
('Surat', 'Gujarat'),
('Varanasi', 'Uttar Pradesh'),
('Howrah', 'West Bengal'),
('Cochin', 'Kerala'),
('Kanpur', 'Uttar Pradesh'),
('Srinagar', 'Jammu & Kashmir'),
('Nagpur', 'Maharashtra'),
('Chandigarh', 'Punjab');

-- Criminals (20)
INSERT INTO Criminal (Name, Age, Gender, Address, Crime_History) VALUES
('Ravi Sharma', 35, 'Male', 'Delhi, India', 'Robbery, theft'),
('Suresh Gupta', 40, 'Male', 'Mumbai, India', 'Cyber fraud'),
('Kiran Kumar', 28, 'Male', 'Chennai, India', 'Hit and run'),
('Meena Rani', 32, 'Female', 'Kolkata, India', 'Kidnapping'),
('Arif Khan', 45, 'Male', 'Bangalore, India', 'Drug smuggling'),
('Vikas Yadav', 29, 'Male', 'Lucknow, India', 'Chain snatching'),
('Shalini Roy', 36, 'Female', 'Kolkata, India', 'Fraud'),
('Ajay Mehta', 50, 'Male', 'Delhi, India', 'Extortion'),
('Rohit Sinha', 27, 'Male', 'Pune, India', 'Assault'),
('Nisha Kapoor', 31, 'Female', 'Jaipur, India', 'Arson'),
('Pradeep Jain', 42, 'Male', 'Ahmedabad, India', 'Forgery'),
('Tara Devi', 39, 'Female', 'Patna, India', 'Drug trafficking'),
('Imran Sheikh', 30, 'Male', 'Hyderabad, India', 'Burglary'),
('Rekha Malhotra', 34, 'Female', 'Bhopal, India', 'Human trafficking'),
('Gaurav Das', 26, 'Male', 'Varanasi, India', 'Vehicle theft'),
('Mohammed Iqbal', 48, 'Male', 'Srinagar, India', 'Arms dealing'),
('Santosh Rao', 33, 'Male', 'Cochin, India', 'Piracy'),
('Neha Kaur', 29, 'Female', 'Chandigarh, India', 'Fraud, impersonation'),
('Ashok Pillai', 37, 'Male', 'Nagpur, India', 'Tax evasion'),
('Pankaj Singh', 41, 'Male', 'Kanpur, India', 'Bank robbery');

-- Suspects (20)
INSERT INTO Suspect (Name, Age, Gender, Address) VALUES
('Rohit Mehta', 30, 'Male', 'Delhi, India'),
('Sneha Patel', 27, 'Female', 'Mumbai, India'),
('Deepak Rao', 29, 'Male', 'Chennai, India'),
('Neha Das', 26, 'Female', 'Kolkata, India'),
('Imran Ali', 38, 'Male', 'Bangalore, India'),
('Alok Sharma', 33, 'Male', 'Lucknow, India'),
('Pooja Iyer', 24, 'Female', 'Hyderabad, India'),
('Sameer Khan', 29, 'Male', 'Ahmedabad, India'),
('Kavita Nair', 28, 'Female', 'Pune, India'),
('Aditya Joshi', 35, 'Male', 'Jaipur, India'),
('Nandini Roy', 27, 'Female', 'Patna, India'),
('Rahul Verma', 32, 'Male', 'Bhopal, India'),
('Fatima Sheikh', 25, 'Female', 'Surat, India'),
('Anil Chauhan', 30, 'Male', 'Varanasi, India'),
('Lata Ghosh', 31, 'Female', 'Howrah, India'),
('Sandeep Kumar', 34, 'Male', 'Cochin, India'),
('Ritika Sharma', 29, 'Female', 'Kanpur, India'),
('Omar Farooq', 36, 'Male', 'Srinagar, India'),
('Harshita Mehta', 28, 'Female', 'Nagpur, India'),
('Ravi Deshmukh', 40, 'Male', 'Chandigarh, India');

-- FIRs (20)
INSERT INTO FIR (Date_Filed, Description, Officer_ID, Location_ID) VALUES
('2025-01-05', 'Robbery at jewelry shop', 1, 1),
('2025-01-10', 'Cyber fraud complaint', 2, 2),
('2025-01-15', 'Hit and run accident', 3, 3),
('2025-01-20', 'Kidnapping case', 4, 4),
('2025-01-25', 'Drug smuggling', 5, 5),
('2025-02-01', 'Chain snatching', 7, 7),
('2025-02-05', 'Extortion case', 1, 1),
('2025-02-08', 'Assault near market', 6, 6),
('2025-02-12', 'Arson in factory', 10, 10),
('2025-02-15', 'ATM Fraud', 2, 2),
('2025-02-18', 'Forgery of land documents', 11, 11),
('2025-02-20', 'Drug trafficking', 12, 12),
('2025-02-22', 'Burglary in flat', 13, 8),
('2025-02-25', 'Human trafficking racket', 14, 12),
('2025-02-28', 'Vehicle theft', 15, 14),
('2025-03-01', 'Arms smuggling', 16, 18),
('2025-03-03', 'Piracy of movies', 17, 16),
('2025-03-05', 'Fraudulent bank accounts', 18, 20),
('2025-03-08', 'Tax evasion scheme', 19, 19),
('2025-03-10', 'Bank robbery', 20, 17);

-- Case Files (20)
INSERT INTO CaseFile (Case_Title, Status, FIR_ID, Criminal_ID, Suspect_ID) VALUES
('Delhi Jewelry Robbery', 'Closed', 1, 1, 1),
('Mumbai Cyber Fraud', 'Under Investigation', 2, 2, 2),
('Chennai Hit and Run', 'Closed', 3, 3, 3),
('Kolkata Kidnapping', 'Open', 4, 4, 4),
('Bangalore Drug Smuggling', 'Under Trial', 5, 5, 5),
('Lucknow Chain Snatching', 'Convicted', 6, 6, 6),
('Delhi Extortion', 'Open', 7, 8, 1),
('Pune Market Assault', 'Closed', 8, 9, 9),
('Jaipur Factory Arson', 'Under Investigation', 9, 10, 10),
('Mumbai ATM Fraud', 'Open', 10, 2, 2),
('Patna Forgery Case', 'Open', 11, 11, 11),
('Bhopal Drug Trafficking', 'Under Trial', 12, 12, 12),
('Hyderabad Burglary', 'Closed', 13, 13, 7),
('Bhopal Human Trafficking', 'Convicted', 14, 14, 12),
('Varanasi Vehicle Theft', 'Under Investigation', 15, 15, 14),
('Srinagar Arms Smuggling', 'Open', 16, 16, 18),
('Cochin Piracy Case', 'Closed', 17, 17, 16),
('Chandigarh Bank Fraud', 'Open', 18, 18, 20),
('Nagpur Tax Evasion', 'Under Trial', 19, 19, 19),
('Kanpur Bank Robbery', 'Convicted', 20, 20, 17);

-- Evidence (20)
INSERT INTO Evidence (Case_ID, Evidence_Type, Description, Collected_On) VALUES
(1, 'CCTV Footage', 'Footage from jewelry shop', '2025-01-06'),
(2, 'Laptop', 'Seized laptop used for fraud', '2025-01-11'),
(3, 'Car', 'Vehicle involved in hit and run', '2025-01-16'),
(4, 'Phone Records', 'Call records of suspect', '2025-01-21'),
(5, 'Drugs', 'Packets of illegal substances', '2025-01-26'),
(6, 'Chain', 'Stolen gold chain', '2025-02-02'),
(7, 'Audio Recording', 'Threat calls recording', '2025-02-06'),
(8, 'Knife', 'Weapon used in assault', '2025-02-09'),
(9, 'Matchbox', 'Used to ignite fire', '2025-02-13'),
(10, 'Credit Card Data', 'Stolen ATM card data', '2025-02-16'),
(11, 'Land Papers', 'Forged documents seized', '2025-02-19'),
(12, 'Cocaine Packets', 'Seized narcotics', '2025-02-21'),
(13, 'Lock Pick', 'Tools used for burglary', '2025-02-23'),
(14, 'Passports', 'Confiscated fake passports', '2025-02-26'),
(15, 'Bike', 'Stolen motorbike recovered', '2025-02-28'),
(16, 'Rifles', 'Illegal weapons recovered', '2025-03-02'),
(17, 'Hard Disk', 'Pirated movie content', '2025-03-04'),
(18, 'Bank Records', 'Fake bank accounts traced', '2025-03-06'),
(19, 'Tax Papers', 'Forged tax documents', '2025-03-09'),
(20, 'Cash Bags', 'Looted cash from bank', '2025-03-11');
