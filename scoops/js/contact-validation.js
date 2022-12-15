const successStyle = {'border-bottom': '1px solid var(--primary-color)'};
const errorStyle = {'border-bottom': '1px solid var(--danger)'};

var nameEl, nameErrorEl, emailEl, emailErrorEl, messageEl, messageErrorEl, messageLengthEl, contactFormEl;

$(()=>{
    nameEl = $('#name');
    nameErrorEl = $('#name-error');
    emailEl = $('#email');
    emailErrorEl = $('#email-error');
    messageEl = $('#message');
    messageErrorEl = $('#message-error');
    messageLengthEl = $('#message-length');
    contactFormEl = $('#contact-form');

    nameEl.blur(()=>{validateName()});
    emailEl.blur(()=>{validateEmail()});
    messageEl.blur(()=>{validateMessage()});
    messageEl.on('paste, keyup', ()=>{
        messageLengthEl.html((250 - messageEl.val().length) + " Characters Remaining");
    });
    contactFormEl.submit((e)=>{
        if(isFormValid()){
            alert("Message request sent successfully.");
            return true;
        }
        else{
            return false;
        }
    });
});

function validateName(){
    let name = nameEl.val();
    nameErrorEl.html("");
    let result = isNameValid(name);
    if(result.isValid){
        nameEl.css(successStyle);
        return true;
    }
    else{
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
        return true;
    }
    else{
        emailErrorEl.html(result.error);
        emailEl.css(errorStyle);
        return false;
    }
}

function validateMessage(){
    let message = messageEl.val();
    messageErrorEl.html("");
    let result = isMessageValid(message);
    if(result.isValid){
        messageEl.css(successStyle);
        return true;
    }
    else{
        messageErrorEl.html(result.error);
        messageEl.css(errorStyle);
        return false;
    }
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
    if(email == ""){
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

function isMessageValid(message){
    let isValid = false, err = "";
    if(message == "" || message.trim().length == 0){
        err = "Message cannot be empty.";
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
    let isNameValid = validateName();
    let isEmailValid = validateEmail();
    let isMessageValid = validateMessage();
    return (isNameValid && isEmailValid && isMessageValid);
}