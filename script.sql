USE mspr_java;

--DROP TABLE BusinessIncident;
--DROP TABLE Users_Worksite;
--DROP TABLE BusinessProject;
--DROP TABLE Incident;
--DROP TABLE Video;
--DROP TABLE Projects;
--DROP TABLE Worksite;
--DROP TABLE Users;
--DROP TABLE Business;

CREATE TABLE Users (
	id INT IDENTITY(1,1),
	firstname nvarchar(255),
	lastname nvarchar(255),
    rights nvarchar(255),
    yearStart nvarchar(255),   
	PRIMARY KEY(id)
);

CREATE TABLE Worksite (
	id INT NOT NULL,
	latitude DECIMAL,
    longitude DECIMAL,
    name nvarchar(255),
    startDate DATE,
    endDate DATE,
	PRIMARY KEY(id)
);

CREATE TABLE Projects (
	id INT NOT NULL,
	startDate date,
    endDate date,
	idWorksite INT,
	name nvarchar(255),
	PRIMARY KEY(id),
    CONSTRAINT Project_Worksite_FK FOREIGN KEY (idWorksite) REFERENCES Worksite(id)
);

CREATE TABLE Video (
	id INT NOT NULL,
    idProject INT,
	name nvarchar(255),
    refGant INT,
    indoor bit,
    latitude DECIMAL,
    longitude DECIMAL,
    video nvarchar(255),
	PRIMARY KEY(id),
    CONSTRAINT Video_Project_FK FOREIGN KEY (idProject) REFERENCES Projects(id)
);

CREATE TABLE Incident (
	id INT IDENTITY(1,1),
    idVideo INT NOT NULL,
	description nvarchar(255),
	PRIMARY KEY(id),
    CONSTRAINT Incident_Video_FK FOREIGN KEY (idVideo) REFERENCES Video(id)
);

CREATE TABLE Users_Worksite (
	idWorksite INT NOT NULL,
	idUser INT NOT NULL,
	PRIMARY KEY(idWorksite, idUser),
    CONSTRAINT UserWorksite_User_FK FOREIGN KEY (idUser) REFERENCES Users(id),
    CONSTRAINT UserWorksite_Worksite_FK FOREIGN KEY (idWorksite) REFERENCES Worksite(id)
);

CREATE TABLE Business (
	siret INT NOT NULL,
    name nvarchar(255),
    address nvarchar(255),
    employees INT,
    phone nvarchar(16),
    mail nvarchar(255),
	description nvarchar(255),
	PRIMARY KEY(siret)
);

CREATE TABLE BusinessIncident (
	idIncident INT NOT NULL,
    idBusiness INT NOT NULL,
	PRIMARY KEY(idIncident, idBusiness),
    CONSTRAINT BusinessIncident_Incident_FK FOREIGN KEY (idIncident) REFERENCES Incident(id),
    CONSTRAINT BusinessIncident_Business_FK FOREIGN KEY (idBusiness) REFERENCES Business(siret)
);

CREATE TABLE BusinessProject (
	idBusiness INT NOT NULL,
    idProject INT NOT NULL,
	PRIMARY KEY(idBusiness, idProject),
    CONSTRAINT BusinessProject_Business_FK FOREIGN KEY (idBusiness) REFERENCES Business(siret),
    CONSTRAINT BusinessProject_Project_FK FOREIGN KEY (idProject) REFERENCES Projects(id)
);

