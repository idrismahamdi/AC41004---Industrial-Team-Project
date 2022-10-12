
-- Login verifcation for users--
DELIMITER //
CREATE FUNCTION login(uName VARCHAR(255), uPassword VARCHAR(255)) RETURNS INT
BEGIN
	if EXISTS(select * from user where uName = user.user_name and uPassword = user.user_password)
		THEN
			return 1;

	ELSE 
		        return 0;
	END if;
END //
DELIMITER ;

--Gathers accounts based off userID--

DELIMITER //
CREATE PROCEDURE gather_accounts(uID int)
BEGIN

SELECT account.account_ref FROM account, customer, user WHERE account.customer_id = customer.customer_id AND user.user_ID = uID;

END //
DELIMITER ;

-- get resoureces based off rule id and customer id--

DELIMITER //
CREATE PROCEDURE get_resource_for_rules(ruleID int, cID int)
BEGIN
	SELECT resource.resource_name
	FROM resource
	LEFT JOIN resource_type ON resource.resource_type_id = resource_type.resource_type_id
	LEFT JOIN rule ON resource_type.resource_type_id = rule.resource_type_id
    LEFT JOIN account ON account.account_id = resource.account_id
    LEFT JOIN customer ON customer.customer_id = account.account_id
	WHERE rule.rule_id = ruleID AND customer.customer_id = cID;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_non_compliant_resource_for_rules(ruleID int, cID int)
BEGIN
	SELECT resource.resource_name
	FROM resource
	LEFT JOIN resource_type ON resource.resource_type_id = resource_type.resource_type_id
	LEFT JOIN rule ON resource_type.resource_type_id = rule.resource_type_id
    LEFT JOIN account ON account.account_id = resource.account_id
    LEFT JOIN customer ON customer.customer_id = account.account_id
    LEFT JOIN non_compliance ON non_compliance.resource_id = resource.resource_id
	WHERE rule.rule_id = ruleID AND customer.customer_id = cID AND non_compliance.resource_id = resource.resource_id;
END //
DELIMITER ;

-- gets non compliant resources for a rule -- 

DELIMITER //
CREATE PROCEDURE get_non_compliant_resource_for_rules(ruleID int, cID int)
BEGIN
	SELECT resource.resource_name
	FROM resource
	LEFT JOIN resource_type ON resource.resource_type_id = resource_type.resource_type_id
	LEFT JOIN rule ON resource_type.resource_type_id = rule.resource_type_id
    LEFT JOIN account ON account.account_id = resource.account_id
    LEFT JOIN customer ON customer.customer_id = account.account_id
    LEFT JOIN non_compliance ON non_compliance.resource_id = resource.resource_id
	WHERE rule.rule_id = ruleID AND customer.customer_id = cID AND non_compliance.resource_id = resource.resource_id;
END //
DELIMITER ;

-- gets exception for a resource -- 

DELIMITER //
CREATE PROCEDURE get_exception_for_resource(resourceID int, cID int)
BEGIN
	SELECT exception.exception_value
	FROM exception
    
	LEFT JOIN resource
    ON exception.resource_id = resource.resource_id 
    
    LEFT JOIN account ON account.account_id = resource.account_id
    LEFT JOIN customer ON customer.customer_id = account.account_id
	WHERE resource.resource_id = resourceID AND customer.customer_id = cID;
END //
DELIMITER ;

-- gets exceptions for a resource for a rule --

DELIMITER //
CREATE PROCEDURE get_exceptions_for_resource_for_a_rule(ruleID int, cID int)
BEGIN
	SELECT resource.resource_name
	FROM resource
	LEFT JOIN resource_type ON resource.resource_type_id = resource_type.resource_type_id
	LEFT JOIN rule ON resource_type.resource_type_id = rule.resource_type_id
    LEFT JOIN account ON account.account_id = resource.account_id
    LEFT JOIN customer ON customer.customer_id = account.account_id
    LEFT JOIN exception ON exception.resource_id = resource.resource_id
	WHERE rule.rule_id = ruleID AND customer.customer_id = cID AND exception.resource_id = resource.resource_id;
END //
DELIMITER ;

-- suspend exception --
DELIMITER //
CREATE PROCEDURE suspend_exception(exceptionID int, cID int, uID int)
BEGIN
	INSERT INTO exception_audit (exception_id,user_id,customer_id,rule_id,action,action_dt,resource_id) SELECT exception_id,uID,customer_id,rule_id,"SUSPEND",NOW(),resource_id FROM exception WHERE exception.exception_id = exceptionID AND exception.customer_id = cID; 
    DELETE FROM exception WHERE exception_ID = exceptionID; 
END //
DELIMITER ;

-- update exception -- 

DELIMITER //
CREATE PROCEDURE update_exception(exceptionID int, cID int, NewReviewDate timestamp, NewJustification varchar(255), uID int)
BEGIN
	INSERT INTO exception_audit (exception_id,user_id,customer_id,rule_id,action,action_dt,new_review_date,new_justification,old_review_date,old_justification,resource_id) SELECT exception_id,uID,customer_id,rule_id,"UPDATE",NOW(),NewReviewDate,NewJustification,review_date,justification,resource_id FROM exception WHERE exception.exception_id = exceptionID AND exception.customer_id = cID; 
    UPDATE exception SET review_date = NewReviewDate, justification = NewJustification, last_updated_by = uID, last_updated = NOW() WHERE exception_ID = exceptionID;
    #last update by is being set to the customer ID but might actually supposed to be USER ID
END //
DELIMITER ;

-- get history for all exceptions of a resource -- 

DELIMITER //
CREATE PROCEDURE get_Exception_History_For_Resource(cID int, rID int)
BEGIN
	SELECT * FROM exception_audit WHERE customer_id = cID AND resource_id = rID;
END //
DELIMITER ;
