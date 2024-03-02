create database Blood_Donation

--creating table for Patients--

create table Patients(Patient_Name varchar(50), Unique_ID int Primary Key, Blood_group varchar(10), Disease varchar(50));

insert into Patients(Patient_Name, Unique_ID, Blood_group, Disease) 
values('Jessica Garcia', 1001, 'A+', 'Allergies'),
    ('Daniel Martinez', 1002, 'B-', 'Eczema'),
    ('Sophia Taylor', 1003, 'AB+', 'High Cholesterol'),
    ('Matthew Anderson', 1004, 'O+', 'Thyroid Disorder'),
    ('Olivia Wilson', 1005, 'A-', 'Anemia'),
    ('Ethan Thomas', 1006, 'B+', 'Celiac Disease'),
    ('Isabella White', 1007, 'AB-', 'Psoriasis'),
    ('James Harris', 1008, 'O-', 'Rheumatoid Arthritis'),
    ('Ava Martin', 1009, 'A+', 'Hypothyroidism'),
    ('William Jackson', 1010, 'B-', 'Fibromyalgia'),
    ('Emma Clark', 1011, 'O+', 'Hypertension'),  
    ('Liam Adams', 1012, 'A-', 'Diabetes'),        
    ('Charlotte Moore', 1013, 'B+', 'Asthma'),     
    ('Noah Wilson', 1014, 'AB-', 'Migraine'),      
    ('Mia Turner', 1015, 'O-', 'Arthritis');    
	
select * from Patients

--creating table for Donors--

create table Donors (
    Unique_ID int primary key,
    Donor_Name varchar(50),
    Blood_Group varchar(10),
    Medical_Report varchar(100),
    Donor_Address varchar(100),
    Contact_Number varchar(15)
);

insert into Donors (Unique_ID, Donor_Name, Blood_Group, Medical_Report, Donor_Address, Contact_Number)
values
    (2001, 'John Smith', 'O+', 'Good', '123 Main Street, City, Country', '+1234567890'),
    (2002, 'Alice Johnson', 'A-', 'Average', '456 Elm Street, City, Country', '+1987654321'),
    (2003, 'Michael Brown', 'B+', 'Excellent', '789 Oak Street, City, Country', '+1122334455'),
    (2004, 'Emily Davis', 'AB-', 'Good', '321 Maple Street, City, Country', '+1567890123'),
    (2005, 'Christopher Wilson', 'O-', 'Poor', '654 Pine Street, City, Country', '+1678901234'),
    (2006, 'Jessica Martinez', 'A+', 'Good', '987 Cedar Street, City, Country', '+1345678901'),
    (2007, 'Daniel Taylor', 'B-', 'Average', '234 Birch Street, City, Country', '+1901234567'),
    (2008, 'Sophia Garcia', 'AB+', 'Excellent', '567 Spruce Street, City, Country', '+1456789012'),
    (2009, 'Matthew Anderson', 'O+', 'Good', '890 Walnut Street, City, Country', '+1789012345'),
    (2010, 'Olivia Miller', 'A-', 'Average', '432 Cherry Street, City, Country', '+1234509876'),
    (2011, 'Ethan Thomas', 'B+', 'Good', '765 Sycamore Street, City, Country', '+1567890234'),
    (2012, 'Isabella White', 'AB-', 'Excellent', '098 Cedar Street, City, Country', '+1987654321'),
    (2013, 'James Harris', 'O-', 'Good', '345 Birch Street, City, Country', '+1123456789'),
    (2014, 'Ava Martin', 'A+', 'Average', '678 Oak Street, City, Country', '+1345678901'),
    (2015, 'William Jackson', 'B-', 'Excellent', '901 Maple Street, City, Country', '+1678901234');

select * from Donors;

--creating table for Blood Banks--

create table Blood_Banks (
    Blood_Bank_ID int primary key,
    Blood_Bank_Name varchar(100),
    Bank_Address varchar(100)
);

