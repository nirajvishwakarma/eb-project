const successStyle = {'border-bottom': '1px solid var(--primary-color)'};
const errorStyle = {'border-bottom': '1px solid var(--danger)'};

var emailEl, emailErrorEl, pwdEl, pwdErrorEl;

$(()=>{
    emailEl = $('#email');
    emailErrorEl = $('#email-error');
    pwdEl = $('#pwd');
    pwdErrorEl = $('#pwd-error');
    loginFormEl = $('#login-form');

    emailEl.blur(()=>{validateEmail()});
    pwdEl.blur(()=>{validatePassword()});

    loginFormEl.submit((e)=>{
        if(isFormValid()){
            alert("Login request sent successfully.");
            return true;
        }
        else{
            return false;
        }
    });
});

function validateEmail(){
    let email = emailEl.val();
    emailErrorEl.html("");
    let result = isEmailValid(email);
    if(result.isValid){
        emailEl.css(successStyle);
        return true;
    }
    else{
        emailErrorEl.html(result.error);
        emailEl.css(errorStyle);
        return false;
    }
}

function validatePassword(){
    let pwd = pwdEl.val();
    pwdErrorEl.html("");
    let result = isPwdValid(pwd);
    if(result.isValid){
        pwdEl.css(successStyle);
        return true;
    }
    else{
        pwdErrorEl.html(result.error);
        pwdEl.css(errorStyle);
        return false;
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

function isPwdValid(password){
    let isValid = false, err = "";
    let regexp= new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])");
    if(password == "" || password.trim().length == 0){
        err = "This field is required.";
    }
    else if(password.length < 5 || password.length > 8){
        err = "Should be 5 to 8 characters long.";
    }
    else{
        isValid = true;
    }
    return {
        isValid: isValid,
        error: err
    }
}

function isFormValid(){
    let isEmailValid = validateEmail();
    let isPwdValid = validatePassword();

    return (isEmailValid && isPwdValid);
}