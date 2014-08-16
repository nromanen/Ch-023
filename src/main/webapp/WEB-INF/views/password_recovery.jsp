<%@ page language="java" contentType="text/html; charset=utf8" pageEncoding="utf8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type='text/javascript' src='<c:url value="/resources/js/lib/validator.js" />'></script>
<script type='text/javascript' src='<c:url value="/resources/js/password_recovery.js" />'></script>
<script src="<c:url value="/resources/js/lib/bootbox.js" />"></script>
<!-- Step 1  -->
<div class="col-md-6 col-md-offset-3">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title"><strong><spring:message code="label.step" /> 1</strong></h3>
        </div>
        <div class="panel-body">
            <form data-toggle="validator">
                <div class="alert alert-danger" id="user_not_exist" style="display: none;">
                    <spring:message code="message.user_not_exist" />
                </div>
                <div class="form-group">
                    <label class="text-info"><spring:message code="label.email" />
                        <span class="text-danger">*</span>:&nbsp;</label> 
                        <input type="text" class="form-control"
                            placeholder="<spring:message code="placeholder.email" />"
                            id="email" required pattern="[A-Za-z0-9_\.-]{1,30}@[A-Za-z0-9_\.-]{1,30}"
                            data-error="<spring:message code="dataerror.email_example" />" />
                    <div class="help-block with-errors"></div>
                </div>
                <input type="button" id="send_secure_code_btn" class="btn btn-primary" 
                        value="<spring:message code="label.send_secure_code" />" />

                <input type="hidden" id="send_secure_code_url" value="<c:url value="/leader/sendSecureCode" />" >
            </form>
        </div>
    </div>
</div>

<!-- Step 2  -->
<div class="col-md-6 col-md-offset-3" id="step_2" style="display: none">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title"><strong><spring:message code="label.step" /> 2</strong></h3>
        </div>
        <div class="panel-body">
            <form data-toggle="validator" role="form">
                <div class="alert alert-danger" id="wrong_secure_code" style="display: none;">
                    <spring:message code="message.wrong_secure_code" />
                </div>
                <div class="form-group">
                    <label class="text-info"><spring:message code="label.secure_code" /><span
                            class="text-danger">*</span>:&nbsp;</label> <input type="text"
                            class="form-control"
                            placeholder="<spring:message code="placeholder.secure_code" />"
                            id="secure_code" required pattern=".{1,255}"
                            data-error="<spring:message code="dataerror.field_required" />" />
                    <div class="help-block with-errors"></div>
                </div>
                <input type="button" id="secure_code_btn" class="btn btn-primary" value="<spring:message code="label.check_secure_code" />" />
                <input type="hidden" id="check_secure_code_url" value="<c:url value="/leader/checkSecureCode" />" >
            </form>
        </div>
    </div>
</div>
<div class="col-md-6 col-md-offset-3" id="step_3" style="display: none">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title"><strong><spring:message code="label.step" /> 3</strong></h3>
        </div>
        <div class="panel-body">
            <form data-toggle="validator" role="form">
                <div class="form-group">
                    <label class="text-info"><spring:message code="label.password" /><span
                            class="text-danger">*</span>:&nbsp;</label> <input type="password"
                            class="form-control"
                            placeholder="<spring:message code="placeholder.password" />"
                            id="password" data-minlength="5" required
                            data-error="<spring:message code="dataerror.mimimum_5_characters" />" />
                    <div class="help-block with-errors"></div>
                </div>

                <div class="form-group">
                    <label class="text-info"><spring:message code="label.confirm_password" /><span class="text-danger">*</span>:&nbsp;</label>
                    <input type="password" class="form-control"
                        placeholder="<spring:message code="placeholder.confirm_password" />"
                        id="password2" data-match="#password" required
                        data-match-error="<spring:message code="dataerror.passwords_don't_match" />"
                        data-error="<spring:message code="dataerror.field_required" />" />
                    <div class="help-block with-errors"></div>
                    <div id="error_password" style="display: none"></div>
                    <div class="alert alert-danger" id="password_error" style="display: none; padding: 0px 0px 0px 20px; height: 25px;">
                        <spring:message code="dataerror.passwords_do_not_match" />
                    </div>
                </div>
                <button id="change_password" class="btn btn-primary">
                    <spring:message code="label.change_password" />
                </button>
                <input type="hidden" id="change_password_url" value="<c:url value="/leader/changePassword" />" >
            </form>
        </div>
    </div>
</div>