insert into Blood_Banks (Blood_Bank_ID, Blood_Bank_Name, Bank_Address)
values
    (3001, 'Red Cross Blood Bank', '123 Main Street, City, Country'),
    (3002, 'City Blood Bank', '456 Elm Street, City, Country'),
    (3003, 'Hope Blood Bank', '789 Oak Street, City, Country'),
    (3004, 'Life Saver Blood Bank', '321 Maple Street, City, Country'),
    (3005, 'Unity Blood Bank', '654 Pine Street, City, Country');

select * from Blood_Banks

--creating table for Blood Bank Donors--

create table Blood_Bank_Donors (
    Donor_ID int primary key,
    Blood_Bank_ID int,
    Donor_Name varchar(50),
    Bank_Address varchar(100),
    Contact_Number varchar(15),
    foreign key (Blood_Bank_ID) references Blood_Banks(Blood_Bank_ID));

insert into Blood_Bank_Donors (Donor_ID, Blood_Bank_ID, Donor_Name, Bank_Address, Contact_Number)
values
    (4001, 3001, 'John Smith', '123 Main Street, City, Country', '+1234567890'),
    (4002, 3001, 'Alice Johnson', '456 Elm Street, City, Country', '+1987654321'),
    (4003, 3002, 'Michael Brown', '789 Oak Street, City, Country', '+1122334455'),
    (4004, 3002, 'Emily Davis', '321 Maple Street, City, Country', '+1567890123'),
    (4005, 3003, 'Christopher Wilson', '654 Pine Street, City, Country', '+1678901234'),
    (4006, 3003, 'Jessica Martinez', '987 Cedar Street, City, Country', '+1345678901'),
    (4007, 3004, 'Daniel Taylor', '234 Birch Street, City, Country', '+1901234567'),
    (4008, 3004, 'Sophia Garcia', '567 Spruce Street, City, Country', '+1456789012'),
    (4009, 3005, 'Matthew Anderson', '890 Walnut Street, City, Country', '+1789012345'),
    (4010, 3005, 'Olivia Miller', '432 Cherry Street, City, Country', '+1234509876');

select * from Blood_Bank_Donors;


-- Checking the compatibility between donors and Recipients--

select
    R.Patient_Name as Recipient_Name,
    D.Donor_Name as Donor_Name,
    case
        when R.Blood_group = 'O-' then 'Yes' 
        when R.Blood_group = 'O+' and D.Blood_group in ('O+', 'A+', 'B+', 'AB+') then 'Yes'
        when R.Blood_group = 'A-' and D.Blood_group in ('A-', 'A+', 'AB-', 'AB+') then 'Yes'
		WHEN R.Blood_group = 'A+' AND D.Blood_group IN ('A+', 'AB+') THEN 'Yes'
        WHEN R.Blood_group = 'B-' AND D.Blood_group IN ('B-', 'B+', 'AB-', 'AB+') THEN 'Yes'
        WHEN R.Blood_group = 'B+' AND D.Blood_group IN ('B+', 'AB+') THEN 'Yes'
        WHEN R.Blood_group = 'AB-' AND D.Blood_group IN ('AB-', 'AB+') THEN 'Yes'
        WHEN R.Blood_group = 'AB+' AND D.Blood_group = 'AB+' THEN 'Yes'
        else 'No'
    end as Compatibility
from
    Patients R 
join
    Donors D on 1=1 -- Cross join, each recipient can be paired with each donor
order by
    R.Patient_Name, D.Donor_Name;

--Corresponding Bank for each Donor--

select 
     D.Donor_Name as Donor,
	 BB.Blood_Bank_Name as Bank
   From 
	 Donors D
	 left join 
	 Blood_Bank_Donors BBD on D.Donor_Name=BBD.Donor_Name
     left join
	 Blood_Banks BB on BBD.Blood_Bank_ID=BB.Blood_Bank_ID;