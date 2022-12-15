const successStyle = {'border-bottom': '1px solid var(--secondary-color)'};
const errorStyle = {'border-bottom': '1px solid var(--danger)'};

var nameEl, nameErrorEl, nameTickEl,
emailEl, emailErrorEl, emailTickEl,
dobEl, dobErrorEl, dobTickEl,
contactEl, contactErrorEl, contactEl,
address1El, address1ErrorEl, address1TickEl,
address2El, address2ErrorEl, address2TickEl,
pincodeEl, pincodeErrorEl, pincodeTickEl,
newPwdEl, newPwdErrorEl, newPwdTickEl,
confirmPwdEl, confirmPwdErrorEl, confirmPwdTickEl,
showPwdEl,
agreementEl, agreementErrorEl,
registerBtnEl,
signupFormEl;

$(()=>{
    nameEl = $('#name');
    nameErrorEl = $('#name-error');
    nameTickEl = $('#name-tick');
    emailEl = $('#email');
    emailErrorEl = $('#email-error');
    emailTickEl = $('#email-tick');
    dobEl = $('#dob');
    dobErrorEl = $('#dob-error');
    dobTickEl = $('#dob-tick');
    contactEl = $('#contact');
    contactErrorEl = $('#contact-error');
    contactTickEl = $('#contact-tick');
    address1El = $('#address1');
    address1ErrorEl = $('#address1-error');
    address1TickEl = $('#address1-tick');
    address2El = $('#address2');
    address2ErrorEl = $('#address2-error');
    address2TickEl = $('#address2-tick');
    pincodeEl = $('#pincode');
    pincodeErrorEl = $('#pincode-error');
    pincodeTickEl = $('#pincode-tick');
    newPwdEl = $('#new-password');
    newPwdErrorEl = $('#new-password-error');
    newPwdTickEl = $('#new-password-tick');
    confirmPwdEl = $('#confirm-password');
    confirmPwdErrorEl = $('#confirm-password-error');
    confirmPwdTickEl = $('#confirm-password-tick');
    showPwdEl = $('#show-password');
    agreementEl = $('#agreement');
    agreementErrorEl = $('#agreement-error');
    registerBtnEl = $('#register-btn');
    signupFormEl = $('#signup-form');

    nameEl.blur(()=>{validateName()});
    emailEl.blur(()=>{validateEmail()});
    dobEl.blur(()=>{validateDOB()});
    contactEl.blur(()=>{validateContact()});
    address1El.blur(()=>{validateAddressLine1()});
    address2El.blur(()=>{validateAddressLine2()});
    pincodeEl.blur(()=>{validatePincode()});
    newPwdEl.blur(()=>{validateNewPassword()});
    confirmPwdEl.blur(()=>{validateConfirmPassword()});
    showPwdEl.click(()=>{
        togglePwdVisibility();
    });
    agreementEl.change(()=>{validateAgreement()});
    signupFormEl.submit((e)=>{
        if(isFormValid()){
            alert("Signup request sent successfully.");
            return true;
        }
        else{
            return false;
        }
    });
});

/*
    Seperated the actual validation logic and styling logic
*/

function validateName(){
    let name = nameEl.val();
    nameErrorEl.html("");
    let result = isNameValid(name);
    if(result.isValid){
        nameEl.css(successStyle);
        nameTickEl.prop('hidden', false);
        return true;
    }
    else{
        nameTickEl.prop('hidden', true);
        nameErrorEl.html(result.error);
        nameEl.css(errorStyle);
        return false;
    }
}

function validateEmail(){
    let email = emailEl.val();
    emailErrorEl.html("");
    let result = isEmailValid(email);
    if(result.isValid){
        emailEl.css(successStyle);
        emailTickEl.prop('hidden', false);
        return true;
    }
    else{
        emailTickEl.prop('hidden', true);
        emailErrorEl.html(result.error);
        emailEl.css(errorStyle);
        return false;
    }
}

