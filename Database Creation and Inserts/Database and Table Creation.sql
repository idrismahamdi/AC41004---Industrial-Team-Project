DROP DATABASE IF EXISTS brightsolid;
CREATE DATABASE IF NOT EXISTS brightsolid;
USE brightsolid;

CREATE TABLE platform (
	platform_id serial NOT NULL,
    platform_name varchar(255) NOT NULL,
    PRIMARY KEY (platform_id)
);

CREATE TABLE resource_type (
	resource_type_id serial NOT NULL,
    resource_type_name varchar(255) NOT NULL,
    platform_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (platform_id) REFERENCES platform(platform_id),
    PRIMARY KEY (resource_type_id)
	

);

CREATE TABLE customer (
	customer_id serial NOT NULL,
    customer_name varchar(255) NOT NULL,
    
    PRIMARY KEY (customer_id)
);

CREATE TABLE account (
	account_id serial NOT NULL,
    account_ref varchar(255) NOT NULL,
    platform_id BIGINT UNSIGNED NOT NULL,
    customer_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY (platform_id) REFERENCES platform(platform_id),
    PRIMARY KEY (account_id)
);


CREATE TABLE resource (
	resource_id serial NOT NULL,
    resource_ref varchar(255) NOT NULL,
    account_id BIGINT UNSIGNED NOT NULL,
    resource_type_id BIGINT UNSIGNED NOT NULL,
    resource_name varchar(255) NOT NULL,
    last_updated timestamp NOT NULL,
    resource_metadata json NOT NULL,
    FOREIGN KEY (resource_type_id) REFERENCES resource_type(resource_type_id),
    FOREIGN KEY (account_id) REFERENCES account(account_id),
    PRIMARY KEY (resource_id)
	

);


CREATE TABLE user_role (
	user_role_id serial NOT NULL,
    user_role_name varchar(255) NOT NULL,
    
    PRIMARY KEY (user_role_id)
);

CREATE TABLE user (
	user_id serial NOT NULL,
    user_name varchar(255) NOT NULL,
    user_password varchar(255) NOT NULL,
    role_id BIGINT UNSIGNED NOT NULL,
    customer_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (role_id) REFERENCES user_role(user_role_id),
	PRIMARY KEY (user_id)
     
);

CREATE TABLE rule (
	rule_id serial NOT NULL,
    rule_name varchar(255) NOT NULL,
    resource_type_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (resource_type_id) REFERENCES resource_type(resource_type_id),
	PRIMARY KEY (rule_id)
);

CREATE TABLE non_compliance (
	resource_id BIGINT UNSIGNED NOT NULL,
    rule_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (resource_id) REFERENCES resource(resource_id),
	FOREIGN KEY (rule_id) REFERENCES rule(rule_id)
);

CREATE TABLE non_compliance_audit (
	non_compliance_audit_id serial NOT NULL,
    non_compliance_id int(4) NOT NULL,
    resource_id BIGINT UNSIGNED NOT NULL,
    rule_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    action varchar(255) NOT NULL,
    action_dt timestamp NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
	FOREIGN KEY (resource_id) REFERENCES resource(resource_id),
    FOREIGN KEY (rule_id) REFERENCES rule(rule_id),
    PRIMARY KEY (non_compliance_audit_id)
);

CREATE TABLE exception (
	exception_id serial NOT NULL,
    customer_id BIGINT UNSIGNED NOT NULL,
    rule_id BIGINT UNSIGNED NOT NULL,
    last_updated_by BIGINT UNSIGNED NOT NULL,
    exception_value varchar(255) NOT NULL,
    justification varchar(255) NOT NULL,
    review_date timestamp NOT NULL,
    last_updated timestamp NOT NULL,
	 FOREIGN KEY (last_updated_by) REFERENCES user(user_id), /* unsure */
	FOREIGN KEY (rule_id) REFERENCES rule(rule_id),
	 FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
     PRIMARY KEY (exception_id)
);

CREATE TABLE exception_audit (
	exception_audit_id serial NOT NULL,
    exception_id int(4) NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    customer_id BIGINT UNSIGNED NOT NULL,
    rule_id BIGINT UNSIGNED NOT NULL,
    action varchar(255) NOT NULL,
    action_dt timestamp NOT NULL,
    old_exception_value varchar(255),
    new_exception_value varchar(255),
    old_justification varchar(255),
    new_justification varchar(255),
    old_review_date timestamp,
    new_review_date timestamp,
    FOREIGN KEY (user_id) REFERENCES user(user_id), 
    FOREIGN KEY (rule_id) REFERENCES rule(rule_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),

	PRIMARY KEY (exception_audit_id)
);
