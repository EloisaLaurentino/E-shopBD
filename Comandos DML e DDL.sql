-- DROP TABLE delivery_to;DROP TABLE contain;DROP TABLE payment;DROP TABLE manage;DROP TABLE save_to_shopping_cart;
-- DROP TABLE after_sales_service_at;DROP TABLE addrss;DROP TABLE orders;DROP TABLE orderItem;DROP TABLE creditCard;DROP TABLE debitCard;
-- DROP TABLE bank_card;DROP TABLE seller;DROP TABLE comments;DROP TABLE buyer;DROP TABLE users;DROP TABLE product;
-- DROP TABLE store;DROP TABLE servicePoint;DROP TABLE brand;
DROP DATABASE eShopContent;
CREATE DATABASE eShopContent;


USE eShopContent;


CREATE TABLE users(
	pk_userId     	INT NOT NULL auto_increment,
    nameUser   		VARCHAR(40) NOT NULL,
    phoneNumber 	VARCHAR(12),
    
    PRIMARY KEY 	(pk_userId)
);

CREATE TABLE buyer(
	pk_userId   	INT NOT NULL AUTO_INCREMENT,
    
    PRIMARY KEY(pk_userId),
    FOREIGN KEY (pk_userId) REFERENCES users (pk_userId)
);

CREATE TABLE seller(
	pk_userId      	INT NOT NULL AUTO_INCREMENT,
    
    PRIMARY KEY (pk_userId),
    FOREIGN KEY (pk_userId) REFERENCES users (pk_userId)
);

CREATE TABLE address(
	pk_addId		INT NOT NULL,
    fk_userId		INT NOT NULL,
    name			VARCHAR(50),
    contactPhoneNumber VARCHAR(20),
    province  VARCHAR(100),
    city	VARCHAR(100),
    streetaddr	VARCHAR(100),
    postCODE 	VARCHAR(12),
    
    PRIMARY KEY (pk_addId),
    FOREIGN KEY (fk_userId) REFERENCES users (pk_userId)
);

CREATE TABLE bankCard(
	pk_cardNumber 		VARCHAR(200) NOT NULL,
    expiryDate    		DATE NOT NULL,
    bank                VARCHAR(20),
    PRIMARY KEY (pk_cardNumber)
);

CREATE TABLE  creditCard(
	pk_cardNumber  VARCHAR(200) NOT NULL,
    fk_userId		INT NOT NULL,
    organization        VARCHAR(50),

	PRIMARY KEY (pk_cardNumber),
    FOREIGN KEY (pk_cardNumber) REFERENCES bankCard (pk_cardNumber),
    FOREIGN KEY (fk_userId) REFERENCES users (pk_userId)
);

CREATE TABLE debitCard(
	pk_cardNumber    	VARCHAR(16) NOT NULL,
    fk_userId           INT NOT NULL,
    
    PRIMARY KEY (pk_cardNumber),
    FOREIGN KEY (pk_cardNumber) REFERENCES bankCard (pk_cardNumber),
    FOREIGN KEY (fk_userId) REFERENCES	users (pk_userId)
);

CREATE TABLE store(
	pk_sid		 INT NOT NULL,
    name		VARCHAR(50) NOT NULL,
    provice		VARCHAR(35) not null,
    city 		VARCHAR(40)	NOT NULL,
    streetaddr  VARCHAR(20),
    customerGrade 	INT,
    starTime		DATE,
    
    PRIMARY KEY (pk_sid)
);

CREATE TABLE brand (
	pk_brandName  VARCHAR(50) NOT NULL,
    
    PRIMARY KEY (pk_brandName)
);

CREATE TABLE product(

	pk_pid		INT NOT NULL,
    fk_sid		INT(11) NOT NULL,
    fk_brandName VARCHAR(50) NOT NULL,
    name		VARCHAR(120) NOT NULL,
	type		VARCHAR(50),
    modelNumber	VARCHAR(50) UNIQUE,
    color		VARCHAR(20),
    amount 		INT DEFAULT	 NULL,
    price		DECIMAL(6,2) NOT NULL,
    
    
    
    PRIMARY KEY (pk_pid),
    FOREIGN KEY (fk_sid) REFERENCES store(pk_sid),
    FOREIGN KEY (fk_brandName)	REFERENCES brand (pk_brandName)
);

