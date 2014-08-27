<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href='<c:url value="/resources/libs/bootstrapValidator/css/bootstrapValidator.min.css" />' rel="stylesheet">
<script type='text/javascript' src='<c:url value="/resources/js/leader.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/libs/bootstrapValidator/js/bootstrapValidator.min.js" />'></script>

<h2 class="user-info-name">${leader.firstName}&nbsp;${leader.lastName}</h2>
<form class="well" method="POST" action="/Carting/leader/editLeader"
    role="form" name="edit_leader" id="edit_leader">

    <input type="hidden" id="id" value="${leader.id}">
    <p style="margin-top: 15px;">
        <div class="row">
        <div class="form-group col-sm-6">
            <label class="text-info"><spring:message code="label.firstname" /><span class="text-danger">*</span>:&nbsp;</label>
            <input type="text" class="form-control" name="firstName"
                placeholder="<spring:message code="placeholder.firstname" />"
                id="first_name"
                value="${leader.firstName}"
                data-bv-notempty="true"
                data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
                pattern="[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-]{1,30}"
                data-bv-regexp-message="<spring:message code="dataerror.firstname" />" />
            <div class="help-block with-errors"></div>
        </div>
    
        <div class="form-group col-sm-6">
            <label class="text-info"><spring:message code="label.lastname" /><span
                class="text-danger">*</span>:&nbsp;</label> <input type="text"
                class="form-control" name="lastName"
                placeholder="<spring:message code="placeholder.lastname" />"
                id="last_name"
                value="${leader.lastName}"
                data-bv-notempty="true"
                data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
                pattern="[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє\s-]{1,30}"
                data-bv-regexp-message="<spring:message code="dataerror.lastname" />" />
            <div class="help-block with-errors"></div>
        </div>
    </div>


    
    <div class="row">
        <div class="form-group col-sm-6">
            <label class="text-info"><spring:message
                    code="label.date_of_birth" /><span class="text-danger">*</span>:&nbsp;</label>
            <input type="text" 
                class="form-control" 
                name="birthday"
                id="birthday"
                value="${leaderBirthday}"
                placeholder="<spring:message code="placeholder.date_of_birth" />"
                data-bv-notempty="true"
                data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
                data-bv-date-format="YYYY-MM-DD"
                data-bv-date-message="<spring:message code="dataerror.valid_date_yyyy_mm_dd" />" />
            <div class="help-block with-errors"></div>
        </div>
    
        <div class="form-group col-sm-6">
            <label class="text-info"><spring:message
                    code="label.identification" /><span class="text-danger">*</span>:&nbsp;</label>
            <input type="text" class="form-control" name="document"
                placeholder="<spring:message code="placeholder.identification" />"
                id="document"
                value=${leader.document }
                data-bv-notempty="true"
                data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
                pattern="[^<>\&\^\$]{1,50}"
                data-bv-regexp-message="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;50." />
            <div class="help-block with-errors"></div>
        </div>
    </div>
    <div class="row">
        <div class="form-group col-sm-6">
            <label class="text-info"><spring:message code="label.address" /><span
                class="text-danger">*</span>:&nbsp;</label> <input type="text"
                class="form-control" name="address"
                placeholder="<spring:message code="placeholder.address" />"
                id="address"
                value="${leader.address}"
                data-bv-notempty="true"
                data-bv-notempty-message="<spring:message code="dataerror.field_required" />" 
                pattern="[^<>\&\^\$]{1,100}"
                data-bv-regexp-message="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;100." />
            <div class="help-block with-errors"></div>
        </div>
    
        <div class="form-group col-sm-6">
            <label class="text-info"><spring:message
                    code="label.license_number" /><span class="text-danger">*</span>:&nbsp;</label>
            <input type="text" class="form-control" name="license"
                placeholder="<spring:message code="placeholder.license_number" />"
                id="license"
                value="${leader.license}"
                data-bv-notempty="true"
                data-bv-notempty-message="<spring:message code="dataerror.field_required" />"
                pattern="[^<>\&\^\$]{1,30}"
                data-bv-regexp-message="<spring:message code="dataerror.field_required" />&nbsp;<spring:message code="dataerror.max_length_is" />&nbsp;30." />
            <div class="help-block with-errors"></div>
        </div>
    </div>
    
    <br> <input type="submit" class="btn btn-primary"
        value="<spring:message code="label.accept" />" id="edit_leader_button">
    <a href="/Carting/leader/${leader.id}"> <input type="button"
        class="btn btn-default" value="<spring:message code="label.cancel" />" />
    </a> <img src='<c:url value="/resources/img/ajax-loader.gif" />'
        style="display: none;" id="ajax_loader">
</form>