function validateDOB(){
    let dob = dobEl.val();
    dobErrorEl.html("");
    let result = isDOBValid(dob);
    if(result.isValid){
        dobEl.css(successStyle);
        dobTickEl.prop('hidden', false);
        return true;
    }
    else{
        dobTickEl.prop('hidden', true);
        dobErrorEl.html(result.error);
        dobEl.css(errorStyle);
        return false;
    }
}

function validateContact(){
    let contact = contactEl.val();
    contactErrorEl.html("");
    let result = isContactValid(contact);
    if(result.isValid){
        contactEl.css(successStyle);
        contactTickEl.prop('hidden', false);
        return true;
    }
    else{
        contactTickEl.prop('hidden', true);
        contactErrorEl.html(result.error);
        contactEl.css(errorStyle);
        return false;
    }
}

function validateAddressLine1(){
    let address1 = address1El.val();
    address1ErrorEl.html("");
    let result = isAddressLineValid(address1);
    if(result.isValid){
        address1El.css(successStyle);
        address1TickEl.prop('hidden', false);
        return true;
    }
    else{
        address1TickEl.prop('hidden', true);
        address1ErrorEl.html(result.error);
        address1El.css(errorStyle);
        return false;
    }
}
function validateAddressLine2(){
    let address2 = address2El.val();
    address2ErrorEl.html("");
    let result = isAddressLineValid(address2);
    if(result.isValid){
        address2El.css(successStyle);
        address2TickEl.prop('hidden', false);
        return true;
    }
    else{
        address2TickEl.prop('hidden', true);
        address2ErrorEl.html(result.error);
        address2El.css(errorStyle);
        return false;
    }
}

function validatePincode(){
    let pincode = pincodeEl.val();
    pincodeErrorEl.html("");
    let result = isPincodeValid(pincode);
    if(result.isValid){
        pincodeEl.css(successStyle);
        pincodeTickEl.prop('hidden', false);
        return true;
    }
    else{
        pincodeTickEl.prop('hidden', true);
        pincodeErrorEl.html(result.error);
        pincodeEl.css(errorStyle);
        return false;
    }
}

function validateNewPassword(){
    let newPwd = newPwdEl.val();
    newPwdErrorEl.html("");
    let result = isNewPwdValid(newPwd);
    if(result.isValid){
        newPwdEl.css(successStyle);
        newPwdTickEl.prop('hidden', false);
        return true;
    }
    else{
        newPwdTickEl.prop('hidden', true);
        newPwdErrorEl.html(result.error);
        newPwdEl.css(errorStyle);
        return false;
    }
}

function validateConfirmPassword(){
    let confirmPwd = confirmPwdEl.val();
    confirmPwdErrorEl.html("");
    let result = isConfirmPwdValid(confirmPwd);
    if(result.isValid){
        confirmPwdEl.css(successStyle);
        confirmPwdTickEl.prop('hidden', false);
        return true;
    }
    else{
        confirmPwdTickEl.prop('hidden', true);
        confirmPwdErrorEl.html(result.error);
        confirmPwdEl.css(errorStyle);
        return false;
    }
}

function validateAgreement(){
    if(agreementEl.prop('checked')){
        agreementErrorEl.html("");
        return true;
    }
    else{
        agreementErrorEl.html("You have to agree to the Terms of Service.");
        return false;
    }
}

function togglePwdVisibility(){
    if(showPwdEl.prop('checked')){
        newPwdEl.attr('type','text');
        confirmPwdEl.attr('type','text');
    }
    else{
        newPwdEl.attr('type','password');
        confirmPwdEl.attr('type','password');
    }
}

function isFormValid(){
    let isNameValid = validateName();
    let isEmailValid = validateEmail();
    let isDOBValid = validateDOB();
    let isContactValid = validateContact();
    let isAddress1Valid = validateAddressLine1();
    let isAddress2Valid = validateAddressLine2();
    let isPincodeValid = validatePincode();
    let isNewPwdValid = validateNewPassword();
    let isConfirmPwdValid = validateConfirmPassword();
    let isAgreed = validateAgreement();

    return (isNameValid && isEmailValid && isDOBValid && isContactValid && isAddress1Valid && isAddress2Valid && isPincodeValid && isNewPwdValid && isConfirmPwdValid && isAgreed);
}