CREATE TABLE orderItem(
	pk_itemId		INT NOT NULL AUTO_INCREMENT,
    fk_pid 			INT NOT NULL,
    price			DECIMAL(6,2),
    creationTime TIME NOT NULL,
    
    PRIMARY KEY  (pk_itemId),
    FOREIGN KEY (fk_pid) REFERENCES product (pk_pid)
);

CREATE TABLE orders(
	pk_orderNumber		INT NOT NULL,
    payment_state		ENUM('Paid', 'Unpaid'),
    creation_time		TIME NOT NULL,
    totalAumout			DECIMAL(10,2),
    
    PRIMARY KEY (pk_orderNumber)
);



CREATE TABLE comments(-- entidade fraca
	creationTime	DATE NOT NULL,
	fk_userId		INT NOT NULL,
    fk_pid			INT NOT NULL,
    grade			FLOAT,
    content			VARCHAR(500),
    
    PRIMARY KEY     (creationTime,fk_userId,fk_pid),
    FOREIGN KEY		(fk_userId)	REFERENCES	users (pk_userId),
    FOREIGN KEY     (fk_pid)	REFERENCES  product (pk_pid)
);

CREATE TABLE servicePoint(
	pk_spid		INT NOT NULL,
    streetaddr	VARCHAR(100) NOT NULL,
    city		VARCHAR(50),
    province	VARCHAR(50),
    starTime 	VARCHAR(20),
    endTime		VARCHAR(20),
    
    PRIMARY KEY (pk_spid)
);

CREATE TABLE save_to_shopping_cart(
	fk_userId	INT NOT NULL,
    fk_pid		INT NOT NULL,
    addTime		DATE NOT NULL,
    quantity	INT,
    
    PRIMARY KEY (fk_userId,fk_pid),
    FOREIGN KEY (fk_userId)	REFERENCES users(pk_userId),
    FOREIGN KEY (fk_pid) 	REFERENCES product(pk_pid)
    
    
);

CREATE TABLE contain(
	fk_orderNumber  	INT NOT NULL,
    fk_itemId			INT NOT NULL,
    quantity			INT,
    
    PRIMARY KEY (fk_orderNumber,fk_itemId),
    FOREIGN KEY (fk_orderNumber) REFERENCES orders (pk_orderNumber),
    FOREIGN KEY (fk_itemId)	REFERENCES orderItem (pk_itemId)
);

CREATE TABLE payment(
	fk_orderNumber	INT NOT NULL,
    fk_cardNumber VARCHAR(25) NOT NULL,
    payTime			DATE,
    
    PRIMARY KEY (fk_orderNumber,fk_cardNumber),
    FOREIGN KEY(fk_orderNumber) REFERENCES 	orders (pk_orderNumber),
    FOREIGN KEY (fk_cardNumber) REFERENCES bankCard(pk_cardNumber)
);

CREATE TABLE deliver_to(
	fk_addId		INT NOT NULL,
    fk_orderNumber	INT NOT NULL,
    TimeDelevered 	DATE,
    
    PRIMARY KEY(fk_addID,fk_orderNumber),
    FOREIGN KEY(fk_addID) REFERENCES address(pk_addID),
    FOREIGN KEY(fk_orderNumber) REFERENCES orders(pk_orderNumber)
);

CREATE TABLE manage(
	fk_userid             INT NOT NULL,
    fk_sid                 INT NOT NULL,
    setUpTime             DATE,
    
    PRIMARY KEY(fk_userid,fk_sid),
    FOREIGN KEY(fk_userid) REFERENCES seller(pk_userid),
    FOREIGN KEY(fk_sid) REFERENCES store (pk_sid)
);

CREATE TABLE After_Sales_Service_At(
    fk_brandName         VARCHAR(20) NOT NULL,
    fk_spid             INT NOT NULL,
    
    PRIMARY KEY(fk_brandName, fk_spid),
    FOREIGN KEY(fk_brandName) REFERENCES brand (pk_brandName),
    FOREIGN KEY(fk_spid) REFERENCES servicePoint(pk_spid)
);


