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

-- get resources based off rule id and customer id--

DELIMITER //
CREATE PROCEDURE get_resource_for_rules(ruleID int, cID int)
BEGIN
	SELECT resource.resource_name, resource.resource_id
	FROM resource
	LEFT JOIN resource_type ON resource.resource_type_id = resource_type.resource_type_id
	LEFT JOIN rule ON resource_type.resource_type_id = rule.resource_type_id
    LEFT JOIN account ON account.account_id = resource.account_id
    LEFT JOIN customer ON customer.customer_id = account.account_id
	WHERE rule.rule_id = ruleID AND customer.customer_id = cID;
END //
DELIMITER ;exception

-- gets non compliant resources for a rule -- 

DELIMITER //
CREATE PROCEDURE get_non_compliant_resource_for_rules(ruleID int, cID int)
BEGIN
	SELECT resource.resource_name, resource.resource_id
	FROM resource
	LEFT JOIN resource_type ON resource.resource_type_id = resource_type.resource_type_id
	LEFT JOIN rule ON resource_type.resource_type_id = rule.resource_type_id
    LEFT JOIN account ON account.account_id = resource.account_id
    LEFT JOIN customer ON customer.customer_id = account.account_id
    LEFT JOIN non_compliance ON non_compliance.resource_id = resource.resource_id
	WHERE rule.rule_id = ruleID AND customer.customer_id = cID AND non_compliance.resource_id = resource.resource_id;
END //
DELIMITER ;


-- gets exceptions for a resource for a rule --


DELIMITER //
CREATE PROCEDURE get_exception_for_resource(resourceID int, cID int, ruleID int)
BEGIN
	SELECT exception.exception_value, exception.review_date, exception.last_updated, exception.resource_id
	FROM exception
	LEFT JOIN resource ON exception.resource_id = resource.resource_id 
    LEFT JOIN account ON account.account_id = resource.account_id
    LEFT JOIN customer ON customer.customer_id = account.account_id
    LEFT JOIN user ON user.customer_id = customer.customer_id
    LEFT JOIN rule on rule.rule_id = exception.rule_id
	WHERE resource.resource_id = resourceID AND customer.customer_id = cID and rule.rule_id = ruleID
    ORDER BY exception.review_date DESC;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_exceptions(resourceID int, cID int)
BEGIN
	SELECT exception.exception_value, user.user_name, exception.justification, exception.review_date,  exception.last_updated, exception.exception_id
	FROM exception
	LEFT JOIN resource ON exception.resource_id = resource.resource_id 
    LEFT JOIN account ON account.account_id = resource.account_id
    LEFT JOIN customer ON customer.customer_id = account.account_id
    LEFT JOIN user ON user.user_id = exception.last_updated_by
	WHERE resource.resource_id = resourceID AND customer.customer_id = cID;
END //

DELIMITER ;

-- suspend exception --
DELIMITER //
CREATE PROCEDURE suspend_exception(exceptionID int, uID int)
BEGIN
	INSERT INTO exception_audit (exception_id,user_id,customer_id,rule_id,action,action_dt,resource_id, old_exception_value, old_justification, old_review_date, new_justification) SELECT exception_id,uID,customer_id,rule_id,"SUSPEND",NOW(),resource_id, exception_value, justification, review_date, "N/A" FROM exception WHERE exception.exception_id = exceptionID; 
    DELETE FROM exception WHERE exception_ID = exceptionID; 
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE expired_exception(exceptionID int)
BEGIN
	INSERT INTO exception_audit (exception_id,customer_id,rule_id,action,action_dt,resource_id, old_exception_value, old_justification, old_review_date, new_justification) SELECT exception_id,customer_id,rule_id,"EXPIRED",NOW(),resource_id, exception_value, justification, review_date, "N/A" FROM exception WHERE exception.exception_id = exceptionID; 
    DELETE FROM exception WHERE exception_ID = exceptionID; 
END //
DELIMITER ;




-- update exception -- 

DELIMITER //
CREATE PROCEDURE update_exception(exceptionID int, uID int, NewReviewDate timestamp, NewJustification varchar(255))
BEGIN
	INSERT INTO exception_audit (exception_id,user_id,customer_id,rule_id,action,action_dt,new_review_date,new_justification,old_review_date,old_justification,resource_id,new_exception_value, old_exception_value) SELECT exception_id,uID,customer_id,rule_id,"UPDATE",NOW(),NewReviewDate,NewJustification,review_date,justification,resource_id, exception_value, exception_value FROM exception WHERE exception.exception_id = exceptionID; 
    UPDATE exception SET review_date = NewReviewDate, justification = NewJustification, last_updated_by = uID, last_updated = NOW() WHERE exception_ID = exceptionID;
    #last update by is being set to the customer ID but might actually supposed to be USER ID
END //
DELIMITER ;

-- get history for all exceptions of a resource -- 

DELIMITER //
CREATE PROCEDURE get_Exception_History_For_Resource(cID int, rID int)
BEGIN
SELECT action, action_dt, old_exception_value, new_justification, old_justification, new_review_date, old_review_date, user.user_name FROM exception_audit LEFT JOIN user ON user.user_id = exception_audit.user_id
    WHERE exception_audit.customer_id = cID AND exception_audit.resource_id = rID  
    ORDER BY action_dt DESC;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_exceptions_for_resource_for_a_rule(ruleID int, cID int)
BEGIN
	SELECT resource.resource_name, resource.resource_id, exception.review_date
	FROM resource
	LEFT JOIN resource_type ON resource.resource_type_id = resource_type.resource_type_id
	LEFT JOIN rule ON resource_type.resource_type_id = rule.resource_type_id
    LEFT JOIN account ON account.account_id = resource.account_id
    LEFT JOIN customer ON customer.customer_id = account.account_id
    LEFT JOIN exception ON exception.resource_id = resource.resource_id
	WHERE rule.rule_id = ruleID AND customer.customer_id = cID AND exception.resource_id = resource.resource_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_rule_details(rID int)
BEGIN
SELECT rule_name, rule_description FROM rule WHERE rule.rule_id = rID;
END //
DELIMITER ;