function isNameValid(name){
    let isValid = false, err = "";
    if(name == "" || name.trim().length == 0){
        err = "This field is required.";
    }
    else if(name.length > 60){
        err = "Name should be less than 60 characters.";
    }
    else{
        isValid = true;
    }
    return {
        isValid: isValid,
        error: err
    }
}

function isEmailValid(email){
    let isValid = false, err = "";
    let regEx = new RegExp("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");
    if(email == "" || email.trim().length == 0){
        err = "This field is required.";
    }
    else if(!regEx.test(email)){
        err = "Invalid email id.";
    }
    else{
        isValid = true;
    }
    return {
        isValid: isValid,
        error: err
    }
}


// 2021-07-15 => yyyy-mm-dd
function isDOBValid(dob){
    let isValid = false, err = "";
    if(dob == "" || dob.trim().length == 0){
        err = "This field is required.";
    }
    else{
        let seperationResult = seperateYear(dob);
        if(seperationResult.error){
            err = seperationResult.error;
        }
        else{
            let year = parseInt(seperationResult.year);
            if(year < 1900 || year > 2020){
                err = "Date out of range."
            }
            else{
                isValid = true;
            }
        }
    }
    return {
        isValid: isValid,
        error: err
    }
}

function isContactValid(contact){
    let isValid = false, err = "";
    if(contact == "" || contact.trim().length == 0){
        err = "This field is required.";
    }
    else if(isNaN(contact)){
        err = "Only digits allowed.";
    }
    else if(contact.length != 10){
        err = "Should be exactly 10 digits.";
    }
    else{
        isValid = true;
    }
    return {
        isValid: isValid,
        error: err
    }
}

function isAddressLineValid(address){
    let isValid = false, err = "";
    if(address == "" || address.trim().length == 0){
        err = "This field is required.";
    }
    else if(address.length > 80){
        err = "Should be less than 80 characters.";
    }
    else{
        isValid = true;
    }
    return {
        isValid: isValid,
        error: err
    }
}

function isPincodeValid(pincode){
    let isValid = false, err = "";
    if(pincode == "" || pincode.trim().length == 0){
        err = "This field is required.";
    }
    else if(isNaN(pincode)){
        err = "Only digits allowed.";
    }
    else if(pincode.length != 8){
        err = "Should be exactly 10 digits.";
    }
    else{
        isValid = true;
    }
    return {
        isValid: isValid,
        error: err
    }
}

function isNewPwdValid(password){
    let isValid = false, err = "";
    let regexp= new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])");
    if(password == "" || password.trim().length == 0){
        err = "This field is required.";
    }
    else if(password.length < 5 || password.length > 8){
        err = "Length should be between 5 to 8 characters.";
    }
    else if(!regexp.test(password)){
        err = "Should contain atleast 1 capital letter, 1 small letter, 1 digit and 1 special character.";
    }
    else{
        isValid = true;
    }
    return {
        isValid: isValid,
        error: err
    }
}

function isConfirmPwdValid(password){
    let isValid = false, err = "";
    if(password == "" || password.trim().length == 0){
        err = "This field is required.";
    }
    else if(password != newPwdEl.val()){
        err = "Passwords don't match.";
    }
    else{
        isValid = true;
    }
    return {
        isValid: isValid,
        error: err
    }
}

function seperateYear(dob){
    let year = null, err = null;
    let dateElements = dob.split('-');
    if(dateElements.length != 3){
        err = "Incorrect date format.";
    }
    else{
        year = dateElements[0];

        if(year == ""){
            err = "Incorrect date format.";
        }
    }
    return {
        year: year,
        error: err
    }
}